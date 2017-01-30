import java.util.*;


void startPrint() {
  if (gcode==null) {
    println("not found!");
      return;
  }
  println("start printing");
  gcode.printAll(printer);
}

void connectPrinter(String com, int baud) {
  Serial tmp=new Serial(this, com, baud);
  try {
    Thread.sleep(3000);
  }
  catch(Exception e) {
  }
  tmp.write("G28\n");// home position
  println("send to pinter: G28");
  tmp.write("M84\n");//
  println("send to pinter: M84");
  printer=tmp;
}


void setHeater(boolean on) {
  printer.write((on)?"M104 S210\n":"M104 S0\n");
  println("send to pinter: "+((on)?"M104 S210":"M104 S0"));
  printer.write("M116"); //wait until sufficient env. is set
}
