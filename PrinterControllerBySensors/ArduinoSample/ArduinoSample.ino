void setup() {
     Serial.begin(9600) ;
}
void loop() {
     int ans ;
     ans = analogRead(A0) ;
     Serial.println(ans) ;
     delay(100) ;
}
