// *********************************************************************
//
//  * Model Class
//      Layer Class
//        Gcode Class
//
//    An instance of this class has a whole gcode.
//    This class supposes CuraEngine's gcode 
//    because it is easily splited into layers and gcodes using comment lines (;).
//
// *********************************************************************

class Model {
  private ArrayList<Gcode> startCode;
  private ArrayList<Layer> layer;
  private ArrayList<Gcode> endCode;


  // load model
  public Model(String path) {
    this.layer = new ArrayList<Layer>();
    this.startCode = new ArrayList<Gcode>();
    this.endCode = new ArrayList<Gcode>();
    String[] lines = loadStrings(path);

    int count = -1;
    int change = 0;
    this.layer.add(new Layer());


    for (int i = 0; i < lines.length; i++) {
      if (lines[i].indexOf("; Default end code") != -1) {
        change = 0;
      }
      if (lines[i].indexOf(";LAYER:") != -1) {
        this.layer.add(new Layer());
        change = 1;
        count++;
      }
      if (lines[i].indexOf("; Default end code") != -1) {
        change = 2;
      }

      if (change == 0) {
        this.startCode.add(new Gcode(lines[i]));
      }
      if (change == 1) {
        this.layer.get(count).gcode.add(new Gcode(lines[i]));
      }
      if (change == 2) {
        this.endCode.add(new Gcode(lines[i]));
      }
    }
  }

  public void printAll() {
    for (Gcode g : startCode) {
      print(g.toString());
    }
    for (Layer l : layer) {
      for (Gcode g : l.gcode) {
        print(g.toString());
      }
    }
    for (Gcode g : endCode) {
      print(g.toString());
    }
  }

  public void printStartCode() {
    for (Gcode g : startCode) {
      print(g.toString());
    }
  }

  public void printLayers() {
    for (Layer l : layer) {
      for (Gcode g : l.gcode) {
        print(g.toString());
      }
    }
  }


  public Layer getLayer(int lc) {
    if (lc < 0 || layer.size() <= lc) {
      println("ERROR: layer number is out of the range ( Layer Count: " + layer.size() + ")");
      return null;
    }

    return layer.get(lc);
  }

  public Gcode getGcode(int lc, int gc) {
    if (lc < 0 || layer.size() <= lc) {
      println("ERROR: layer number is out of the range ( Layer Count: " + layer.size() + ")");
      return null;
    }
    if (gc < 0 || layer.get(lc).gcode.size() <= gc) {
      println("ERROR: gcode number is out of range in layer number " + lc + " ( Gcode Count: " + layer.get(lc).gcode.size() + ")");
      return null;
    }

    return layer.get(lc).gcode.get(gc);
  }
  
    public Gcode getStartCode(int gc) {
    if (gc < 0 || startCode.size() <= gc) {
      println("ERROR: gcode number is out of range in start code ( Gcode Count: " + startCode.size() + ")");
      return null;
    }

    return startCode.get(gc);
  }
  
    public Gcode getEndCode(int gc) {
    if (gc < 0 || endCode.size() <= gc) {
      println("ERROR: gcode number is out of range in end code ( Gcode Count: " + endCode.size() + ")");
      return null;
    }

    return endCode.get(gc);
  }
  
}