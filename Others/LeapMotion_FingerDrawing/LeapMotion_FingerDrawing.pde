import java.util.*;
import java.util.concurrent.*;

import Jama.Matrix;

import com.leapmotion.leap.*;
import com.leapmotion.leap.processing.LeapMotion;

// LeapMotion
LeapMotion leapMotion;
// LeapMotion Controller Event Listener
LeapListener listener = new LeapListener();


ConcurrentMap<Finger, PVector> fingerPositions;
int calibFlag = -1;

PVector[] calibration;
// 0: upper left, 1: upper right, 2: lower left, 3: lower right

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
    }
  }
  text(fingerCondition, 10, 50);
  drawInfo();


  PVector posOnSketch = mapping(position);
  if (posOnSketch != null) {
    ellipse(posOnSketch.x, posOnSketch.y, 10, 10);
  }
}


void drawInfo() {
  text("upper left \n x:"  + calibration[0].x + "\n z:" + calibration[0].y, 0, 180);
  text("upper right \n x:" + calibration[1].x + "\n z:" + calibration[1].y, 150, 180);
  text("lower right \n x:"  + calibration[2].x + "\n z:" + calibration[2].y, 300, 180);
  text("lower left \n x:" + calibration[3].x + "\n z:" + calibration[3].y, 450, 180);

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
}

// Homography 
PVector mapping(PVector p) {
  PVector[] origin = new PVector[4];
  origin[0] = new PVector(0, 0);
  origin[1] = new PVector(width, 0);
  origin[2] = new PVector(width, height);
  origin[3] = new PVector(0, height);



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
}