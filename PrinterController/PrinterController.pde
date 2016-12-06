/* ====================================================
     Project : HPI 
      Author : Haruki Takahashi
        Date : Dec 7, 2016
     Version : 1.0
  
  Useage
    please edit the way of adding gcode into Queue.
  
    e.g., this program adds coordinates during mouse dragging ( void mouseDragged() )
      createGcode("G1",mapX,mapY,0,0,3600);
      tmp.add(g);
  
  ====================================================
  
  This program manages:
  Queues (Queue tab)
     - Queue: keeping data temporarily (to prevent overflowing)
     - GcodeQueue: keeping gcode only an amount of bufferSize
     
  Threads (Control tab)
    - QueueManage: transfer a data from Queue to GcodeQueue if there is space in GcodeQueue
    - Sender: send gcode to printer if the "access" field in GcodeQueue is true
              and then, set the field to false 
  
  If 3D printer returns "ok" after recieving a data,
  the access field is set true in void serialEvent()
  
 ==================================================== */

import processing.serial.*;
import java.util.regex.*;


// ********** Please chage here **********
String PORT = "COM7";
int BAUDRATE = 250000;

// size of Queue
// up to 128?
int bufferSize = 64;

Serial printer=null;
GcodeQueue gcode;

// By adding a gcode (string) into this Queue using .add(),
// this program sends gcode to 3D printer
Queue tmp;

// setup =======================================
void setup() {
  size(600, 600);
  
  printer = connectPrinter(PORT, BAUDRATE);
  
  // Queue
  gcode = new GcodeQueue(bufferSize); 
  tmp = new Queue(10000); // sufficiently large size
  
  // Thread
  QueueManage QM = new QueueManage(gcode,tmp);
  Sender reader = new Sender(gcode);
  QM.start();
  reader.start();
}


// Test =======================================
void draw(){

}

// create gcode using argments
String createGcode(String g, float x, float y, float z, float e, float f){
  return g + " X" + x + " Y" + y + " Z" + z + " E" + e + " F" + f + "\n"; // newline character is needed!
}

void mouseDragged(){
  float mapX = ((float)mouseX / (float)width) * 150; // mapping 
  float mapY = (abs(height-mouseY) / (float)height) * 150; // mapping
    
  // Debug
  ellipse(mouseX,mouseY,10,10);
  
  String g = createGcode("G1",mapX,mapY,0,0,3600); // G1, X, Y, Z, E, F
  // debug
  //println(g);
  tmp.add(g);

}

// clear screen
void mouseClicked(){
  background(200);
}
// Test =======================================