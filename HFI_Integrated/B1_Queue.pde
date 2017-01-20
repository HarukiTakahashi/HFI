// *********************************************************************
//
//  Queue
//
//  This collection keeps gcodes before sending it to a printer.
//  Main methods are synchronized;
//    if a resource, which is accesses by a thread, is locked or invaild,
//    the thread will temporarily stop at a wait() method.
//
// *********************************************************************


class GcodeQueue {
  private LinkedList<Gcode> queue;
  private boolean access;
  private int limitNum;

  public GcodeQueue(int limit) {
    this.queue = new LinkedList();
    this.limitNum = limit;
    access=false;
  }

  synchronized public int size() {
    return this.queue.size();
  }

  // put a data into queue
  synchronized public void add(Gcode g) {
    while (queue.size() >= limitNum) {
      try {
        wait();
      } 
      catch (InterruptedException e) {
      }
    }
    queue.addFirst(g);
    notifyAll();
  }

  // get a data from queue
  synchronized public Gcode poll() {
    while (queue.size() <= 0) {
      try {
        wait();
      } 
      catch (InterruptedException e) {
      }
    }

    Gcode g = queue.removeLast();
    notifyAll();
    return g;
  }

  synchronized public void setAccess(boolean b) {
    access = b;
  }
  
  public void clear(){
   queue.clear();
  }
}