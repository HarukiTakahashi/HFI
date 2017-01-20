// *********************************************************************
//
//  Thread
//
//  Two threads run in parallel with main thread.
//  * "Printing Thread" transfers a gcode (from .gcode file) to a queue to print a object.
//  * "Sender Thread" continues to send a gcode in a queue to a printer.
//
// *********************************************************************

class Printing extends Thread {
  private boolean running;
  private GcodeQueue q;
  private Model m;

  // constructor
  public Printing(Model m, GcodeQueue gq) {
    this.q = gq;
    this.m = m;
    this.running = false;
  }

  public void run() {

    // transfer a gcode in m (Model) to queue
    if (running) {
      // send start code
      for (int i = 0; i < m.startCode.size(); i++) {
        try {
          Thread.sleep(1);
          Gcode g = m.getStartCode(i);
          q.add(g);
        }
        catch (InterruptedException e) {
        }
      }

      // send layers
      for (int i = 0; i < m.layer.size(); i++) {
        for (int j = 0; j < m.layer.get(i).gcode.size(); j++) {
          try {
            Thread.sleep(1);
            Gcode g = m.getGcode(i, j);
            q.add(g);
          }
          catch (InterruptedException e) {
          }
        }
      }

      // send end code
      for (int i = 0; i < m.endCode.size(); i++) {
        try {
          Thread.sleep(1);
          Gcode g = m.getEndCode(i);
          q.add(g);
        }
        catch (InterruptedException e) {
        }
      }
    }
  }

  public void setRunning(boolean b) {
    running = b;
  }

  public boolean getRunning() {
    return running;
  }
}


// ********************************************************************************
//  continue to send gcode to printer
// ********************************************************************************
class Sender extends Thread {
  private boolean running;
  private GcodeQueue q;

  // constructor
  public Sender(GcodeQueue q) {
    this.q = q;
    this.running = false;
  }

  public void run() {
    while (running) {
      while (!q.access) {
        try {
          Thread.sleep(1);
        }
        catch (InterruptedException e) {
        }
      }

      Gcode g = q.poll();

      // Debug

        println(" * send to printer : " + g.toString());
        printer.write(g.toString());
        
      if (g.cmd.indexOf("G") != -1 || g.cmd.indexOf("M") != -1) {
        // when finished to send a data
        // if sent gcode is comment ( ; ), acceses does not be changed
        q.setAccess(false);
      }
    }
  }

  public void setRunning(boolean b) {
    running = b;
  }
}