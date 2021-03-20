#include <WiFi.h>

#include "time.h"
#include <IOXhop_FirebaseESP32.h>
#define FIREBASE_HOST "nmit-hacks-2021-default-rtdb.firebaseio.com"   
#define FIREBASE_AUTH "U8V0rKY2Mk5sFYcFUZ4CYEVDM9TU3Q8lPZg1wJo1"   
#define WIFI_SSID "sumukh"               
#define WIFI_PASSWORD "sumukh1111"

const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 3600;
const int   daylightOffset_sec = 3600;


#include "heltec.h"
String time11;
#define BAND    433E6  //you can set band here directly,e.g. 868E6,915E6
char data1;
String printLocalTime()
{
  struct tm timeinfo;
  if(!getLocalTime(&timeinfo)){
    Serial.println("Failed to obtain time");
    return "";
  }
  char timeStringBuff[50]; //50 chars should be enough
  strftime(timeStringBuff, sizeof(timeStringBuff), "%A, %B %d %Y %H:%M:%S", &timeinfo);
  //print like "const char*"
  Serial.println(timeStringBuff);

  return timeStringBuff;
}

void setup() {
    Heltec.begin(true /*DisplayEnable Enable*/, true /*Heltec.LoRa Disable*/, true /*Serial Enable*/, true /*PABOOST Enable*/, BAND /*long BAND*/);

  Serial.begin(115200);
  delay(1000);            
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);                                  
  Serial.print("Connecting to ");
  Serial.print(WIFI_SSID);
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Heltec.display->flipScreenVertically();
  Heltec.display->setTextAlignment(TEXT_ALIGN_LEFT);
  Heltec.display->setFont(ArialMT_Plain_10);
  Heltec.display->clear();
  Heltec.display->drawString(0, 10, "wifi connected");
  // write the buffer to the display
  Heltec.display->display();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Serial.print("done");
  if (Firebase.getString("/active")!="1"){
    Firebase.setString("/","");}
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
  printLocalTime();
}
int a=0;
int count=0;
void addtofirebase(String loc,String d1,String time1)
{
  count+=1;
  Firebase.setString("/live/"+String(count),loc+d1+","+time1);
  Serial.print("added data");
}


void loop(){
  int packetSize = LoRa.parsePacket();
  Serial.println(packetSize);
  if (packetSize) {
    // received a packet
    Serial.print("Received packet '");
    // read packet
    String da="";
    while (LoRa.available()) {
      data1=(char)LoRa.read();
      Serial.print(data1);
      a=1;
      da+=data1;
    }
    Heltec.display->clear();
    Heltec.display->drawString(0, 10, "wifi connected");
    Heltec.display->drawString(0, 50, da);
  // write the buffer to the display
  Heltec.display->display();
    
    addtofirebase("13.114097, 77.576461,",da,printLocalTime());
    // print RSSI of packet
    Serial.print(" with RSSI ");
    Serial.println(LoRa.packetRssi());
  }
  }
