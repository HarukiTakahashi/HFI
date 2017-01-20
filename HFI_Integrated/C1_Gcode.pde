// *********************************************************************
//
//  Model Class
//    Layer Class
//      * Gcode Class
//
//    An instance of this class has gcode structure.
//   
//  reference : http://reprap.org/wiki/G-code
//
// *********************************************************************


// Gcodeを一つ管理する
class Gcode {
  // field
  String cmd = "";
  // G: standard Gcode
  // M: Reprap-defined command

  String comment = "";
  // ; XXX : Comments begin at a semicolon

  // param with flag
  private Param x = new Param();  // coordinate
  private Param y = new Param();  // coordinate
  private Param z = new Param();  // coordinate
  private Param e = new Param();  // length of extrudate
  private Param f = new Param();  // feedrate
  private Param t = new Param();  // nozzle
  private Param s = new Param();  // feedrate
  private Param p = new Param();  // nozzle


  // and more?

  // constructor ==================================================
  public Gcode(String gcode) {
    gcode = gcode.trim();
    String[] splitedGcode = gcode.split(" ");

    for (int i = 0; i < splitedGcode.length; i++) {
      if (i == 0 && splitedGcode[i].indexOf(";") != -1) {
        // comment line
        this.comment = gcode;
        break;
      } else {
        if (splitedGcode[i].indexOf(";") != -1) {
          // comment line
          for (int j = i; j < splitedGcode.length; j++) {
            this.comment += " " + splitedGcode[j];
          }
          break;
        }
        if (splitedGcode[i].indexOf("G") != -1 || splitedGcode[i].indexOf("M") != -1 ) {
          this.cmd = splitedGcode[i].trim();
        }
        if (splitedGcode[i].indexOf("X") != -1) { 
          this.x.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
        if (splitedGcode[i].indexOf("Y") != -1) {
          this.y.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
        if (splitedGcode[i].indexOf("Z") != -1) {
          this.z.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
        if (splitedGcode[i].indexOf("E") != -1) {
          this.e.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
        if (splitedGcode[i].indexOf("F") != -1) {
          this.f.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
        if (splitedGcode[i].indexOf("T") != -1) {
          this.t.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
        if (splitedGcode[i].indexOf("S") != -1) {
          this.s.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
        if (splitedGcode[i].indexOf("P") != -1) {
          this.p.set(Float.parseFloat((splitedGcode[i].substring(1))), true);
        }
      }
    }
  }

  public Gcode(String cmd, float x, float y, float f) {
    this.cmd = cmd;
    this.x.set(x, true);
    this.y.set(y, true);
    this.f.set(f, true);
  }

  public Gcode(String cmd, float x, float y, float e, float f) {
    this(cmd, x, y, f);
    this.e.set(e, true);
  }

  public Gcode(String cmd, float z, float f) {
    this.cmd = cmd;
    this.z.set(z, true);
    this.f.set(f, true);
  }

  // amd more?


  public boolean hasXY() {
    if (x.flag == true && y.flag == true) {
      return true;
    }
    return false;
  }


  public String toString() {
    String out = "" + cmd;
    if (x.flag) {
      out += " X" + x.v;
    }
    if (y.flag) {
      out += " Y" + y.v;
    }
    if (z.flag) {
      out += " Z" + z.v;
    }
    if (e.flag) {
      out += " E" + e.v;
    }
    if (f.flag) {
      out += " F" + (int)f.v;
    }
    if (t.flag) {
      out += " T" + (int)t.v;
    }
    if (s.flag) {
      out += " S" + (int)s.v;
    }
    if (p.flag) {
      out += " P" + (int)p.v;
    }

    /*if (comment != "") {
      out += comment;
    }
    */
    out = out.trim();

    out += "\n";
    return out;
  }
}


class Param {
  private float v = 0;
  private boolean flag = false;

  public Param(float v) {
    this.v = v;
  }

  public Param() {
  }

  public void set(float v, boolean flag) {
    this.v = v;
    this.flag = flag;
  }
   
  public float get() {
    return v;
  }

  public boolean exist() {
    return flag;
  }

}