// ***************************
//  main - image processing
// ***************************

void ImageProcessing() {

  if (!capFlag) {
    // if capFlag is false

    if (capture.available()) {
      capture.read();
      capture.resize(640, 480);
      image(capture, 0, 0);
    }
  } else {
    // if capFlag is true

    if (!processFlag) {
      textSize(26); 
      // if processFlag is false
      // this image processing runs once

      // get camera image
      // "captured" is PImage
      Mat cameraImage = new Mat();
      cameraImage = imgTrans.PI2Mat(captured);

      // debug **********************
      captured.resize(320, 240);
      image(captured, 640, 0);
      fill(color(255, 0, 0));
      text("original", 650, 30);
      // debug **********************

      // RGB to HSV
      Mat hsv = new Mat();
      Imgproc.cvtColor(cameraImage, hsv, Imgproc.COLOR_BGR2HSV);
      Imgproc.medianBlur(hsv, hsv, 3);

      // make a mask to extract a certain color     
      Mat mask1 = new Mat();
      Mat mask2 = new Mat();

      // threshold
      Core.inRange(hsv, thre1_min,thre1_max , mask1);
      Core.inRange(hsv, thre2_min,thre2_max , mask2);

      Mat mask = new Mat();
      Core.bitwise_or(mask1, mask2, mask);

      Mat extractColor = new Mat();
      cameraImage.copyTo(extractColor, mask);

      // debug **********************
      PImage testExtractColor = imgTrans.Mat2PI(extractColor);//ImageTranslater.MatToPImageRGB(this, mat);
      testExtractColor.resize(320, 240);
      image(testExtractColor, 960, 0);
      fill(color(255, 0, 0));
      text("extract color", 970, 30);
      // debug **********************

      // trimming 
      // it is not implemented yet...
      // Mat cut = new Mat(mat, new Rect(0, 0, 640, 480));

      // to binary image
      Mat binImg = new Mat();
      Imgproc.threshold(extractColor, binImg, 10, 255, Imgproc.THRESH_BINARY);

      // erosion and dilatation
      // see also:
      // http://docs.opencv.org/2.4/doc/tutorials/imgproc/erosion_dilatation/erosion_dilatation.html
      Imgproc.dilate(binImg, binImg, new Mat(), new Point(-1, -1), 2);
      Imgproc.erode(binImg, binImg, new Mat(), new Point(-1, -1), 1);

      // debug **********************
      PImage testBinImage = imgTrans.Mat2PI(binImg);//ImageTranslater.MatToPImageRGB(this, mat);
      testBinImage.resize(320, 240);
      image(testBinImage, 640, 240);
      fill(color(255, 0, 0));
      text("binary image", 650, 270);
      // debug **********************

      Mat thinImg = new Mat();
      Imgproc.cvtColor(binImg, thinImg, Imgproc.COLOR_BGR2GRAY);
      thinImg = thinning(thinImg);

      // debug **********************
      PImage testThinImg = imgTrans.Mat2PI(thinImg);//ImageTranslater.MatToPImageRGB(this, mat);
      testThinImg.resize(320, 240);
      image(testThinImg, 960, 240);
      fill(color(255, 0, 0));
      text("thinning", 970, 270);
      // debug **********************

      // find contours
      List<MatOfPoint> contours=new ArrayList<MatOfPoint>();  
      Mat hierarchy = Mat.zeros(new Size(5, 5), CvType.CV_8UC1);

      Imgproc.findContours(thinImg, contours, hierarchy, Imgproc.RETR_EXTERNAL, Imgproc.CHAIN_APPROX_SIMPLE);  
      Mat dst=Mat.zeros(new Size(thinImg.width(), thinImg.height()), CvType.CV_8UC3);  
      Scalar col = new Scalar(255, 255, 255); 
      Imgproc.drawContours(dst, contours, -1, col, 1);

      // make a .scad file 
      String[] lines = new String[1];
      lines[0] = " polygon(points=[";
 
      // show contour and center
      for (int i=0; i<contours.size(); i++)  
      {  
        MatOfPoint ptmat= contours.get(i);

        if (Imgproc.contourArea(ptmat) > 40) {
          // if the area of a contour bigger than the threshold

          // draw green box and blue center pos of a contour
          col=new Scalar(255, 0, 0);  
          MatOfPoint2f ptmat2 = new MatOfPoint2f( ptmat.toArray() );  
          RotatedRect bbox=Imgproc.minAreaRect(ptmat2);  
          Rect box=bbox.boundingRect();  
          Core.circle(dst, bbox.center, 5, col, -1);  
          col=new Scalar(0, 255, 0);  
          Core.rectangle(dst, box.tl(), box.br(), col, 2);

          col=new Scalar(0, 0, 255);  
          int k=0; 
          for (k=0; k<ptmat.height(); k++) 
          { 
            double[] m=ptmat.get(k, 0); 
            Point vertex = new Point();
            vertex.x=m[0];
            vertex.y=m[1]; 
            Core.circle(dst, vertex, 2, col, -1);

            // make a .scad file 
            lines[0] += "[" + (vertex.x-bbox.center.x) + "," + (vertex.y-bbox.center.y) +"]";
            if (k+1 == ptmat.height()) {
              lines[0] += "]";
            } else {
              lines[0]+=",";
            }
          }
          lines[0] += ");";
          
          // save .scad file to the same directory 
          saveStrings("test.scad", lines);
        }
      }  


      PImage test = imgTrans.Mat2PI(dst);//ImageTranslater.MatToPImageRGB(this, mat);
      image(test, 0, 0);
      text("result", 10, 30);
      processFlag = true;
      textSize(16);
    }
  }
}





