// ==================================================
// References
//
// * Camera Image
//     https://developer.leapmotion.com/documentation/java/devguide/Leap_Images.html
// * Sdk 2.1 (raw data) get pixel position (xyz)
//     https://community.leapmotion.com/t/sdk-2-1-raw-data-get-pixel-position-xyz/1604/12
// * Depth extraction of image from Leap motion
//     https://community.leapmotion.com/t/depth-extraction-of-image-from-leap-motion/5631
//
// ==================================================

import com.leapmotion.leap.*;

class LeapListener extends Listener {
  public void onConnect(Controller controller) {
    println("Leapmotion is connected");
  }
  public void onFrame(Controller controller) {
  }
}

// LeapMotion Controller
Controller controller;
// LeapMotion Controller Event Listener
LeapListener listener;

// setup() ==========================================
void setup() { 
  size(400, 400);
  smooth();
  background(255);
  textSize(16);
  controller = new Controller();
  listener = new LeapListener();

  controller.addListener(listener);
  controller.setPolicy(Controller.PolicyFlag.POLICY_IMAGES);
}

// draw() ==========================================
void draw() {
  func1();
}

// method ==========================================
void func1() {
  background(255);
  stroke(color(0, 0, 0));
  fill(color(255));

  // draw the size of leapmotion 
  // the dimensions of the device are 80mm x 30mm (x 11.25mm)
  rect(width /2-40, height/2-15, 80, 30);
  fill(color(255, 0, 0));  
  
  // draw grid
  line(width /2, 0, width/2, height);
  line(0, height/2, width, height/2);
  text("LeapMotion", width/2-40, height/2+8);

  Frame frame = controller.frame();  
  if (frame.isValid()) {
    
    calcPosFromStereoImages(frame);
    
  }
}


// calculate a position from stereo images
public void calcPosFromStereoImages(Frame frame) {
  // PImage camera = createImage(WIDTH, HEIGHT, RGB);
  // camera.loadPixels();
  FingerList fl = frame.fingers();

  // two pictures can be captured (left and right cam)
  // following code can get a image of a certain frame (the same with above one)  
  ImageList images = frame.images();

  println("==========");
  
  for (Finger f : fl)
  {
    // convert finger tip position to a ray from the camera POV
    // "20" in the following code means the distance between a camea and te center of leap
    Vector tip = f.tipPosition();
    int i;
    i = 0;
    float horizontal_slope_left = -(tip.getX() + 20 * (2 * i - 1))/tip.getY();
    float vertical_slope_left = -tip.getZ()/tip.getY();

    i = 1;
    float horizontal_slope_right = -(tip.getX() + 20 * (2 * i - 1))/tip.getY();
    float vertical_slope_right = -tip.getZ()/tip.getY();

    // get stereo images
    Image image_left = images.get(0);
    Image image_right = images.get(1);
    // correct the distortion
    // https://developer.leapmotion.com/documentation/java/devguide/Leap_Images.html
    Vector warped_left = image_left.warp(new Vector(horizontal_slope_left, vertical_slope_left, 0));
    Vector warped_right = image_right.warp(new Vector(horizontal_slope_right, vertical_slope_right, 0));

    Vector slopes_left = image_left.rectify(warped_left);
    Vector slopes_right = image_right.rectify(warped_right);

    // calculate the tip's position from slopes
    float z = 40/(slopes_right.getX() - slopes_left.getX());
    float y = z * slopes_right.getY();
    float x = z * slopes_right.getX() - 20;
    Vector position = new Vector(x, -z, y);
    
    // Debug: we can observe the same value
    // println("Tip calc: " + f.type() + " Position : " + position);
    // println("Tip leap: " + f.type() + " Position : " + tip.toString());

    // draw the tip's position on XY plane, and
    // the distance between tip pos and the center of leapmotion
    // (currently, z-pos is ignored)
    stroke(color(0, 0, 0));
    float fScrPosX = position.getX() + width /2;
    float fScrPosY = position.getZ() + height/2;

    ellipse(fScrPosX, fScrPosY, 10, 10);
    stroke(color(255, 0, 0));
    line(width /2, height/2, fScrPosX, fScrPosY);

    float len = dist(width /2, height/2, fScrPosX, fScrPosY);
    text(String.format("%1$.2f mm", len), fScrPosX, fScrPosY-10);
  }

  // camera.updatePixels();
  // return camera;
}