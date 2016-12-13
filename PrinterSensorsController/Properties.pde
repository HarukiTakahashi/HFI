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
      println(" > " +  String.format("%6s", f.getType())+" "+f.getName());
    }
  }
}

// Sensor Range ==================================================
public static class SensorRange {
  private SensorRange() { } // private constructor for prohibit instantiating
  static float VARIABLE_RESISTANCE_MIN = 0;
  static float VARIABLE_RESISTANCE_MAX = 1023;

  public static void importProperty(String name) {
    Properties sr = new Properties();

    try {
      InputStream inputStream;
      inputStream = new FileInputStream(new File(name));
      sr.load(inputStream);

      SensorRange.VARIABLE_RESISTANCE_MIN = Float.parseFloat(sr.getProperty("VARIABLE_RESISTANCE_MIN"));
      SensorRange.VARIABLE_RESISTANCE_MAX = Float.parseFloat(sr.getProperty("VARIABLE_RESISTANCE_MAX"));
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