// *********************************************************************
//
//  Project  :  HFI
//  Author   :  Haruki Takahashi
//  
//  Processing 3.2.3
//    * I will add comments and make specification clear... 
//  
// *********************************************************************

// *********************************************************************
// import library 
// *********************************************************************
import java.io.*;  
import processing.awt.PSurfaceAWT;
import java.util.function.*;
import java.util.*;
import controlP5.*;
import processing.serial.*;


// *********************************************************************
//  setup
// *********************************************************************
void setup() {
  surface.setVisible(false); 
  // generate child windows
  MainWin = new MainWindow(this);
  MenuWin = new MenuWindow(this);
  InfoWin = new InfoWindow(this);

  // load properties
  PrinterSetting.importProperty(dataPath("PrinterSetting.properties"));
  SensorRange.importProperty(dataPath("SensorRange.properties"));
  String DEFAULT_GCODE = dataPath("box_wo_waitcode.gcode");

  queue = new GcodeQueue(128);

  MenuWin.sub_load(DEFAULT_GCODE);
}


// *********************************************************************
// control printing process
// *********************************************************************
void StartPrinting() {
  printingThread = new Printing(model, queue);
  senderThread = new Sender(queue);

  printingThread.setRunning(true);
  senderThread.setRunning(true);
  printingThread.start();
  senderThread.start();
  printer.write("; start\n");
  InfoWin.printInfo("Start printing");
}

void StopPrinting() {
  printingThread.setRunning(false);
  senderThread.setRunning(false);
  printer.write("M104 S0\nM140 S0\n");
  queue.clear();
}