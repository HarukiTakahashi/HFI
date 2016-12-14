/*
  By loading .gcode file, this sends it to printer using serial communication.

  Log
    XX/XX/2016  Yoh Akiyama  implemented whole program
    04/12/2016  Haruki Takahashi  modified it and added comments

  ** CAUTION **

    This program is specialized for CuraEngine's Gcode format.
  
  *************
*/


import processing.serial.*;
import java.util.regex.*;

Serial printer=null;
GCode gcode=null;


// Please change here ==========
//String PORT = "COM5";
//int BAUDRATE = 250000;
//String FILENAME = "test.gcode";

String PORT = Serial.list()[0];
int BAUDRATE = 57600;
String FILENAME = "cube.gcode";

void setup() {
  size(640, 480, P3D);
    
  connectPrinter(PORT,BAUDRATE);
  gcode=new GCode(dataPath(FILENAME));
  
  startPrint();
}


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
      println(str);
      if (gcode!=null) {
        gcode.getOKFromPrinter();
      }
    } else {
      println(str);
    }
    sb=null;
    return;
  }
  sb.append(readSt);
}