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

int cols; // Número de columnas
int rows; // Número de filas
float cellWidth, cellHeight;
int totalTime = 120000; // 2 minutos en milisegundos
int startTime;

float[] startX, startY; // Coordenadas de inicio para cada flecha
float[] endX, endY;     // Coordenadas de fin para cada flecha
float[] thickness;      // Grosor de cada flecha
int numFlechas;         // Número de flechas

void setup() {
  size(1000, 1000);
  noFill();
  
  // Generar un número aleatorio de columnas y filas
  cols = int(random(5, 15)); // Por ejemplo, entre 5 y 15 columnas
  rows = int(random(5, 15)); // Por ejemplo, entre 5 y 15 filas
  
  cellWidth = width / cols;
  cellHeight = height / rows;
  startTime = millis();
  
  numFlechas = cols * rows; // Número de flechas igual a la cantidad de cells
  
  // Inicializar los arrays de coordenadas y grosor para las flechas
  startX = new float[numFlechas];
  startY = new float[numFlechas];
  endX = new float[numFlechas];
  endY = new float[numFlechas];
  thickness = new float[numFlechas];

  // Generar puntos de inicio y fin aleatorios y grosor para cada flecha
  for (int i = 0; i < numFlechas; i++) {
    startX[i] = random(0, width);
    startY[i] = random(0, height);
    endX[i] = random(0, width);
    endY[i] = random(0, height);
    
    // Asignar grosor: la mitad será más delgada
    if (i < numFlechas / 2) {
      thickness[i] = 2; // Flechas más delgadas
    } else {
      thickness[i] = 4; // Flechas más gruesas
    }
  }
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

  // Dibujar cada flecha
  for (int i = 0; i < numFlechas; i++) {
    float currentX = lerp(startX[i], endX[i], t);
    float currentY = lerp(startY[i], endY[i], t);

    // Dibujar la línea de la flecha
    stroke(0);
    strokeWeight(thickness[i]);
    line(startX[i], startY[i], currentX, currentY);

    // Dibujar la cabeza de la flecha
    drawArrowHead(currentX, currentY, atan2(endY[i] - startY[i], endX[i] - startX[i]));
  }

  // Detener la animación después de 2 minutos
  if (t >= 1) {
    noLoop();
  }
}

void drawShape(float centerX, float centerY, float w, float h) {
  beginShape();
  curveVertex(centerX, centerY + h * 0.25);
  curveVertex(centerX - w * 0.3, centerY);
  curveVertex(centerX - w * 0.45, centerY);
  curveVertex(centerX - w * 0.4, centerY - h * 0.25);
  curveVertex(centerX - w * 0.35, centerY - h * 0.25);
  endShape();
  
  beginShape();
  vertex(centerX - w * 0.4, centerY - h * 0.25);
  bezierVertex(centerX - w * 0.45, centerY, 
               centerX - w * 0.35, centerY - h * 0.9, 
               centerX - w * 0.4, centerY - h * 0.75);
  bezierVertex(centerX - w * 0.5, centerY - h * 0.65, 
               centerX - w * 0.35, centerY - h * 0.55, 
               centerX - w * 0.3, centerY - h * 0.7);
  endShape();
  
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
