//Quick serial test for the Due
int i = 0;
void setup() {
  Serial.begin(57600);
}

void loop() {
  i = i++;
  Serial.print("Begin send\n");
  Serial.println(i);
  delay(500);
}
