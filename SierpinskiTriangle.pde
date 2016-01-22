public void setup() {
  size(400, 400);
  background(0);
  sierpinski(0, 400, 1);
}
public void draw() {
  
}
public void sierpinski(float x, float y, int n) {
  float base = n/2.0;
  float triHeight = base * (float) Math.sin(Math.PI/3);
  if (n < 20) {
    noStroke();
    fill(255);
    triangle(x, y, x+base, y, x+base/2.0, y-triHeight);
  }
}