// library **************************************
import imageTranslater.*;
import org.opencv.core.*;
import org.opencv.imgproc.*;
import org.opencv.highgui.*;
import org.opencv.features2d.*;
import com.leapmotion.leap.*;
// library **************************************

final int leapImageWidth = 640;
final int leapImageHeight = 200;

// LeapMotion Controller
Controller controller = new Controller();
// LeapMotion Controller Event Listener
LeapListener listener = new LeapListener();
Mat[] captureImage;
FeatureDetection feature;

// this library was made by our lab member and
// used to convert PImage to Mat
ImageTranslater imgTrans;


// **********************************************
// setup
// **********************************************
void setup() {
  size(640, 640);
  smooth();
  background(255);
  controller.addListener(listener);
  controller.setPolicy(Controller.PolicyFlag.POLICY_IMAGES);
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  feature = new FeatureDetection(FeatureDetector.ORB);
  captureImage = new Mat[2];
}

// **********************************************
// draw
// **********************************************
void draw() {

  background(0);
  noStroke();
  fill(255, 255, 0, 100);

  PImage[] pimages = getImage();

  if (pimages != null) {
    Mat resizeimage[] = new Mat[2];

    // i = 0 : left image
    // i = 1 : right image
    for (int i = 0; i < 2; i++) {
      image(pimages[i], 0, pimages[i].height*i);

      captureImage[i] = ImageTranslater.PImageToMat(pimages[i]);
      Size sz = new Size(pimages[i].width, pimages[i].height);
      resizeimage[i] = new Mat();

      Imgproc.resize(captureImage[i], resizeimage[i], sz);
      feature.setImage(resizeimage[i]);
      feature.detection();
      for (Point p : feature.getPoints ()) {
        ellipse((float)p.x, (float)p.y+pimages[i].height*i, 5, 5);
      }
    }
  }
}

// **********************************************
// getImage - returns stereo images as PImage[]
// **********************************************
public PImage[] getImage() {
  Frame frame = controller.frame();

  if (frame.isValid()) {
    ImageList images = frame.images();

    Image leftImage = images.get(0);
    Image rightImage = images.get(1);
    PImage[] pimages = new PImage[2];

    pimages[0] = getGrayScaleImage(leftImage);
    pimages[1] = getGrayScaleImage(rightImage);

    return pimages;
  }

  return null;
}


// **********************************************
// getGrayScaleImage - returns an gray scale image as PImage
// **********************************************
public PImage getGrayScaleImage(Image image) {
  PImage camera = createImage(image.width(), image.height(), RGB);
  camera.loadPixels();

  //Get byte array containing the image data from Image object
  byte[] imageData = image.data();

  for (int i = 0; i < image.width() * image.height(); i++) {
    int r = (imageData[i] & 0xFF) << 16;
    int g = (imageData[i] & 0xFF) << 8;
    int b = imageData[i] & 0xFF;
    camera.pixels[i] =  r | g | b;
  }

  //Show the image
  camera.updatePixels();
  return camera;
}