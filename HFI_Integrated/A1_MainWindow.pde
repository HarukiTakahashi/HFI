// *********************************************************************
//
//  Main window
//
//  A 3D model (.gcode) is drawn here
//  
// *********************************************************************

MainWindow MainWin;

public class MainWindow extends PApplet {

  PApplet parent;
  MainWindow(PApplet _parent) {
    super();
    // set parent
    this.parent = _parent;
    // init window
    try {
      Method handleSettingsMethod = this.getClass().getSuperclass().getDeclaredMethod("handleSettings", null);
      handleSettingsMethod.setAccessible(true);
      handleSettingsMethod.invoke(this, null);
    } 
    catch (Exception ex) {
      ex.printStackTrace();
    }

    PSurface surface = super.initSurface();
    surface.placeWindow(new int[]{0, 0}, new int[]{0, 0});

    this.showSurface();
    this.startSurface();
  }


  LinkedList<Method> drawMethods;
  LinkedList<Object> drawMethodArg;

  // ********************************************************************************
  //  setting -  main window
  // ********************************************************************************
  void settings() {
    size ( MAIN_WINDOW_SIZE[0], MAIN_WINDOW_SIZE[1], P3D);
  }

  // ********************************************************************************
  //  setup -  main window
  // ********************************************************************************
  void setup() {
    // window setting
    drawMethods = new LinkedList<Method>();
    drawMethodArg = new LinkedList<Object>();

    surface.setLocation(MAIN_WINDOW_LOCATION[0], MAIN_WINDOW_LOCATION[1]);
    surface.setTitle("Main");
  }

  // ********************************************************************************
  //  setup -  draw window
  // ********************************************************************************
  void draw() {
    camera(50, -30, 50, PrinterSetting.PRINTER_BASE_X/2, -10, PrinterSetting.PRINTER_BASE_Y/2, 0, 1, 0);

    if (drawMethods.size() > 0) {
      try {
        Method m = drawMethods.poll();
        Object c = drawMethodArg.poll();
        if (c == null) {
          m.invoke(this, null);
        } else {
          m.invoke(this, c);
        }
      }
      catch (Exception ex) {
        ex.printStackTrace();
      }
    }   
  }

  // ********************************************************************************
  //  draw all gcodes
  // ********************************************************************************
  public void drawModel(Model m) {
    strokeWeight(0.4);
    stroke(color(0, 0, 200));
    for (int i = 0; i < m.layer.size(); i++) {
      float z = 0;
      for (int j = 0; j < m.layer.get(i).gcode.size(); j++) {
        Gcode g_from = m.getGcode(i, j);

        if (g_from.z.exist()) {
          z = g_from.z.get();
        }
        if (g_from.hasXY()) {
          for (int k = j+1; k < m.layer.get(i).gcode.size(); k++) {
            Gcode g_to = m.getGcode(i, k);
            if (g_to.hasXY()) {
              line( g_from.x.get(), -z, g_from.y.get(), g_to.x.get(), -z, g_to.y.get());
              //println(g_from.x.get()+", "+z+", "+g_from.y.get() + " - "  + g_to.x.get() + ", " +z+", "+ g_to.y.get());
              break;
            }
          }
        }
      }
    }
  }

// *********************************************************************
//  draw a certain layer 
// *********************************************************************
  public void drawLayer(Layer l) {
    strokeWeight(0.2);
    stroke(color(200, 0, 0));
    float z = 0;
    for (int i = 0; i < l.gcode.size(); i++) {
      Gcode g_from = l.getGcode(i);

      if (g_from.z.exist()) {
        z = g_from.z.get();
      }
      if (g_from.hasXY()) {
        for (int j = i+1; j < l.gcode.size(); j++) {
          Gcode g_to = l.getGcode(j);
          if (g_to.hasXY()) {
            line( g_from.x.get(), -z, g_from.y.get(), g_to.x.get(), -z, g_to.y.get());
            break;
          }
        }
      }
    }
  }

// *********************************************************************
//  draw a platform grid
// *********************************************************************
  public void drawPlatform() {
    strokeWeight(0.5);
    stroke(color(150));
    for (int i = 0; i <= PrinterSetting.PRINTER_BASE_X; i+=10) {
      line(i, 0, 0, i, 0, PrinterSetting.PRINTER_BASE_Y);
    }
    for (int i = 0; i <= PrinterSetting.PRINTER_BASE_Y; i+=10) {
      line(0, 0, i, PrinterSetting.PRINTER_BASE_X, 0, i);
    }
  }

// *********************************************************************
//  clear window
// *********************************************************************
  public void clearWin() {
    background(200);
  }
}