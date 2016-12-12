  // When we want to add a new parameter ====================
  // (1) write a new property in XX.properties file.
  //
  // ( in PrinterSetting.properties )
  //   e.g.,  
  //    PRINTER_TEST = 0
  // ========================================================


// Printer Setting ==================================================
public static class PrinterSetting {
  static int PRINTER_BASE_X = 0;
  static int PRINTER_BASE_Y = 0;
  static int PRINTER_BASE_Z = 0;
  static int MOVE_SPEED_XY_MIN = 0;
  static int MOVE_SPEED_XY_MAX = 0;
  static int MOVE_SPEED_Z_MIN = 0;
  static int MOVE_SPEED_Z_MAX = 0;
  static float MATERIAL_AMOUNT_MIN = 0;
  static float MATERIAL_AMOUNT_NOR = 0;
  static float MATERIAL_AMOUNT_MAX = 0;
  
  // ========================================================
  // (2) add a new variable
  // static float PRINTER_TEST = 0;  
  // ========================================================
  
  private PrinterSetting() { } // private constructor for prohibit instantiating

  public static void importProperty(String name) {
    Properties ps = new Properties();

    try {
      InputStream inputStream;
      inputStream = new FileInputStream(new File(name));
      ps.load(inputStream);

      PRINTER_BASE_X = Integer.parseInt(ps.getProperty("PRINTER_BASE_X"));
      PRINTER_BASE_Y = Integer.parseInt(ps.getProperty("PRINTER_BASE_Y"));
      PRINTER_BASE_Z = Integer.parseInt(ps.getProperty("PRINTER_BASE_Z"));
      MOVE_SPEED_XY_MIN = Integer.parseInt(ps.getProperty("MOVE_SPEED_XY_MIN"));
      MOVE_SPEED_XY_MAX = Integer.parseInt(ps.getProperty("MOVE_SPEED_XY_MAX"));
      MOVE_SPEED_Z_MIN = Integer.parseInt(ps.getProperty("MOVE_SPEED_Z_MIN"));
      MOVE_SPEED_Z_MAX = Integer.parseInt(ps.getProperty("MOVE_SPEED_Z_MAX"));
      MATERIAL_AMOUNT_MIN = Float.parseFloat(ps.getProperty("MATERIAL_AMOUNT_MIN"));
      MATERIAL_AMOUNT_NOR = Float.parseFloat(ps.getProperty("MATERIAL_AMOUNT_NOR"));
      MATERIAL_AMOUNT_MAX = Float.parseFloat(ps.getProperty("MATERIAL_AMOUNT_MAX"));
  
      // ========================================================
      // (3) import a value from property file
      // PRINTER_TEST = Float.parseFloat(ps.getProperty("PRINTER_TEST"));;  
      // ========================================================
  
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // print all field
  public static void print() {
    for (Field f : PrinterSetting.class.getDeclaredFields()) {
      f.setAccessible(false);
      println(" > " +  String.format("%6s", f.getType())+" "+f.getName());
    }
  }
}

// Sensor Range ==================================================
public static class SensorRange {
  private SensorRange() { } // private constructor for prohibit instantiating
  static float PROXIMITY_NEAR = 0;
  static float PROXIMITY_FAR = 0;

  public static void importProperty(String name) {
    Properties sr = new Properties();

    try {
      InputStream inputStream;
      inputStream = new FileInputStream(new File(name));
      sr.load(inputStream);

      SensorRange.PROXIMITY_NEAR = Float.parseFloat(sr.getProperty("PROXIMITY_NEAR"));
      SensorRange.PROXIMITY_FAR =  Float.parseFloat(sr.getProperty("PROXIMITY_FAR"));
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }
  
    public static void print() {
    for (Field f : SensorRange.class.getDeclaredFields()) {
      println(" > " +  String.format("%6s", f.getType())+" "+f.getName());
    }
  }  
}