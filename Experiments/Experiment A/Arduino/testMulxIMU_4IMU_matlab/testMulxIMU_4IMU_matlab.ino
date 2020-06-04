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
Adafruit_LSM9DS1 lsm3 = Adafruit_LSM9DS1();
Adafruit_LSM9DS1 lsm4 = Adafruit_LSM9DS1();


//communication with OpenCM setup 
int readVal = 0;
int low = -1;
int high = -1;

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
  //lsm1.setupGyro(lsm1.LSM9DS1_GYROSCALE_245DPS);
  lsm1.setupGyro(lsm1.LSM9DS1_GYROSCALE_500DPS);
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
  //lsm2.setupGyro(lsm2.LSM9DS1_GYROSCALE_245DPS);
  lsm2.setupGyro(lsm2.LSM9DS1_GYROSCALE_500DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_2000DPS);
  I2CMux.closeChannel(1);

  I2CMux.openChannel(2);
  //set up for second sensor
  // 1.) Set the accelerometer range
  lsm3.setupAccel(lsm3.LSM9DS1_ACCELRANGE_2G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_4G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_8G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_16G);
 
  // 2.) Setup the gyroscope
  //lsm2.setupGyro(lsm2.LSM9DS1_GYROSCALE_245DPS);
  lsm3.setupGyro(lsm3.LSM9DS1_GYROSCALE_500DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_2000DPS);
  I2CMux.closeChannel(2);

  I2CMux.openChannel(3);
  //set up for second sensor
  // 1.) Set the accelerometer range
  lsm4.setupAccel(lsm4.LSM9DS1_ACCELRANGE_2G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_4G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_8G);
  //lsm.setupAccel(lsm.LSM9DS1_ACCELRANGE_16G);
 
  // 2.) Setup the gyroscope
  //lsm2.setupGyro(lsm2.LSM9DS1_GYROSCALE_245DPS);
  lsm4.setupGyro(lsm4.LSM9DS1_GYROSCALE_500DPS);
  //lsm.setupGyro(lsm.LSM9DS1_GYROSCALE_2000DPS);
  I2CMux.closeChannel(3);
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

  I2CMux.openChannel(2);
  // Try to initialise and warn if we couldn't detect the chip
  if (!lsm3.begin())
  {
    Serial.println("Oops ... unable to initialize the third LSM9DS1. Check your wiring!");
    while (1);
  }
  Serial.println("Found LSM9DS1 9DOF");

  I2CMux.openChannel(3);
  // Try to initialise and warn if we couldn't detect the chip
  if (!lsm4.begin())
  {
    Serial.println("Oops ... unable to initialize the fourth LSM9DS1. Check your wiring!");
    while (1);
  }
  Serial.println("Found LSM9DS1 9DOF");

  I2CMux.closeAll();
  setupSensor();

  //initiate serial port for communication with OpenCM
  Serial1.begin(250000);
}

void loop(void) 
{
  Serial.print(millis());
  Serial.print(",");
  /* Get a new sensor event */ 
  sensors_event_t a, m, g, temp;
  I2CMux.openChannel(0);
  
  lsm1.getEvent(&a, &m, &g, &temp); 
 
  /* Display the results*/
  Serial.print(a.acceleration.x); 
  Serial.print(","); 
  Serial.print(a.acceleration.y);     
  Serial.print(","); 
  Serial.print(a.acceleration.z);  
  Serial.print(",");    
 
  Serial.print(g.gyro.x);  
  Serial.print(","); 
  Serial.print(g.gyro.y);  
  Serial.print(",");     
  Serial.print(g.gyro.z);     
  Serial.print(","); 

  I2CMux.closeChannel(0);
  I2CMux.openChannel(1);
  /* Get a new sensor event */ 
  lsm2.getEvent(&a, &m, &g, &temp); 
  
  /* Display the results*/
  Serial.print(a.acceleration.x);
  Serial.print(",");  
  Serial.print(a.acceleration.y);    
  Serial.print(","); 
  Serial.print(a.acceleration.z); 
  Serial.print(",");     

  Serial.print(g.gyro.x);  
  Serial.print(",");  
  Serial.print(g.gyro.y);      
  Serial.print(","); 
  Serial.print(g.gyro.z); 
  Serial.print(",");    

  I2CMux.closeChannel(1);
  I2CMux.openChannel(2);
  
  lsm3.getEvent(&a, &m, &g, &temp); 
 
  /* Display the results*/
  Serial.print(a.acceleration.x); 
  Serial.print(","); 
  Serial.print(a.acceleration.y);     
  Serial.print(","); 
  Serial.print(a.acceleration.z);  
  Serial.print(",");    
 
  Serial.print(g.gyro.x);  
  Serial.print(","); 
  Serial.print(g.gyro.y);  
  Serial.print(",");     
  Serial.print(g.gyro.z);     
  Serial.print(","); 

  I2CMux.closeChannel(2);
  I2CMux.openChannel(3);
  
  lsm4.getEvent(&a, &m, &g, &temp); 
 
  /* Display the results*/
  Serial.print(a.acceleration.x); 
  Serial.print(","); 
  Serial.print(a.acceleration.y);     
  Serial.print(","); 
  Serial.print(a.acceleration.z);  
  Serial.print(",");    
 
  Serial.print(g.gyro.x);  
  Serial.print(","); 
  Serial.print(g.gyro.y);  
  Serial.print(",");     
  Serial.print(g.gyro.z);     
  Serial.print(","); 

  I2CMux.closeChannel(3);
  //read data sent from the OpenCM
  while (Serial1.available() <=1 ){
    //wait for the serial to collect data
  }

  low = Serial1.read();
  high = Serial1.read();
  //combine the low and high value to make up the value
  readVal = low+high*256;
  Serial.println(readVal);
  I2CMux.closeAll();
}
