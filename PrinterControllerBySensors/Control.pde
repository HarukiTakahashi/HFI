// transfer a data from Queue to GcodeQueue
class QueueManage extends Thread {
  private GcodeQueue gq;
  private Queue q;

  // constructor
  public QueueManage(GcodeQueue gq, Queue q) {
    this.gq = gq;
    this.q = q;
  }

  public void run() {
    while (true) {
      // accessible ?
      while (!gq.access) {
        try {
          Thread.sleep(1);
        } 
        catch (InterruptedException e) {
        }
      }
      Object obj = q.poll();
      gq.add(obj);
    }
  }
}

// Continue to send gcode to printer
class Sender extends Thread {
  private GcodeQueue q;

  // constructor
  public Sender(GcodeQueue q) {
    this.q = q;
  }

  public void run() {
    while (true) {
      // accessible ?
      while (!q.access) {
        try {
          Thread.sleep(1);
        } 
        catch (InterruptedException e) {
        }
      }
      Object obj = q.poll();

      // Debug
      print(" * send to printer : "+obj.toString());
      printer.write(obj.toString());

      // when finished to send a data
      q.setAccess(false);
    }
  }
}