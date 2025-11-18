import processing.serial.*;

Serial miPuerto;
int valE1 = 0; //estado entrada 1
int valE2 = 0; //estado entrada 2
boolean estadoL1 = false;
boolean estadoL2 = false;

void setup() {
  size(400, 300);
  printArray(Serial.list());
  //habria que cambiar el [0] por el puerto com que se use cuando se conecte el arduino
  //como en este caso se realizo con un simulador, se deja en [0]
  miPuerto = new Serial(this, Serial.list()[0], 9600);
  miPuerto.bufferUntil('\n'); // Leer hasta salto de línea
}

void draw() {
  background(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  stroke(0);

  // --- SECCIÓN ENTRADAS (Cuadrados) [cite: 6, 14, 15] ---
  fill(100, 150, 255); 
  text("Entradas", 80, 50);
  
  // E1
  if (valE1 == 1) fill(0, 255, 0); else fill(255); // Verde si activo
  rect(200, 35, 50, 30);
  fill(0); text("E1", 225, 50);
  
  // E2
  if (valE2 == 1) fill(0, 255, 0); else fill(255);
  rect(300, 35, 50, 30);
  fill(0); text("E2", 325, 50);

  // --- SECCIÓN SALIDAS (Círculos) [cite: 6, 17, 18] ---
  fill(255, 200, 150);
  text("Salidas", 80, 150);

  // L1
  if (estadoL1) fill(255, 0, 0); else fill(255); // Rojo si activo
  ellipse(225, 150, 50, 50);
  fill(0); text("L1", 225, 150);

  // L2
  if (estadoL2) fill(255, 0, 0); else fill(255);
  ellipse(325, 150, 50, 50);
  fill(0); text("L2", 325, 150);
}

// Evento de clic para activar salidas 
void mousePressed() {
  // Distancia del clic al centro de L1
  if (dist(mouseX, mouseY, 225, 150) < 25) {
    miPuerto.write('1'); // Enviar comando a Arduino
    estadoL1 = !estadoL1; // Actualizar visual localmente
  }
  // Distancia del clic al centro de L2
  if (dist(mouseX, mouseY, 325, 150) < 25) {
    miPuerto.write('2');
    estadoL2 = !estadoL2;
  }
}

// Lectura de datos desde Arduino [cite: 9]
void serialEvent(Serial p) {
  String inString = p.readString();
  if (inString != null) {
    inString = trim(inString);
    String[] valores = split(inString, ',');
    if (valores.length == 2) {
      valE1 = int(valores[0]);
      valE2 = int(valores[1]);
    }
  }
}
