// *********************************************************************
//
//  Menu window
//
//  Menu (controller) is generated here for debugging.
//
// *********************************************************************

MenuWindow MenuWin;

public class MenuWindow extends PApplet {

  PApplet parent;
  MenuWindow(PApplet _parent) {
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

  // ********************************************************************************
  //  setting -  menu window
  // ********************************************************************************
  void settings() {
    size( MENU_WINDOW_SIZE[0], MENU_WINDOW_SIZE[1]);
  }

  // ********************************************************************************
  //  setup -  menu window
  // ********************************************************************************
  void setup() {
    // window setting
    surface.setLocation(MENU_WINDOW_LOCATION[0], MENU_WINDOW_LOCATION[1]);
    surface.setTitle("Menu");

    stroke(180, 180, 180);
    Menu_GUISetting();
  }

  // ********************************************************************************
  //  draw -  menu window
  // ********************************************************************************
  void draw() {
    background(color(200, 200, 200));
    // grid for debug
    drawGrid();
  }


  // ********************************************************************************
  //  draw grid to arrange GUI components (Debug)
  // ********************************************************************************
  void drawGrid() {
    for (int i = 0; i < width; i += 10) {
      if (i%100 == 0) {
        strokeWeight(3);
      } else {
        strokeWeight(1);
      }
      line(i, 0, i, height);
    }
    for (int j = 0; j < height; j += 10) {
      if (j%100 == 0) {
        strokeWeight(3);
      } else {
        strokeWeight(1);
      }
      line(0, j, width, j);
    }
  }

  // ************************************************************************
  //  GUI callback methods
  // ************************************************************************

  // ************************************************************************
  //  Connect Button
  void connect_printer() {
    if ( DDL_printer_ports != null && DDL_printer_rates != null) {
      if ( printer == null) {
        printer = connectPrinter(SERIAL_PORTS[(int)DDL_printer_ports.getValue()], BAUD_RATES[(int)DDL_printer_rates.getValue()]);

        Button bt = (Button)cp5_Menu.getController("connect_printer");
        bt.setColorBackground(color(255, 0, 0));
        bt.setLabel("Disconnect");
      } else {
        InfoWin.printInfo("printer is disconnected");
        printer.stop();
        printer = null;
        Button bt = (Button)cp5_Menu.getController("connect_printer");
        bt.setColorBackground(color(0, 45, 90));
        bt.setLabel("connect");
      }
    }
  }

  // not imlemented
  void connect_sensor() {
    if ( DDL_sensor_ports != null && DDL_sensor_rates != null) {
      if ( sensor == null) {
        sensor = connectSensor(SERIAL_PORTS[(int)DDL_sensor_ports.getValue()], BAUD_RATES[(int)DDL_sensor_rates.getValue()]);
        Button bt = (Button)cp5_Menu.getController("connect_sensor");
        bt.setColorBackground(color(255, 0, 0));
        bt.setLabel("Disconnect");
      } else {
        InfoWin.printInfo("sensors are disconnected");
        sensor.stop();
        sensor = null;
        Button bt = (Button)cp5_Menu.getController("connect_sensor");
        bt.setColorBackground(color(0, 45, 90));
        bt.setLabel("connect");
      }
    }
  }
  // ************************************************************************

  // ************************************************************************
  //  Open Button
  void load_gcodefile() {
    selectInput("select gcode file", "fileSelected", new File( dataPath("") ));
  }

  void fileSelected(File selection) {
    if (selection == null) {
      println("Window was closed or the user hit cancel.");
    } else {
      GCODE_FILE_NAME = selection.getAbsolutePath();

      Textfield t = (Textfield)cp5_Menu.getController("file_name");
      t.setText(GCODE_FILE_NAME);

      model = new Model(GCODE_FILE_NAME);
      sub_load(GCODE_FILE_NAME);

      InfoWin.printInfo(GCODE_FILE_NAME + " is loaded.");
    }
  }

  void sub_load(String str) {
    model = new Model(str);

    try {
      MainWin.drawMethods.add(MainWin.getClass().getMethod("clearWin", null));
      MainWin.drawMethodArg.add(null);
      MainWin.drawMethods.add(MainWin.getClass().getMethod("drawPlatform", null));
      MainWin.drawMethodArg.add(null);
      MainWin.drawMethods.add(MainWin.getClass().getMethod("drawModel", Model.class));
      MainWin.drawMethodArg.add(model);
    } 
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }
  // ************************************************************************

  // ************************************************************************
  // method for GUI controller
  // ************************************************************************

  void controller_start_printing() {
    if (printer!=null && !NOW_PRINTING) { 
      StartPrinting();
      NOW_PRINTING = true;
      BTN_start_printing
        .setLabel("Stop printing")
        .setColorBackground(color(255, 0, 0));
    } else {
      StopPrinting();
      NOW_PRINTING = false;
      BTN_start_printing
        .setLabel("Start printing")
        .setColorBackground(color(0, 45, 90));
    }
  }

  void controller_x_home() {
    if (printer!=null) {
      printer.write("G28 X0\n");
    }
  } 
  void controller_x_plus() {
    if (printer!=null) {
      printer.write("G91\nG1 X10 F3600\nG90\n");
    }
  }
  void controller_x_minus() {
    if (printer!=null) {
      printer.write("G91\nG1 X-10\nG90\n");
    }
  } 

  void controller_y_home() {
    if (printer!=null) {
      printer.write("G28 Y0\n");
    }
  } 
  void controller_y_plus() {
    if (printer!=null) {
      printer.write("G91\nG1 Y10 F3600\nG90\n");
    }
  }
  void controller_y_minus() {
    if (printer!=null) {
      printer.write("G91\nG1 Y-10\nG90\n");
    }
  } 

  void controller_z_home() {
    if (printer!=null) {
      printer.write("G28 Z0\n");
    }
  }
  void controller_z_plus() {
    if (printer!=null) {
      printer.write("G91\nG1 Z10 F3600\nG90\n");
    }
  }
  void controller_z_minus() {
    if (printer!=null) {
      printer.write("G91\nG1 Z-10\nG90\n");
    }
  } 

  void controller_e_home() {
    if (printer!=null) {
      printer.write("G28 Z0\n");
    }
  }
  void controller_e_plus() {
    if (printer!=null) {
      printer.write("M83\nG1 E10 F600\n");
    }
  }
  void controller_e_minus() {
    if (printer!=null) {
      printer.write("M83\nG1 E-10 F600\n");
    }
  } 

  void controller_homepos() {
    if (printer!=null) {
      printer.write("G28\n");
    }
  } 

  void controller_gcode_send() {
    if (printer!=null) {
      String t = TF_GcodeSend.getText();
      printer.write(t + "\n");
    }
  }
}