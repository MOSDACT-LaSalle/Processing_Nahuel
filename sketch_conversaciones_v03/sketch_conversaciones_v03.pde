/*-------------------------------------
Name: Nahuel Jaureguialzo
Date: sept 2024
Tittle: Crowd conversations

Description: Este trabajo de arte generativo 
pretende simular el ruido que deriva de una conversación
de muchas personas, imposible de determinar el hilo conductor.
Es una escena jocosa y violenta;  contraponerlo con la serenidad 
que genera el orden de una "flecha", casi como el logo del 
DVD en la pantalla de reposo, esperamos que la flecha
tope y nos mantiene atentos. 
No es otra cosa que esa idea que nos desconecta pero nos permite aguantar.
No entiendo como podemos persistir en el ruido tanto tiempo,
sin embargo lo hacemos.
------------------------------------*/



int cols = 10; // Número de columnas
int rows = 10; // Número de filas
float cellWidth, cellHeight;
int totalTime = 120000; // 2 minutos en milisegundos
int startTime;

float startX, startY; // Coordenadas del punto de inicio
float endX, endY;     // Coordenadas del punto final

void setup() {
  size(1000, 1000);
  noFill();
  cellWidth = width / cols;
  cellHeight = height / rows;
  startTime = millis();

  // Generar puntos de inicio y fin aleatorios
  startX = random(0, width);
  startY = random(0, height);
  endX = random(0, width);
  endY = random(0, height);
}

void draw() {
  background(255);

  // Dibujar la cuadrícula de formas
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i * cellWidth;
      float y = j * cellHeight;
      
      float offsetX = random(-cellWidth * 0.2, cellWidth * 0.2);
      float offsetY = random(-cellHeight * 0.2, cellHeight * 0.2);

      drawShape(x + cellWidth / 2 + offsetX, y + cellHeight / 2 + offsetY, cellWidth * 0.8, cellHeight * 0.8);
    }
  }

  // Calcular el progreso del tiempo
  float elapsedTime = millis() - startTime;
  float t = map(elapsedTime, 0, totalTime, 0, 1);
  t = constrain(t, 0, 1);

  // Calcular la posición actual de la cabeza de la flecha
  float currentX = lerp(startX, endX, t);
  float currentY = lerp(startY, endY, t);

  // Dibujar la línea de la flecha
  stroke(0);
  strokeWeight(4);
  line(startX, startY, currentX, currentY);

  // Dibujar la cabeza de la flecha
  drawArrowHead(currentX, currentY, atan2(endY - startY, endX - startX));

  // Detener la animación después de 2 minutos
  if (t >= 1) {
    noLoop();
  }
}
// Dibujo de la nariz
void drawShape(float centerX, float centerY, float w, float h) {
  beginShape();
  curveVertex(centerX, centerY + h * 0.25);
  curveVertex(centerX - w * 0.3, centerY);
  curveVertex(centerX - w * 0.45, centerY);
  curveVertex(centerX - w * 0.4, centerY - h * 0.25);
  curveVertex(centerX - w * 0.35, centerY - h * 0.25);
  endShape();
  // dibujo de la frente
  beginShape();
  vertex(centerX - w * 0.4, centerY - h * 0.25);
  bezierVertex(centerX - w * 0.45, centerY, 
               centerX - w * 0.35, centerY - h * 0.9, 
               centerX - w * 0.4, centerY - h * 0.75);
  bezierVertex(centerX - w * 0.5, centerY - h * 0.65, 
               centerX - w * 0.35, centerY - h * 0.55, 
               centerX - w * 0.3, centerY - h * 0.7);
  endShape();
  //dibujo de la pera Autocad
  beginShape();
  vertex(centerX + w * 0.1, centerY + h * 0.25);
  bezierVertex(centerX + w * 0.3, centerY + h * 0.35, 
               centerX + w * 0.2, centerY + h * 0.9, 
               centerX + w * 0.15, centerY + h * 0.3);
  endShape();
}

void drawArrowHead(float x, float y, float angle) {
  pushMatrix();
  translate(x, y);
  rotate(angle);
  beginShape();
  vertex(-10, -5);
  vertex(0, 0);
  vertex(-10, 5);
  endShape(CLOSE);
  popMatrix();
}
