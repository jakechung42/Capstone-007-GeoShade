//This program is to test the serial communication of the Due with the OpenCM9.04
int readVal = 0;
int low = -1;
int high = -1;

void setup() {
  //Set up the serial port for the computer
  Serial.begin(57600);
  //Set up the serial port to the communication with OpenCM
  Serial1.begin(57600);
  Serial.print("Begining receive\n");
}

void loop() {
    //keep reading the values sent from the OpenCM
    //if (Serial.available()){
    //if serial port is available, write to the computer values from the OpenCM
    low = Serial1.read();
    high = Serial1.read();
    //recombine the low and high values to get the angle
    readVal = low+high*256;
    Serial.println(readVal);
    delay(10);
  //}
}
