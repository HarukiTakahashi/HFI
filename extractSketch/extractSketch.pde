// *********************
//
//  2D sketch to 2D polygon (in .scad)
//
//    Press enter 
//
// *********************


// these are a threshold for extracting "red" pixels as HSV
// in HSV, the Hue of red is around 0 to 10 and 170 10 180

Scalar thre1_min = new Scalar(  0,  50,  50);
Scalar thre1_max = new Scalar( 10, 255, 255);
Scalar thre2_min = new Scalar(170,  50,  50);
Scalar thre2_max = new Scalar(180, 255, 255);

// note: Scalar(hue, saturation, brightness)
//          hue : 0 to 180  (in OpenCV)
//   saturation : 0 to 255
//    brihtness : 0 to 255


// library **************************************
import imageTranslater.*;
import java.util.Arrays;
import java.util.List;
import java.lang.*;

// *** Please add these libraries  
// (menu) Sketch -> Import library(?) -> add (?)
import processing.video.*;
import org.opencv.core.*;
import org.opencv.imgproc.*;
import org.opencv.highgui.*;
import org.opencv.features2d.*;
// library **************************************


// global ***************************

// this is an instance of ImageTranslater Class (Library)
// converts PImage (Processing) to and from Mat (OpenCV)
ImageTranslater imgTrans;

Capture capture;
PImage captured;

Rect trimming;
int trimX = 0;
int trimY = 0;

// flag
boolean capFlag = false;
boolean processFlag = false;



// ***************************
//  setup
// ***************************
void setup() {
  size(1280, 480);  // width : 640 + 320*2 (right space for debug) 

  // for openCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  imgTrans = new ImageTranslater(this);

  // to be implemetned
  trimming = new Rect(0, 0, 0, 0);

  // show available camera setting
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++) {
    println(i + " : " + cameras[i]);
  }

  String camName = cameras[14];

  capture = new Capture(this, 640, 480, camName);
  capture.start();
}

// ***************************
//  draw
// ***************************
void draw() {

  // please see ImageProcessing Tab
  ImageProcessing();


  // debug ****
  if (!processFlag) {
    ColorPicker( capture );
  }
}

// Color picker to set thresholds
void ColorPicker(PImage img) {
  color c = img.pixels[mouseX + (img.width * mouseY)];
  fill(c);
  rect(mouseX-10, mouseY-30, 20, 20);
  fill(color(0));
  text("H:" +   nf(hue(c), 3, 1) + " S:" + nf(saturation(c), 3, 1) + " B: " + nf(brightness(c), 3, 1), mouseX, mouseY-40);
}

// event
void keyPressed() {
  if (keyCode == ENTER) {
    if (!capFlag) {
      captured = capture;
      capFlag = true;
    } else {
      capFlag = false;
      processFlag = false;
    }
  }
}