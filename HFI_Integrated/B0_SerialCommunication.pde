// *********************************************************************
//
//  Serial communication
//
// *********************************************************************

// connectSerial =======================================
Serial connectPrinter(String com, int baud) {
  Serial tmp=new Serial(this, com, baud);
  InfoWin.printInfo("connecting...");
  
  try {
    Thread.sleep(3000);
  }
  catch(Exception e) {
    InfoWin.printInfo("counld not connet to printer");
  }

  // check the connection ==========
  tmp.write(CONNECT_CODE);// home position
  InfoWin.printInfo(CONNECT_CODE);

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
          InfoWin.printInfo(str);

          // If 3D printer returns "ok" after recieving a data
          if (str.indexOf("ok") != -1) {
            queue.setAccess(true);
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
          // variableResistance(Float.parseFloat(str));
          // variableResistance(str); // to read multiple sensor values with tag
        }
      }
    }
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}