/*
  Esta es la ultima version de las 190 tortugas que componen la obra final
*/

float turtleX, turtleY; // Posición de la tortuga
float angle = 0; // Ángulo para la animación de la tortuga
float turtleMovement = 0; // Movimiento de la tortuga
Bubble[] bubbles; // Array de burbujas

void setup() {
  size(1600, 900);
  background(135, 206, 235); // Color del cielo
  noLoop();

  // Ubicar la tortuga en el centro
  turtleX = width / 2;
  turtleY = height / 2;

  // Inicializar burbujas
  bubbles = new Bubble[100];
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i] = new Bubble(random(width), height); // Iniciar las burbujas desde el fondo
  }

  drawUnderwaterScene();

  // Guardar la imagen en el escritorio
  //String path = System.getProperty("user.home") + "/Desktop/tortuga_realista_" + int(random(1000, 9999)) + ".png";
  //save(path);
}

void draw() {
  background(135, 206, 235); // Color del cielo
  drawUnderwaterScene();

  // Actualizar posición y ángulo de la tortuga para simular movimiento
  turtleMovement += 0.01;
  turtleX = width / 2 + sin(turtleMovement) * 30; // Movimiento horizontal
  turtleY = height / 2 + cos(turtleMovement) * 20; // Movimiento vertical

  // Actualizar las burbujas
  for (Bubble b : bubbles) {
    b.update();
    b.display();
  }
}

void drawUnderwaterScene() {
  drawWaterBackground();
  drawUnderwaterLightRays();
  drawCoralReefs();
  drawSeaweed();
  drawSand();

  // Posición de la tortuga en el centro
  drawRealisticTurtle(turtleX, turtleY);

  // Peces de diferentes colores y formas
  for (int i = 0; i < 75; i++) { // Aumentar el número de peces
    drawRealisticFish(random(width), random(height), random(30, 70), color(random(50, 200), random(50, 255), random(50, 255)));
  }

  // Burbujeo y partículas en suspensión
  drawBubbles();
  drawSuspendedParticles();
}

void drawWaterBackground() {
  // Fondo de agua con gradiente
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    int c = lerpColor(color(0, 110, 150), color(0, 60, 90), inter); // Gradiente de agua profunda
    stroke(c);
    line(0, y, width, y);
  }

  // Efecto de oleaje en la superficie del agua
  for (int i = 0; i < 300; i++) {
    float rippleX = random(width);
    float rippleY = random(height / 4);
    drawWaterRipples(rippleX, rippleY, random(40, 100));
  }

  // Efecto de niebla para profundidad
  fill(0, 0, 0, 30);
  noStroke();
  rect(0, 0, width, height);

  // Aplicar un ligero desenfoque
  filter(BLUR, 0.5);
}

void drawWaterRipples(float x, float y, float radius) {
  for (int i = 0; i < 6; i++) {
    noFill();
    stroke(255, 255, 255, 90 - i * 12);
    strokeWeight(1.5);
    ellipse(x, y, radius + i * 15, radius + i * 15);
  }

  // Efecto de refracción de luz en el agua
  for (int j = 0; j < 3; j++) {
    noStroke();
    fill(255, 255, 255, 40);
    ellipse(x + random(-5, 5), y + random(-5, 5), radius * 0.6, radius * 0.6);
  }
}

void drawUnderwaterLightRays() {
  for (int i = 0; i < 50; i++) {
    float lightX = random(width);
    float lightWidth = random(100, 200);
    float lightHeight = height;

    noFill();
    stroke(255, 255, 240, 70);
    strokeWeight(random(1, 2));

    beginShape();
    vertex(lightX, 0);
    vertex(lightX + lightWidth, 0);
    vertex(lightX + lightWidth / 2, lightHeight);
    vertex(lightX, lightHeight);
    endShape(CLOSE);
  }
}

void drawCoralReefs() {
  for (int i = 0; i < 100; i++) { // Aumentar el número de corales
    float x = random(width);
    float y = height / 1.5 + random(150);
    drawCoralCluster(x, y);
  }
}

void drawCoralCluster(float x, float y) {
  // Corales con texturas detalladas y formas variadas
  for (int i = 0; i < 30; i++) {
    fill(255, 99, 71, 180 - i * 10);
    noStroke();
    ellipse(x + random(-30, 30), y + random(-30, 30), random(20, 60), random(20, 60));
  }

  // Texturas adicionales en los corales
  for (int j = 0; j < 50; j++) {
    fill(255, 150, 120, 100);
    ellipse(x + random(-30, 30), y + random(-30, 30), random(5, 20), random(5, 20));
  }
}

void drawSeaweed() {
  for (int i = 0; i < 800; i++) { // Aumentar el número de algas
    float x = random(width);
    float y = height / 1.3 + random(200);
    drawSeaweedPlant(x, y);
  }
}

void drawSeaweedPlant(float x, float y) {
  stroke(34, 139, 34, 220);
  strokeWeight(2);
  noFill();
  beginShape();
  for (int i = 0; i < 15; i++) {
    curveVertex(x + random(-10, 10), y - i * 25 + random(-15, 15)); // Movimiento de algas
  }
  endShape();

  // Textura y detalles adicionales en las algas
  fill(0, 255, 0, 100);
  noStroke();
  for (int j = 0; j < 8; j++) {
    ellipse(x + random(-10, 10), y - j * 25, random(10, 20), random(10, 20));
  }
}