// thinning
// Zhang-Suen thinning algorithm
Mat thinning(Mat src) {
  Mat dst = src.clone();

  dst.convertTo(dst, CvType.CV_8UC1, 1.0/255);

  Mat prev = Mat.zeros(dst.size(), CvType.CV_8UC1);
  Mat diff = new Mat();

  do {
    dst = thinningIte(dst, 0);
    dst = thinningIte(dst, 1);
    Core.absdiff(dst, prev, diff);
    dst.copyTo(prev);
  } while (Core.countNonZero(diff) > 0);

  dst.convertTo(dst, CvType.CV_8UC1, 255);
  return dst;
}

Mat thinningIte(Mat img, int pattern) {

  Mat del_marker = Mat.ones(img.size(), CvType.CV_8UC1);

  byte del_markerData[] = new byte[(int)del_marker.total() * del_marker.channels()];
  del_marker.get(0, 0, del_markerData);

  for (int y = 1; y < img.rows()-1; ++y) {

    for (int x = 1; x < img.cols()-1; ++x) {

      int v9, v2, v3;
      int v8, v1, v4;
      int v7, v6, v5;

      v1=(int)img.get(y, x)[0];
      v2=(int)img.get(y-1, x)[0];
      v3=(int)img.get(y-1, x+1)[0];
      v4=(int)img.get(y, x+1)[0];
      v5=(int)img.get(y+1, x+1)[0];
      v6=(int)img.get(y+1, x)[0];
      v7=(int)img.get(y+1, x-1)[0];
      v8=(int)img.get(y, x-1)[0];
      v9=(int)img.get(y-1, x-1)[0];

      int S = 0;
      if (v2 == 0 && v3 == 1) { 
        S++;
      }
      if (v3 == 0 && v4 == 1) { 
        S++;
      }
      if (v4 == 0 && v5 == 1) { 
        S++;
      }
      if (v5 == 0 && v6 == 1) { 
        S++;
      }
      if (v6 == 0 && v7 == 1) { 
        S++;
      }
      if (v7 == 0 && v8 == 1) { 
        S++;
      }
      if (v8 == 0 && v9 == 1) { 
        S++;
      }
      if (v9 == 0 && v2 == 1) { 
        S++;
      }

      int N  = v2 + v3 + v4 + v5 + v6 + v7 + v8 + v9;

      int m1=0, m2=0;

      if (pattern==0) m1 = (v2 * v4 * v6);
      if (pattern==1) m1 = (v2 * v4 * v8);

      if (pattern==0) m2 = (v4 * v6 * v8);
      if (pattern==1) m2 = (v2 * v6 * v8);

      if (S == 1 && (N >= 2 && N <= 6) && m1 == 0 && m2 == 0)
        del_marker.put(y, x, 0);
    }
  }
  Mat ret = new Mat();
  Core.bitwise_and(img, del_marker, ret);
  return ret;
}