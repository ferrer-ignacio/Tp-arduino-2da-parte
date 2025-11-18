// Definición de pines
const int btn1 = 2;
const int btn2 = 3;
const int led1 = 12;
const int led2 = 13;

// Estados
bool estadoLed1 = false;
bool estadoLed2 = false;

void setup() {
  Serial.begin(9600); // Comunicación Serie
  pinMode(btn1, INPUT_PULLUP); // Pulsador a GND
  pinMode(btn2, INPUT_PULLUP);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
}

void loop() {
  // Leer pulsadores
  bool p1 = !digitalRead(btn1); 
  bool p2 = !digitalRead(btn2);

  //si se pulsa se prende el LED correspondiente
  if (p1) estadoLed1 = true;
  if (p2) estadoLed2 = true;

  //leer comandos desde processing
  if (Serial.available() > 0) {
    char comando = Serial.read();
    if (comando == '1') estadoLed1 = !estadoLed1; //Alternar LED 1
    if (comando == '2') estadoLed2 = !estadoLed2; //Alternar LED 2
  }

  digitalWrite(led1, estadoLed1);
  digitalWrite(led2, estadoLed2);

  //enviar estado de botones a processing
  Serial.print(p1);
  Serial.print(",");
  Serial.println(p2);

  delay(50);
}