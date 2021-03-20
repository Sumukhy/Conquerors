#include "Arduino.h"
#include "heltec.h"
#define BAND    433E6
void setup() {
  Serial.begin(115200);
  Heltec.begin(true /*DisplayEnable Enable*/, true /*Heltec.LoRa Disable*/, true /*Serial Enable*/, true /*PABOOST Enable*/, BAND /*long BAND*/);
  Heltec.display->flipScreenVertically();
  Heltec.display->setTextAlignment(TEXT_ALIGN_LEFT);
  Heltec.display->setFont(ArialMT_Plain_24);
  delay(8000);
}
String s;
//s1 - mq135
//s2 - mq2
int s1,s2;
void loop() {
  // read the value from the sensor:
  s1=analogRead(13);
  s2=analogRead(12);
  s = String(s1)+","+String(s2);
  // printing the sensor value in the console
  Serial.println(s);
  Heltec.display->clear();
  Heltec.display->drawString(0, 10, s);
  // write the buffer to the display
  Heltec.display->display();
  if ((s2>3400)){
    LoRa.beginPacket();
   LoRa.setTxPower(14,RF_PACONFIG_PASELECT_PABOOST);
    LoRa.print(s);
    LoRa.endPacket();
    Heltec.display->clear();
    Heltec.display->drawString(0, 10, "sent");
    Heltec.display->display();
    //while (true){};
    delay(1000);
  }
  
  delay(10);
}
