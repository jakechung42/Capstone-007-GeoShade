/* 
 *  This code is for testing the 9-DOF IMU's with the I2C multiplexer TCA9548A
 *  This code uses serial communication and doesn't involve Matlab yet
 */
#include <Wire.h>
#include <SPI.h>
//#include <Adafruit_LSM9DS1.h>
//#include <Adafruit_Sensor.h> //required
#include <Arduino_LSM9DS1.h>
#include <Arduino.h>
#include "TCA9548A.h"

TCA9548A I2CMux;     // Address can be passed into the constructor

void setup() 
{
  Serial.begin(115200);
  I2CMux.begin(Wire);             // TwoWire isntance can be passed here as 3rd argument
  while (!Serial) {
    delay(1); // will pause Zero, Leonardo, etc until serial console opens
  }
  I2CMux.closeAll();              // Set a base state which we know (also the default state on power on)
  
  // Try to initialise and warn if we couldn't detect the chip
  I2CMux.openChannel(0);
  if (!IMU.begin())
  {
    Serial.println("Oops ... unable to initialize the LSM9DS1. Check your wiring!");
    while (1);
  }
  
  Serial.println("Found LSM9DS1 9DOF");
  Serial.print("Gyroscope sample rate = ");
  Serial.print(IMU.gyroscopeSampleRate());
  Serial.println(" Hz");
  Serial.println();
  Serial.println("Gyroscope in degrees/second");
  Serial.println("X\tY\tZ");
  I2CMux.closeChannel(0);
}


void loop(void) 
{
  float x, y, z;
  I2CMux.openChannel(0);
  
  if (IMU.gyroscopeAvailable()) {
    IMU.readGyroscope(x, y, z);

    Serial.print(x);
    Serial.print('\t');
    Serial.print(y);
    Serial.print('\t');
    Serial.println(z);   
  }
  Serial.println();
  delay(10);
  I2CMux.closeAll();  
}
