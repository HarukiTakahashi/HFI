// *********************************************************************
//
//  Model Class
//    * Layer Class
//        Gcode Class
//
//    An instance of this class has a layer in 3D model (gcode).
//    i.e., a ArrayList field keeps gcodes that form a layer.
//   
// *********************************************************************

class Layer {
  ArrayList<Gcode> gcode;

  public Layer() {
    this.gcode = new ArrayList<Gcode>();
  }

  public Gcode getGcode(int gc) {
    if (gc < 0 || gcode.size() <= gc) {
      println("ERROR: gcode number is out of range in this layer ( Gcode Count: " + gcode.size() + ")");
      return null;
    }

    return gcode.get(gc);
  }
}