/* ====================================================
     Project : HPI 
      Author : Haruki Takahashi
        Date : Dec 11, 2016
     Version : 1.0
    
  ====================================================
  
  The program is for mapping Printer setting with sensor data.
  This import property files ( .properties in an data directory),
  and the parameters can be used as constant value.
  (Please checck Properties Tab)
  
  ==================================================== */

import java.io.*;
import java.util.Properties;
import java.lang.reflect.*;

void setup() {

  PrinterSetting.importProperty(dataPath("PrinterSetting.properties"));
  SensorRange.importProperty(dataPath("SensorRange.properties"));

  // test =======================
  // print all parameters
  println(" ===== Printer Setting =====");
  PrinterSetting.print();

  println(" ===== Sensor Range =====");
  SensorRange.print();

  println(" ===== THAT'S ALL =====");
  println(); 

  // use a parameter
  println(" ===== Parameter Check =====");
  println("PRINTER_BASE_X : " + PrinterSetting.PRINTER_BASE_X);
  println("PRINTER_BASE_Y : " + PrinterSetting.PRINTER_BASE_Y);
  println("PRINTER_BASE_Z : " + PrinterSetting.PRINTER_BASE_Z);

  // !!! this substitution is available !!!
  // I'd like to prevent it...
  PrinterSetting.PRINTER_BASE_X = 100;

}