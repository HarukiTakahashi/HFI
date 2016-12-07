/*
  When you click on the Window, this program
  - sends "M105" to 3D printers
  - prints printer's reposonse
*/

// Library
import processing.serial.*;
Serial test;

// Haruki's printer setting (Windows & NinjaPrinter)
 String PORT = "COM7";
 int BAUDRATE = 250000;

// for Sikuli Lab setting (Mac & PrintrBot)
//String PORT = "/dev/cu.usbmode1421";
//String PORT = Serial.list()[0];
//int BAUDRATE = 115200;


// SETUP ==========
void setup(){
  size(640, 360);
  textAlign(CENTER);
  textSize(30);
  test = new Serial(this, PORT, BAUDRATE);
}

// DRAW ==========
void draw(){
  background(51);
  text("click here",height/2,width/2);
}


// SerialEvent ==========
// Called when data is available. 
void serialEvent(Serial thisPort) {
  byte[] buf = thisPort.readBytesUntil('\n');
  if(buf != null){
  String str=new String(buf);
  str = str.trim();
    println(str);
  }
}

// mouseClicked ==========
// send a Gcode
void mouseClicked(){
  test.write("M105\n");
}