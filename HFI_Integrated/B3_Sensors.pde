// *********************************************************************
//
//  Sensor
//
//  The code assumes that sensor datas are sent as follows:
//    Photocell:854,Flex:567,Temp:38,Potentiometer:5,Proximity:46
// 
// *********************************************************************


class Sensor {
  private int size;
  private ArrayList values;

  Sensor(int size) {
    this.size = size;
    this.values = new ArrayList();
  }
  
  void addValue(float value){
    if(values.size() < size){
      values.add((float)value);
    }
    else{
      values.remove(0);
      values.add((float)value);
    }
  }
  
  // get a latest value from values (Arraylist)
  float getLatestValue(){
    return (float)values.get(values.size()-1);
  }
  
}