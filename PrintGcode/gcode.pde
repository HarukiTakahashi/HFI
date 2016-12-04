import java.util.*;

// Gcode class ================================
class GCode {
  StrQue strQue;
  GCode(String path) {
    strQue=new StrQue(path);
  }

  int time;
  void setTime(int time) {
    this.time=time;
  }
  long startTime=-1;
  void exit() {
    strQue.exit();
  }
  String getTimeString() {
    if (!printing) {
      return null;
    }
    int s=(int)(millis()-startTime)/1000;
    int s1=time-s;
    StringBuilder sb=new StringBuilder();
    if (s1>3600) {
      sb.append(s1/3600);
      sb.append(":");
      s1=s1%3600;
    }
    if (s1>60) {
      sb.append(s1/60);
      sb.append(":");
      s1=s1%60;
    }
    sb.append(s1);
    sb.append(" left");
    return sb.toString();
  }
  void printAll(Serial port) {
    if (printing) {
      return;
    }
    print(port);
  }
  boolean printing=false;
  boolean pauseQuery=false;
  void pausePrinting() {
    pauseQuery=true;
  }
  boolean send(Serial port, String s) {
    port.write(s+"\n");
    queue++;
    return true||s.charAt(0)=='G';
  }
  void print(Serial port) {
    Print print=new Print();
    print.setPort(port);
    print.start();
  }
  int queue=0;
  void getOKFromPrinter() {
    queue--;
    if (startTime==-1) {
      startTime=millis();
    }
  }
  
  
// =====================================
// This thread manages a Queue to prevent overflowing a 3D printer's buffer
  class StrQue extends Thread {
    ArrayDeque<String> queue;
    LineReader ld=null;
    int buffer=50;
    StrQue(String path) {
      super();
      ld=new LineReader(path, null);
      queue=new ArrayDeque<String>();
      start();
    }
    String get() {
      if (queue.isEmpty()) {
        return null;
      }
      return queue.poll();
    }
    boolean isEmpty() {
      return queue.isEmpty();
    }
    int size() {
      return queue.size();
    }
    boolean exit=false;
    void exit() {
      stop();
      if (ld!=null) {
        try {
        }
        catch(Exception e) {
          ld.close();
        }
      }
    }
    public void run() {
      queue.add("G28");
      while (!ld.hadRead ()) {
        if (queue.size()<buffer) {
          if (exit) {
            return;
          }
          String str=ld.read();
          if (str==null) {
            break;
          }
          String d=str.split(";")[0];
          if (d.length()==0) {
            continue;
          }
          queue.add(d);
          continue;
        }
        long elapsed, startTime = System.nanoTime();
        do {
          elapsed = System.nanoTime() - startTime;
        } 
        while (elapsed < 1);
      }
    }
  }
  
// =====================================
// This thread sends Gcode to printers
  class Print extends Thread {
    Serial port;
    public void setPort(Serial port) {
      this.port=port;
    }
    public void run() {
      while (strQue==null||strQue.size ()<30) {
        long elapsed;
        final long startTime = System.nanoTime();
        do {
          elapsed = System.nanoTime() - startTime;
        } 
        while (elapsed < 1);
      }
      boolean hasWait=false;
      String code;
      StringBuilder sb=new StringBuilder();
      queue=0; // the number of untreated Gcode
      printing=true;
      code=strQue.get();
      hasWait=send(port, code);
      println("send code:"+code);
      println("empty "+strQue.isEmpty ());
      while (!strQue.isEmpty ()) {
        if (pauseQuery) {
          pauseQuery=false;
          printing=false;
          return;
        }
        if (!hasWait) {
          code=strQue.get();          
          hasWait=send(port, code);
          println("send code:"+code);
          continue;
        }
        while (queue>10) {
          long elapsed;
          final long startTime = System.nanoTime();
          do {
            elapsed = System.nanoTime() - startTime;
          } 
          while (elapsed < 1);
          if (pauseQuery) {
            pauseQuery=false;
            printing=false;
            return;
          }
        }
        code=strQue.get();
        hasWait=send(port, code);
        println("send code:"+code);
      }
    }
  }
}