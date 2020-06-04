/*
 * This program is to test the serial communication of the OpenCM 9.04 and the Due.
 * The Dynamixel is programmed to oscillate and send the angular position via serial to the Due
 */
#include <DynamixelWorkbench.h>
#define SAMP_SIZE 100

//intiate the dxl instance
DynamixelWorkbench dxl_wb;

//define the variables
int Amp = 30; //amplitude of the sine wave
float SineFreq = 3; //frequency of the sine wave for the dynamixel to oscillate
int i = 0; //counter
int low = -1;
int high = -1;
int32_t SetPoint[SAMP_SIZE]; //store the values of the sinusoidal input
uint32_t get_data_1;
uint32_t get_data_2;

void setup() {
  //Serial1 uses the TX1 and DX1 pins on the OpenCM. Pin 11 and 12
  Serial2.begin(250000);
  Serial2.println("Begin transmission");
  //set ID for the Dynamixels
  uint8_t D1 = 1;
  //initialize the AX12's
  dxl_wb.init("1", 1000000); //always set this to be 1
  //ping the motors
  uint16_t model_number1 = 0;
  dxl_wb.ping(D1, &model_number1);

  /***** Compute Sine Wave and store in array *****/
  for (i=1; i<SAMP_SIZE; ++i){
    SetPoint[i] = Amp*sin((SineFreq*6.2832/SAMP_SIZE)*i)+512;
  }
  SetPoint[0] = (int32_t)512; //fix the initial value of the sine wave
}

void loop() {
  if (i>=SAMP_SIZE){
    i = 0; 
  }
  //send desired position to the AX12
  dxl_wb.goalPosition(D1, SetPoint[i]);
  delay(10);
  //decompose the desired position to send to Due
  dxl_wb.readRegister(D1, (uint16_t)36, (uint16_t)1, &get_data_1);
  dxl_wb.readRegister(D1, (uint16_t)37, (uint16_t)1, &get_data_2);
  Serial2.write((uint8_t)get_data_1);
  Serial2.write((uint8_t)get_data_2);
  
  //increment to the next i-th value
  ++i;
}
