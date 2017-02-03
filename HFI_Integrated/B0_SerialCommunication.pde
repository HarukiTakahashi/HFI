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
  InfoWin.printInfo("printer is connected! [ Port : " + com + " , Baudrate : " + baud + " ]");

  return tmp;
}

// connectSerial =======================================
Serial connectSensor(String com, int baud) {
  Serial tmp=new Serial(this, com, baud);
  InfoWin.printInfo("connecting...");
  try {
    Thread.sleep(1000);
  }
  catch(Exception e) {
    // InfoWin.printInfo("could not cennect to sensor");
  }

  InfoWin.printInfo("sensors are connected! [ Port : " + com + " , Baudrate : " + baud + " ]");
  return tmp;
}


// ingore first several messages
int discardCount = 0;

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
          // debug
          println(" - printer message > " + str);


          // If 3D printer returns "ok" after recieving a data
          if (str.indexOf("ok") != -1) {
            queue.setAccess(true);
          }
        }
      }
    }

    if (sensor != null) {
      if (thisPort == sensor) {

        if (discardCount < 100) {
          discardCount++;
          return;
        }

        byte[] buf = thisPort.readBytesUntil('\n');
        if (buf != null) {
          String str=new String(buf);
          str = str.trim();
          // debug
          //println(" - sensors message > " + str);
          // e.g., Photocell:854,Flex:567,Temp:38,Potentiometer:5,Proximity:46

          String[] NameColonValue = str.split(",");
          for (int i = 0; i < NameColonValue.length; i++) {
            if (NameColonValue[i].indexOf(":") != -1) {
              //println(i + " "+NameColonValue[i]);
              String sensorName = NameColonValue[i].split(":")[0];
              String sensorValue = NameColonValue[i].split(":")[1];

              if (SensorMap.containsKey(sensorName)) {
                Sensor s = SensorMap.get(sensorName);
                s.addValue(Float.parseFloat(sensorValue));
              }
            }
          }
          // debug
          //for (String sensorName : SensorMap.keySet()) {
          //  println("val : " + SensorMap.get(sensorName).values.get(SensorMap.get(sensorName).values.size()-1));
          //}
          if (str!= "") {
            try {
              MainWin.drawMethods.add(MainWin.getClass().getMethod("drawSensorValues", null));
              MainWin.drawMethodArg.add(null);
            } 
            catch (Exception ex) {
              ex.printStackTrace();
            }
          }
        }
      }
    }
  }
  catch(RuntimeException e) {
    e.printStackTrace();
  }
}