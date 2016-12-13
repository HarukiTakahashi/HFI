import java.util.LinkedList;

// GcodeQUEUE =====================================================
class GcodeQueue extends Queue {
  boolean access;

  public GcodeQueue(int limit) {
    super(limit);
    this.access = false;
  }
  
  public void setAccess(boolean b){
    this.access = b;
  }
  
    synchronized public Object poll() {
    while (queue.size() == 0) {
      try {
        wait();
      } 
      catch (InterruptedException e) {
      }
    }
    Object obj = queue.removeLast();
    notifyAll();
    return obj;
  }
}

// QUEUE =====================================================
class Queue {
  LinkedList queue;
  int limitNum;

  public Queue(int limit) {
    this.queue = new LinkedList();
    this.limitNum = limit;
  }

  public int size() {
    return this.queue.size();
  }

  synchronized public void add(Object obj) {
    while (queue.size() >= limitNum) {
      // println("Full!" + limitNum);
      try {
        wait();
      } 
      catch (InterruptedException e) {
      }
    }
    queue.addFirst(obj);
    notifyAll();
  }

  synchronized public Object poll() {
    while (queue.size() == 0) {
      try {
        wait();
      } 
      catch (InterruptedException e) {
      }
    }
    Object obj = queue.removeLast();
    notifyAll();
    return obj;
  }
}