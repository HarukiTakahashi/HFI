/*
  When you click on the Window, this program
  - sends "M105" to 3D printers
  - prints printer's reposonse
*/

// Library
import processing.serial.*;
Serial test;

// Haruki's printer setting
// String PORT = "COM7";
// int BAUDRATE = 250000;

// Please chage here
String PORT = "COM7";
int BAUDRATE = 250000;


// SETUP ==========
void setup(){
  size(256, 256);
  textAlign(CENTER);
  textSize(30);
  test = new Serial(this, PORT, BAUDRATE);
}

// DRAW ==========
void draw(){
  text("click here",height/2,width/2);
}


// SerialEvent ==========
// Called when data is available. 
StringBuilder sb=null;
void serialEvent(Serial thisPort) {
  if (sb==null) {
    sb=new StringBuilder();
  }
  String readSt=thisPort.readString();
  if (readSt.equals("\n")) {
    String str=sb.toString();
    
    println(str); // print
    
    sb=null;
    return;
  }
  sb.append(readSt);
}

// mouseClicked ==========
// send a Gcode
void mouseClicked(){
  test.write("M105\n");
}