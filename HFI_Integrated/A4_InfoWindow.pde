// *********************************************************************
//
//  Ingo window
//
//  Information is shown here for checking process.
//
// *********************************************************************

public InfoWindow InfoWin;

public class InfoWindow extends PApplet {
  PApplet parent;
  InfoWindow(PApplet _parent) {
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
  //  setting - info window
  // ********************************************************************************
  void settings() {
    size(INFO_WINDOW_SIZE[0], INFO_WINDOW_SIZE[1]);
  }

  // ********************************************************************************
  //  setup - info window
  // ********************************************************************************
  void setup() {
    // window setting
    surface.setLocation(INFO_WINDOW_LOCATION[0], INFO_WINDOW_LOCATION[1]);
    surface.setTitle("Info");

    Info_GUISetting();
  }
  
  // ********************************************************************************
  //  draw - info win
  //  Do not remove! 
  // ********************************************************************************
  void draw(){
  }

  // ********************************************************************************
  //  print information to info window
  // ********************************************************************************  
  public void printInfo(String str) {
    str = str.trim();
    TA_info_window.append(str+"\n");
    TA_info_window.scroll(100);
  }
}