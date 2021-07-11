#include <DHT.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <ArduinoJson.h>

DynamicJsonDocument doc(1024);

//Constants
#define DHTPIN 7     // what pin we're connected to
#define DHTTYPE DHT22   // DHT 22  (AM2302)
#define ONE_WIRE_BUS 5
DHT dht(DHTPIN, DHTTYPE); //// Initialize DHT sensor for normal 16mhz Arduino
volatile int flow_frequency; // Measures flow sensor pulses
unsigned int l_hour; // Calculated litres/hour
unsigned char flowsensor = 2; // Sensor Input
unsigned long currentTime;
unsigned long cloopTime;
unsigned long previousMillis = 0;
const long interval = 60000; 
int sensorPin = A1; // select the input pin for LDR
int sensorValue = 0; // variable to store the value coming from the sensor

#define SensorPin 0          // the pH meter Analog output is connected with the Arduino’s Analog
unsigned long int avgValue;  //Store the average value of the sensor feedback
float b;
int buf[10],tempo;
OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);
float Celcius=0;
//Variables
int motorsol = 13;
int fansol = 12;
int acidicsol= 11;
int basicsol = 10;
int ledState = HIGH;
int light = 3;
int chk;
float hum;  //Stores humidity value
float temp; //Stores temperature value
int outputValue = 0;
void flow () // Interrupt function
{
   flow_frequency++;
}

void setup()
{
  Serial.begin(9600);
  pinMode(flowsensor, INPUT); 
  pinMode(motorsol, OUTPUT);
  pinMode(acidicsol, OUTPUT);
  pinMode(fansol, OUTPUT);
  pinMode(basicsol, OUTPUT);
  dht.begin();
   digitalWrite(flowsensor, HIGH); // Optional Internal Pull-Up
   attachInterrupt(0, flow, RISING); // Setup Interrupt
   sei(); // Enable interrupts
   currentTime = millis();
   cloopTime = currentTime;
   sensors.begin();
}

void loop()
{
   sensors.requestTemperatures(); 
  Celcius=sensors.getTempCByIndex(0);
  
  for(int i=0;i<10;i++)       //Get 10 sample value from the sensor for smooth the value
  { 
    buf[i]=analogRead(SensorPin);
    delay(10);
  }
  for(int i=0;i<9;i++)        //sort the analog from small to large
  {
    for(int j=i+1;j<10;j++)
    {
      if(buf[i]>buf[j])
      {
        tempo=buf[i];
        buf[i]=buf[j];
        buf[j]=tempo;
      }
    }
  }
    avgValue=0;
  for(int i=2;i<8;i++)                      //take the average value of 6 center sample
    avgValue+=buf[i];
  float phValue=(float)avgValue*5.0/1024/6; //convert the analog into millivolt
  phValue=3.5*phValue; 
  doc["ph"] =  phValue;
  //convert the millivolt into pH value
 
   //Read data and store it to variables hum and temp
    currentTime = millis();
    unsigned long currentMillis = millis();
    
    if(currentTime >= (cloopTime + 1000))
   {
      cloopTime = currentTime; // Updates cloopTime
      l_hour = (flow_frequency * 60 / 7.5); // (Pulse frequency x 60 min) / 7.5Q = flowrate in L/hour
      flow_frequency = 0; // Reset Counter
       hum = dht.readHumidity();
    outputValue = map(hum, 80, 0, 0,255);
    temp= dht.readTemperature();
    if (currentMillis - previousMillis >= interval){
       previousMillis = currentMillis;
      if (ledState == LOW) {
      ledState = HIGH;
     // Serial.println("1");
    } else {
      ledState = LOW;
     // Serial.println("0");
    }
    }
    digitalWrite(motorsol, ledState);
    sensorValue = analogRead(sensorPin); // read the value from the sensor
  if(temp >=28){
    digitalWrite(fansol,HIGH);

   doc["fan"] = fansol;
  }else{                                              // Otherwise turn on LED
  digitalWrite(fansol,LOW);
    doc["fan"] = 0;
  }
  if (phValue <= 6.5){
    digitalWrite(acidicsol,HIGH);
  }else{
  digitalWrite(acidicsol,LOW);
   }
    if (phValue >= 7.5){
    digitalWrite(basicsol,HIGH);
  }else{
  digitalWrite(basicsol,LOW);
   }
    if (sensorValue >= 100){
    digitalWrite(light,LOW);
  }else{
  digitalWrite(light,HIGH);
   }
   }

   doc["temperature"] = temp;
   doc["humidity"] = hum;
   doc["flow"] = l_hour;
   doc["light"] = ledState;
   doc["water_temp"] = Celcius;
   doc["ph"] =  phValue;
   serializeJson(doc, Serial);
   delay(5000); //Delay 5 sec.
}
