// ***************************************************
//  Sensors
//    A0  Photocell
//    A1  Flex
//    A2  Temp
//    A3  Potentiometer
//    A4  Proximity
//    D2  Rx from RFID Tag Reader
// ***************************************************

#define COUNT_MAX 50
#include <SoftwareSerial.h>

SoftwareSerial mySerial(2, 3);

const int tagLen = 16;
const int idLen = 13;
const int kTags = 10;

// Put your known tags here!
char knownTags[kTags][idLen] = {
             "82003BE99BCB", //cards
             "82003B7BCF0D",
             "7F001B665052", //buttons
             "7F001B463113",
             "7F001B0DD0B9",
             "7F001B2B6629",
};

char newTag[idLen];
int pinLED = 8;

long ans0, ans1, ans2, ans3, ans4;
int count;

void initiate() {
  count = 0;
  ans0 = 0;  ans1 = 0;
  ans2 = 0;  ans3 = 0 ;
  ans4 = 0;
}

//check if tag is known
int checkTag(char nTag[], char oTag[]) {
    for (int i = 0; i < idLen; i++) {
      if (nTag[i] != oTag[i]) {
        return 0;
      }
    }
  return 1;
}

void setup() {
  Serial.begin(115200) ;
  mySerial.begin(9600); // to read from RFID reader
  initiate();
}


void loop() {

  // for simple analog sensors
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


  // for RFID tag per hand tool identifaction
  int i = 0; // # of new tags
  int readByte;
  boolean tag = false;

  if (mySerial.available() == tagLen) {
    tag = true;
  }


  if (tag == true) {
    while (mySerial.available()) { // Take each byte out of the serial buffer, one at a time
      readByte = mySerial.read();
      Serial.print(readByte);

      if (readByte != 2 && readByte!= 13 && readByte != 10 && readByte != 3) {
        newTag[i] = readByte;
        i++;
      }

      // If we see ASCII 3, ETX, the tag is over
      if (readByte == 3) {
        tag = false;
        digitalWrite(pinLED, LOW);
      }
    }
  }

  if (strlen(newTag)== 0) {
    return;
  }
  else {
    int total = 0;
    int markerIndex = -1;

    for (int ct=0; ct < kTags; ct++){
        total += checkTag(newTag, knownTags[ct]);
        if(total == 1){
          markerIndex = ct;
          break;
        }
    }

    // If newTag matched any of the tags we checked against, total will be 1
    if (total > 0) {
      Serial.print("Success to read RF Tag :");
      Serial.println(markerIndex);

      switch (markerIndex){
        case 2:
            Serial.println("violet marker");
        break;
        case 3:
            Serial.println("red marker");
        break;
        case 4:
            Serial.println("yellow marker");
        break;
        case 5:
            Serial.println("green marker");
        break;
        default:
          Serial.println("failed to identify marmker index");
      }
    }
    else {
        // This prints out unknown cards so you can add them to your knownTags as needed
        Serial.print("Unknown tag! :");
        Serial.print(newTag);
        Serial.println();
    }
  }

}
