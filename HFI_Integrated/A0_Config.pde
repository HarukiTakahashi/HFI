// ************************************************************************
//
//  config and global fields
//
// ************************************************************************

// ************************************************************************
//  model
// ************************************************************************

Model model;


// ************************************************************************
//  serial
// ************************************************************************

Serial printer=null;
Serial sensor=null;

String[] SERIAL_PORTS = Serial.list();
final int[] BAUD_RATES = { 9600, 115200, 250000 };


// ************************************************************************
//  threads
// ************************************************************************
Printing printingThread;
Sender senderThread;

// ************************************************************************
//  queue
// ************************************************************************
GcodeQueue queue;


// ************************************************************************
//  default gcode
// ************************************************************************

String GCODE_FILE_NAME = dataPath("box_wo_waitcode.gcode");


// ************************************************************************
//  default start code
// ************************************************************************

String CONNECT_CODE = "G28\n" + "M84\n" + "G90\n" + "G1 Z2\n";

// ************************************************************************
//  wheter printer prints or not
// ************************************************************************

boolean NOW_PRINTING = false;


// ************************************************************************
//  size and location of windows
// ************************************************************************

final int MAIN_WINDOW_SIZE[] = new int[]{500,300};
final int MAIN_WINDOW_LOCATION[] = new int[]{400,50};

final int INFO_WINDOW_SIZE[] = new int[]{MAIN_WINDOW_SIZE[0],200};
final int INFO_WINDOW_LOCATION[] = new int[]{MAIN_WINDOW_LOCATION[0], MAIN_WINDOW_LOCATION[1]+MAIN_WINDOW_SIZE[1]+35};
final int MENU_WINDOW_SIZE[] = new int[]{300,MAIN_WINDOW_SIZE[1]+INFO_WINDOW_SIZE[1] + 35};
final int MENU_WINDOW_LOCATION[] = new int[]{MAIN_WINDOW_LOCATION[0]-MENU_WINDOW_SIZE[0]-10,MAIN_WINDOW_LOCATION[1]};