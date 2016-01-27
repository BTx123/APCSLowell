public void setup() {
  size(400, 400);
  background(0);
}
public void draw() {
  sierpinski(0, height, width);
}
public void sierpinski(float x, float y, float len) {
  float eqHeight = (float) Math.sqrt(3)*len/2;
  noStroke();
  fill(255);
  if (len >= 20) {
    sierpinski(x, y, len/2);
    sierpinski(x+len/2, y, len/2);
    sierpinski(x+len/4, y-len/2, len/2);
  } else {
    triangle(x, y, x+len, y, x+len/2, y-eqHeight);
  }
}