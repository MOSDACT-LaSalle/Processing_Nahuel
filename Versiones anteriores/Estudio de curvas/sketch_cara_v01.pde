int nosex = 500;
int nosey = 500;

void setup() {
  size(1000, 1000);
  noFill();
}

void draw() {
  background(255);

  // Print the mouse position to the console
  println("Mouse X: " + mouseX + ", Mouse Y: " + mouseY);

  // Draw the nose
  beginShape();
  curveVertex(500, 750);
  curveVertex(200, 500);
  curveVertex(48, 500);
  curveVertex(100, 300);
  curveVertex(105, 300);
  
  endShape();
  
  //Forehead con bezier
  
  beginShape();
  vertex(100, 300);
  bezierVertex(50, 450, 70, 5, 40, 35); // C1, C2, V2
  bezierVertex(5, 70, 45, 105, 70, 70); // C3, C4, V3
endShape();
//prueba autocad
beginShape();
  vertex(532, 741);
  bezierVertex(823, 853, 728, 1139, 583, 791); // C1, C2, V2
  
endShape();
}
