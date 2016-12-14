/* ====================================================
 Project : HPI
 Author : Haruki Takahashi
 Date : Dec 3, 2016

 ==================================================== */

import processing.serial.*;
import java.util.regex.*;
import java.io.*;
import java.util.Properties;
import java.lang.reflect.*;

// ********** Printer **********
// String PRINTER_PORT = "COM7";
// int PRINTER_BAUDRATE = 250000;

String PORT [] = Serial.list();
String PRINTER_PORT = "/dev/cu.usbmodem1421";
int PRINTER_BAUDRATE = 57600;

// ********** Sensors (Arduino) **********
// String SENSOR_PORT = "COM3";
// int SENSOR_BAUDRATE = 9600;

String SENSOR_PORT = "/dev/cu.usbmodem1411"; //do we need sensor port?
int SENSOR_BAUDRATE = 9600;

// size of Queue
// up to 128?
int bufferSize = 64;

Serial printer=null;
Serial sensor=null;
GcodeQueue gcode;

// By adding a gcode (string) into this Queue using .add(),
// this program sends gcode to 3D printer
Queue tmp;

// setup =======================================
void setup() {
  size(600, 600);

  PrinterSetting.importProperty(dataPath("PrinterSetting.properties"));
  SensorRange.importProperty(dataPath("SensorRange.properties"));

  printer = connectPrinter(PRINTER_PORT, PRINTER_BAUDRATE);
  sensor = connectSensor(SENSOR_PORT, SENSOR_BAUDRATE);

  println(PORT); //see all available port list

  // Queue
  gcode = new GcodeQueue(bufferSize);
  tmp = new Queue(10000); // sufficiently large size

  // Thread
  QueueManage QM = new QueueManage(gcode, tmp);
  Sender reader = new Sender(gcode);
  QM.start();
  reader.start();

}


// Test =======================================
void draw() {

}

// create gcode using argments
String createGcode(String g, float x, float y, float z, float e, float f) {
  return g + " X" + String.format("%1$.0f", x) + " Y" + y + " Z" + z + " E" + e + " F" + String.format("%1$.0f", f) + "\n"; // newline character is needed!
}

// this method called from serialEvent()
float x = 50, y = 50, z = 10, e = 0, f = 4800;
void variableResistance(float vr_value) {

  // mapping
  // String [] value = split(vr_value, ':');
  // println("sensor: " + value[0] + "value: " + value[1]);
  if(vr_value < 10000) //light values
    f = vr_value;//this is already calibrated from SensorValue
  else if(vr_value < 100000) //flex sensor values
    z = vr_value - 10000;
  else if(vr_value < 10000000) //pot slider values
    x = vr_value - 1000000;
  // float x = (vr_value / SensorRange.VARIABLE_RESISTANCE_MAX ) * PrinterSetting.PRINTER_BASE_X;

  println("x: " + x + ", z: " + z + ", f: " + f);

  String g = createGcode("G1", x, 0, z, 0, f); // G1, X, Y, Z, E, F
  // debug
  //println(g);
  tmp.add(g);
 //tmp.add("M105\n");
}


void mouseClicked(){
 tmp.add("M105\n");
 // tmp.add("M112\n"); //consider stop right away and reset
}

// Test =======================================
