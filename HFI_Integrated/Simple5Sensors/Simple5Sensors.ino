// ***************************************************
//  Sensors
//    A0  Photocell
//    A1  Flex
//    A2  Temp
//    A3  Potentiometer
//    A4  Proximity
// ***************************************************

#define COUNT_MAX 50

long ans0, ans1, ans2, ans3, ans4;
int count;

void initiate() {
  count = 0;
  ans0 = 0;  ans1 = 0;
  ans2 = 0;  ans3 = 0 ;
  ans4 = 0;
}

void setup() {
  Serial.begin(115200) ;
  initiate();
}


void loop() {
  ans0 += analogRead(A0) ;
  ans1 += analogRead(A1) ;
  ans2 += analogRead(A2) ;
  ans3 += analogRead(A3) ;
  ans4 += analogRead(A4) ;

  if (count > COUNT_MAX) {
   Serial.print("Photocell:") ;  Serial.print(ans0/count) ;
   Serial.print(",Flex:") ;  Serial.print(ans1/count) ;
   Serial.print(",Temp:") ; Serial.print(ans2/count) ;
   Serial.print(",Potentiometer:"); Serial.print(ans3/count) ;
   Serial.print(",Proximity:") ;  Serial.print(ans4/count) ;
   Serial.print("\n");

    initiate();
  }
  else{
    count++;
  }
  delayMicroseconds(1) ;
}