void drawSand() {
  fill(194, 178, 128);
  noStroke();

  // Creación de partículas de arena con más detalles y sombras
  for (int i = 0; i < width; i += 5) {
    ellipse(i, height - 50 + random(-3, 3), 10, 6);
  }

  // Rocas pequeñas y partículas en la arena
  for (int j = 0; j < 50; j++) {
    fill(105, 105, 105, 150);
    ellipse(random(width), height - 50 + random(-5, 5), random(10, 30), random(10, 15));
  }
}

void drawRealisticTurtle(float turtleX, float turtleY) {
  drawTurtleBody(turtleX, turtleY);
  drawTurtleHead(turtleX, turtleY);
  drawTurtleLegs(turtleX, turtleY);
  drawTurtleTail(turtleX, turtleY);
}

void drawTurtleBody(float turtleX, float turtleY) {
  fill(34, 139, 34); // Color verde para el cuerpo
  noStroke();
  beginShape();
  vertex(turtleX - 100, turtleY); // Aumentar tamaño
  bezierVertex(turtleX - 150, turtleY - 60, turtleX + 150, turtleY - 60, turtleX + 100, turtleY);
  bezierVertex(turtleX + 70, turtleY + 50, turtleX - 70, turtleY + 50, turtleX - 100, turtleY);
  endShape(CLOSE);
}

void drawTurtleHead(float turtleX, float turtleY) {
  fill(34, 155, 34); // Color más claro para la cabeza
  noStroke();
  ellipse(turtleX, turtleY - 130, 180, 100); // Aumentar tamaño de la cabeza

  // Ojos de la tortuga
  fill(255);
  ellipse(turtleX - 50, turtleY - 130, 40, 30); // Ojo izquierdo
  ellipse(turtleX + 50, turtleY - 130, 40, 30); // Ojo derecho

  fill(0); // Color negro para las pupilas
  ellipse(turtleX - 50, turtleY - 130, 15, 15); // Pupila izquierda
  ellipse(turtleX + 50, turtleY - 130, 15, 15); // Pupila derecha

  // Boca de la tortuga
  fill(255, 224, 189); // Color carne para la boca
  arc(turtleX, turtleY - 100, 100, 50, 0, PI); // Boca
}

void drawTurtleLegs(float turtleX, float turtleY) {
  fill(34, 139, 34); // Color de las patas
  noStroke();
  ellipse(turtleX - 120, turtleY + 60, 100, 60); // Aumentar tamaño pata izquierda
  ellipse(turtleX + 120, turtleY + 60, 100, 60); // Aumentar tamaño pata derecha
  ellipse(turtleX - 80, turtleY + 150, 70, 40); // Aumentar tamaño pata trasera izquierda
  ellipse(turtleX + 80, turtleY + 150, 70, 40); // Aumentar tamaño pata trasera derecha
}

void drawTurtleTail(float turtleX, float turtleY) {
  fill(34, 139, 34); // Color de la cola
  noStroke();
  beginShape();
  vertex(turtleX, turtleY + 70); // Aumentar tamaño
  vertex(turtleX - 30, turtleY + 130); // Aumentar tamaño
  vertex(turtleX + 30, turtleY + 130); // Aumentar tamaño
  endShape(CLOSE);
}

void drawRealisticFish(float x, float y, float size, color fishColor) {
  fill(fishColor);
  noStroke();
  beginShape();
  vertex(x, y); // Cabeza del pez
  bezierVertex(x + size * 0.5, y - size * 0.5, x + size * 0.5, y + size * 0.5, x, y + size); // Cuerpo del pez
  bezierVertex(x - size * 0.5, y + size * 0.5, x - size * 0.5, y - size * 0.5, x, y); // Cola del pez
  endShape(CLOSE);

  // Ojos del pez
  fill(255);
  ellipse(x - size * 0.25, y - size * 0.25, size * 0.15, size * 0.1); // Ojo
  fill(0);
  ellipse(x - size * 0.25, y - size * 0.25, size * 0.05, size * 0.05); // Pupila
}

void drawBubbles() {
  for (Bubble b : bubbles) {
    b.update();
    b.display();
  }
}

void drawSuspendedParticles() {
  fill(255, 255, 255, 150); // Partículas blancas
  noStroke();
  for (int i = 0; i < 200; i++) {
    ellipse(random(width), random(height), random(2, 6), random(2, 6));
  }
}

// Clase para burbujas
class Bubble {
  float x;
  float y;
  float size;
  float speed;

  Bubble(float x, float y) {
    this.x = x;
    this.y = y;
    this.size = random(10, 30);
    this.speed = random(1, 3);
  }

  void update() {
    y -= speed; // Movimiento ascendente
    if (y < 0) {
      y = height; // Reiniciar burbuja al fondo
      x = random(width);
    }
  }

  void display() {
    fill(255, 255, 255, 150);
    noStroke();
    ellipse(x, y, size, size);
  }
}
