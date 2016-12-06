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
  tmp.write("M84\n");// unlock motors
  println("send to pinter: M84");
  tmp.write("G1 Z10\n");// unlock motors
  println("send to pinter: G1 Z10");
  // check the connection ==========
  
  
  return tmp;
}

// =======================================
// Called when data is available.
// Use readString() method to capture this data.
StringBuilder sb=null;
void serialEvent(Serial thisPort) {
  if (sb==null) {
    sb=new StringBuilder();
  }
  String readSt=thisPort.readString();
  if (readSt.equals("\n")) {
    //println(sb);
    String str=sb.toString();
    if (str.indexOf("T:")!=-1) {
    } else if (str.equals("ok")) {
      println("3Dprinter: " + str);
      
      // If 3D printer returns "ok" after recieving a data
      gcode.setAccess(true);
      
    } else {
      //println("3Dprinter: " + str);
    }
    sb=null;
    return;
  }
  sb.append(readSt);
}