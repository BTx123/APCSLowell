public void setup() {
  size(400, 400);
  background(255);
  sierpinski(0, height, width);
}
public void draw() {
}
public void sierpinski(float x, float y, float len) {
  //float base = len/2.0;
  //float triHeight = base * (float) Math.sin(Math.PI/3);
  fill(0);
  if (len >= 20) {
    triangle(x, y, x+len/2, y, x+len/4, y-len/2);
    sierpinski(x, y, len/2);
    sierpinski(x+len/2, y, len/2);
    sierpinski(x+len/4, y-len/2, len/2);
  } else {
    triangle(x, y, x+len/2, y, x+len/4, y-len/2);
  }
}