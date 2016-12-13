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
  tmp.write("G90\n");
  println("send to pinter: M84");
  tmp.write("G1 Z2\n");// unlock motors
  println("send to pinter: G1 Z2");
  // check the connection ==========

  return tmp;
}

// connectSerial =======================================
Serial connectSensor(String com, int baud) {
  Serial tmp=new Serial(this, com, baud);
  try {
    Thread.sleep(3000);
  }
  catch(Exception e) {
  }

  return tmp;
}

// =======================================
// Called when data is available.
// Use readString() method to capture this data.
void serialEvent(Serial thisPort) {
  try {
    if (printer != null) {
      if (thisPort == printer) {
        byte[] buf = thisPort.readBytesUntil('\n');
        if (buf != null) {
          String str=new String(buf);
          str = str.trim();
          println(" - printer message > " + str);

          // If 3D printer returns "ok" after recieving a data
          if (str.indexOf("ok") != -1) {
            gcode.setAccess(true);
          }
        }
      }
    }  
    if (sensor != null) {
      if (thisPort == sensor) {
        byte[] buf = thisPort.readBytesUntil('\n');
        if (buf != null) {
          String str=new String(buf);
          str = str.trim();
          println(" - sensors message > " + str);
          variableResistance(Float.parseFloat(str));
        }
      }
    }
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}