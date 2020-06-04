/* 
 *  This code is for testing the 9-DOF IMU's with the I2C multiplexer TCA9548A
 *  This code uses serial communication and doesn't involve Matlab yet
 */
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <SPI.h>
#include <Adafruit_LSM9DS1.h>
#include <Adafruit_Sensor.h> //required

#define TCAADDR 0x70 //define for multiplexer

//i2c setup
Adafruit_LSM9DS1 lsm = Adafruit_LSM9DS1();
//Adafruit_LSM9DS1 lsm2 = Adafruit_LSM9DS1(2);

//tcaselect for the multiplexer
void tcaselect(uint8_t i) {
  if (i > 7) return;
 
  Wire.beginTransmission(TCAADDR);
  Wire.write(1 << i);
  Wire.endTransmission();  
}

void setupSensor()
{
  tcaselect(0);
  //set up for first sensor
  // 1.) Set the accelerometer range
  lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_2G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_4G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_8G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_16G);
 
  // 2.) Setup the gyroscope
  lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_245DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_500DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_2000DPS);
/*
  tcaselect(1);
  //set up for second sensor
  // 1.) Set the accelerometer range
  lsm2.setupAccel(lsm2.LSM9DS1_ACCELRANGE_2G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_4G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_8G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_16G);
 
  // 2.) Setup the gyroscope
  lsm2.setupGyro(lsm2.LSM9DS1_GYROSCALE_245DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_500DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_2000DPS);
*/
}


void setup() 
{
  Serial.begin(115200);

  while (!Serial) {
    delay(500); // will pause Zero, Leonardo, etc until serial console opens
  }

  //initiate the 1st sensor
  tcaselect(0);
  delay(200);
  // Try to initialise and warn if we couldn't detect the chip
  if (!lsm.begin())
  {
    Serial.println("Oops ... unable to initialize the LSM9DS1. Check your wiring!");
    while (1);
  }
  Serial.println("Found LSM9DS1 9DOF");

  // helper to just set the default scaling we want, see above!
  setupSensor();
/*
  tcaselect(1);
  // Try to initialise and warn if we couldn't detect the chip
  if (!lsm2.begin())
  {
    Serial.println("Oops ... unable to initialize the LSM9DS1. Check your wiring!");
    while (1);
  }
  Serial.println("Found LSM9DS1 9DOF");
*/

  // helper to just set the default scaling we want, see above!
  //setupSensor();
}

void loop(void) 
{
  lsm.read();  /* ask it to read in the data */ 
 // lsm2.read();  /* ask it to read in the data */ 
  
  
  tcaselect(0);
  /* Get a new sensor event */ 
  sensors_event_t a, m, g, temp;
  lsm.getEvent(&a, &m, &g, &temp); 
 
  /* Display the results*/
  Serial.print("Sensor #1 - ");
  Serial.print("Accel X: "); Serial.print(a.acceleration.x); 
  Serial.print("\tY: "); Serial.print(a.acceleration.y);     
  Serial.print("\tZ: "); Serial.print(a.acceleration.z);     

  Serial.print("Gyro X: "); Serial.print(g.gyro.x);  
  Serial.print("\tY: "); Serial.print(g.gyro.y);      
  Serial.print("\tZ: "); Serial.print(g.gyro.z);     

  Serial.println();
/*  
  tcaselect(1);
 
  sensors_event_t a, g, temp;
  lsm2.getEvent(&a, &g, &temp); 
  

  Serial.print("Sensor #2 - ");
  Serial.print("Accel X: "); Serial.print(a.acceleration.x); 
  Serial.print("\tY: "); Serial.print(a.acceleration.y);    
  Serial.print("\tZ: "); Serial.print(a.acceleration.z);     

  Serial.print("Gyro X: "); Serial.print(g.gyro.x);   
  Serial.print("\tY: "); Serial.print(g.gyro.y);      
  Serial.print("\tZ: "); Serial.print(g.gyro.z);     
    
  Serial.println();
*/
  delay(500);
}
