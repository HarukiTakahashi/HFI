// connectSerial =======================================
Serial connectPrinter(String com, int baud) {
  Serial tmp=new Serial(this, com, baud);
  try {
    Thread.sleep(3000);
  }
  catch(Exception e) {
  }


  // check the connection ==========
  tmp.write("G28\n");// home position
  println("send to pinter: G28");
  tmp.write("G90\n");// home position
  println("send to pinter: G90");
  
  tmp.write("M83\n");// home position
  println("send to pinter: M83");
  
  
  tmp.write("M84\n");// unlock motors
  println("send to pinter: M84");
  tmp.write("G1 Z0.5\n");// unlock motors
  println("send to pinter: G1 Z10");
  tmp.write("M104 S220\n");// unlock motors
  println("send to pinter: M104 S220");
  
  // check the connection ==========
  
  
  return tmp;
}

// =======================================
// Called when data is available.
// Use readString() method to capture this data.
StringBuilder sb=null;
void serialEvent(Serial thisPort) {
  // println("serial event is triggered");
  
  byte[] buf = thisPort.readBytesUntil('\n');
  if(buf != null){
    String str=new String(buf);
    str = str.trim();
      println(str);
      
      // If 3D printer returns "ok" after recieving a data
      if(str.indexOf("ok") != -1){
        gcode.setAccess(true);
      }
  }
}