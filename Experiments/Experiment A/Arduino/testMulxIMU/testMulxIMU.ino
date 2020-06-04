/* 
 *  This code is for testing the 9-DOF IMU's with the I2C multiplexer TCA9548A
 *  This code uses serial communication and doesn't involve Matlab yet
 */
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <SPI.h>
#include <Adafruit_LSM9DS1.h>
#include "TCA9548A.h"

//i2c setup
Adafruit_LSM9DS1 lsm1 = Adafruit_LSM9DS1();
Adafruit_LSM9DS1 lsm2 = Adafruit_LSM9DS1();

TCA9548A I2CMux;     // Address can be passed into the constructor

void setupSensor()
{
  I2CMux.openChannel(0);
  //set up for first sensor
  // 1.) Set the accelerometer range
  lsm1.setupAccel(lsm1.LSM9DS1_ACCELRANGE_2G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_4G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_8G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_16G);
 
  // 2.) Setup the gyroscope
  lsm1.setupGyro(lsm1.LSM9DS1_GYROSCALE_245DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_500DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_2000DPS);
  I2CMux.closeChannel(0);
  
  I2CMux.openChannel(1);
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
  I2CMux.closeChannel(1);
}


void setup() 
{
  Serial.begin(250000);
  I2CMux.begin(Wire);             // TwoWire isntance can be passed here as 3rd argument
  while (!Serial) {
    delay(1); // will pause Zero, Leonardo, etc until serial console opens
  }
  I2CMux.closeAll();              // Set a base state which we know (also the default state on power on)
  
  I2CMux.openChannel(0);
  // Try to initialise and warn if we couldn't detect the chip
  if (!lsm1.begin())
  {
    Serial.println("Oops ... unable to initialize the first LSM9DS1. Check your wiring!");
    while (1);
  }
  Serial.println("Found LSM9DS1 9DOF");

  I2CMux.openChannel(1);
  // Try to initialise and warn if we couldn't detect the chip
  if (!lsm2.begin())
  {
    Serial.println("Oops ... unable to initialize the second LSM9DS1. Check your wiring!");
    while (1);
  }
  Serial.println("Found LSM9DS1 9DOF");

  I2CMux.closeAll();
  setupSensor();
}

void loop(void) 
{
 // lsm1.read();  /* ask it to read in the data */ 
 // lsm2.read();  /* ask it to read in the data */ 

  /* Get a new sensor event */ 
  sensors_event_t a, m, g, temp;
  I2CMux.openChannel(0);
  
  lsm1.getEvent(&a, &m, &g, &temp); 
 
  /* Display the results*/
  Serial.print("Sensor #1 - ");
  Serial.print("Accel X: "); Serial.print(a.acceleration.x); 
  Serial.print("\tY: "); Serial.print(a.acceleration.y);     
  Serial.print("\tZ: "); Serial.print(a.acceleration.z);     

  Serial.println();
  
  Serial.print("Gyro X: "); Serial.print(g.gyro.x);  
  Serial.print("\tY: "); Serial.print(g.gyro.y);      
  Serial.print("\tZ: "); Serial.print(g.gyro.z);     

  Serial.println();

  I2CMux.closeChannel(0);
  I2CMux.openChannel(1);
  /* Get a new sensor event */ 
  lsm2.getEvent(&a, &m, &g, &temp); 
  
  /* Display the results*/
  Serial.print("Sensor #2 - ");
  Serial.print("Accel X: "); Serial.print(a.acceleration.x); 
  Serial.print("\tY: "); Serial.print(a.acceleration.y);    
  Serial.print("\tZ: "); Serial.print(a.acceleration.z);     

  Serial.println();
  
  Serial.print("Gyro X: "); Serial.print(g.gyro.x);   
  Serial.print("\tY: "); Serial.print(g.gyro.y);      
  Serial.print("\tZ: "); Serial.print(g.gyro.z);     
    
  Serial.println();
  delay(10);
  I2CMux.closeAll();
}
