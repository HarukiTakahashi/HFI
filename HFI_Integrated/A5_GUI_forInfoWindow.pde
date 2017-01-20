// *********************************************************************
//
//  GUI components for menu windows
//
//  reference:  http://www.sojamo.de/libraries/controlP5/
//
// *********************************************************************

ControlP5 cp5_Info;

Textarea TA_info_window;

// *********************************************************************
//  GUI components
// *********************************************************************
void Info_GUISetting() {
  cp5_Info = new ControlP5(InfoWin);

  TA_info_window = cp5_Info.addTextarea("info_area")
    .setPosition(0, 0)
    .setSize(INFO_WINDOW_SIZE[0], INFO_WINDOW_SIZE[1])
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(128))
    .setColorBackground(color(0, 100))
    .setColorForeground(color(255, 100))
    .setText(" ===== Info ==== \n");
}