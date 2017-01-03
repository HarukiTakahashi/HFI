import java.util.*;
import java.util.concurrent.*;

import processing.serial.*;
import java.util.regex.*;

import Jama.Matrix;

import com.leapmotion.leap.*;
import com.leapmotion.leap.processing.LeapMotion;

// ===============================================
// LeapMotion
LeapMotion leapMotion;
// LeapMotion Controller Event Listener
LeapListener listener = new LeapListener();

ConcurrentMap<Finger, PVector> fingerPositions;
int calibFlag = -1;

PVector[] calibration;

boolean DrawingFlag = false;
int move_y = 200;


// ********** Please chage here **********
String PORT = "COM7";
int BAUDRATE = 250000;

//String PORT = Serial.list()[0];
//String PORT = "/dev/cu.usbmodem1421";
//int BAUDRATE = 57600;

// size of Queue
// up to 128?
int bufferSize = 64;

Serial printer=null;
GcodeQueue gcode;

// By adding a gcode (string) into this Queue using .add(),
// this program sends gcode to 3D printer
Queue tmp;
// ===============================================

void setup()
{
  size(640, 640);

  leapMotion = new LeapMotion(this);
  leapMotion.controller().addListener(listener);

  fingerPositions = new ConcurrentHashMap<Finger, PVector>();
  calibration = new PVector[4];
  for (int i = 0; i < 4; i++) {
    calibration[i] = new PVector(0, 0, 0);
  }

  printer = connectPrinter(PORT, BAUDRATE);

  // Queue
  gcode = new GcodeQueue(bufferSize); 
  tmp = new Queue(10000); // sufficiently large size

  // Thread
  QueueManage QM = new QueueManage(gcode, tmp);
  Sender sender = new Sender(gcode);
  QM.start();
  sender.start();
  
  textSize(16);
}

void draw()
{
  if (calibFlag != -1) {
    background(0);
  } else {
    background(120);
  }

  String fingerCondition = "not detected";
  PVector position = new PVector(0, 0, 0);

  for (Map.Entry entry : fingerPositions.entrySet())
  {
    Finger finger = (Finger) entry.getKey();
    String fingerName = finger.type().name();
    if (fingerName == "TYPE_INDEX" && finger.isExtended()) {
      position = (PVector) entry.getValue();
      //println("ID:" + fingerName + " x:" + position.x + " y:" + position.y + " z:" + position.z);
      fingerCondition = "ID:" + fingerName + "\n x:" + position.x + "\n y:" + position.y + "\n z:" + position.z;

      // mapping
      PVector posOnSketch = mapping(position);
      if (posOnSketch != null) {
        text("Mapped \n x:"  + posOnSketch.x + "\n y:" + posOnSketch.y, 200, 50);

        if (DrawingFlag) {
          gcode.setAccess(false);
          String g = "G1" + " X"+posOnSketch.x + " Y"+posOnSketch.y+" F3600\n";
          tmp.add(g);
        }
      }

      break;
    }
  }



  text(fingerCondition, 10, 50);
  drawInfo();
}


void drawInfo() {  
  text("upper left \n x:"  + calibration[0].x + "\n y:" + calibration[0].y, 0, 180);
  text("upper right \n x:" + calibration[1].x + "\n y:" + calibration[1].y, 150, 180);
  text("lower right \n x:"  + calibration[2].x + "\n y:" + calibration[2].y, 300, 180);
  text("lower left \n x:" + calibration[3].x + "\n y:" + calibration[3].y, 450, 180);

  if (calibFlag == -1) {
    text("press C : calibration", 10, 20);
  } else {
    if (calibFlag == 0) {
      text("press C : Upper Left", 10, 20);
    }  
    if (calibFlag == 1) {
      text("press C : Upper Right", 10, 20);
    }  
    if (calibFlag == 2) {
      text("press C : Lower Right", 10, 20);
    }  
    if (calibFlag == 3) {
      text("press C : Lower Left", 10, 20);
    }
  }

  text("press M : move extruder : Y"+move_y, 10, 500);

  if (DrawingFlag) {
    text("press S : stop drawing", 10, 520);
  } else {
    text("press S : start drawing", 10, 520);
  }
}

// Homography 
PVector mapping(PVector p) {
  PVector[] origin = new PVector[4];
  origin[0] = new PVector(0, 150);
  origin[1] = new PVector(200, 150);
  origin[2] = new PVector(200, 0);
  origin[3] = new PVector(0, 0);

  float[] sys = getSystem(calibration, origin);
  if (sys == null) {
    return null;
  }

  PVector mapped = invert(p.x, p.z, sys);

  //println("px : " + mapped.x + " py:" + mapped.y);
  return mapped;
}


void keyPressed() {
  if (key == 'c') {
    if (calibFlag != -1) {
      for (Map.Entry entry : fingerPositions.entrySet())
      {
        Finger finger = (Finger) entry.getKey();
        String fingerName = finger.type().name();
        if (fingerName == "TYPE_INDEX" && finger.isExtended()) {
          PVector position = (PVector) entry.getValue();
          println("Calibrated! x:" + position.x + " y:" + position.y + " z:" + position.z);
          calibration[calibFlag] = new PVector(position.x, position.z);
        }
      }
    }
    calibFlag++;

    if (calibFlag > 3) {
      calibFlag = -1;
    }
  }
  if (key == 'm') {
    String g = "G1 Y" + move_y + " F3600";
    tmp.add(g + "\n");
  }
  if (key == 's') {
    if (!DrawingFlag) {
      DrawingFlag = true;
      gcode.setAccess(false);
    } else {
      DrawingFlag = false;
      gcode.setAccess(true);
    }
  }
}