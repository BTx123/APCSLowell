float xPos, yPos, len, eqHeight, xOff, yOff;
public void setup() {
  size(800, 800);
  len = width;
  eqHeight = (float) Math.sqrt(3)*len/2;
}
public void draw() {
  background(0);
  xPos = width/2;
  yPos = height/2;
  xOff = len/2;
  yOff = eqHeight/2;
  changeSize();
  sierpinski(xPos, yPos, len, eqHeight);
}
public void sierpinski(float x, float y, float base, float eqHeight) {
  noStroke();
  fill(255);
  if (base >= 3) {
    x = x-base/4;
    y = y+base/4;
    sierpinski(x, y, base/2, eqHeight/2);
    sierpinski(x+base/2, y, base/2, eqHeight/2);
    sierpinski(x+base/4, y-base/2, base/2, eqHeight/2);
  } else {
    triangle(x, y, x+base, y, x+base/2, y-eqHeight);
  }
}
public void changeSize() {
  int n = 10;
  if (len > 0 && mousePressed == true && mouseButton == RIGHT) {
    len -= n;
    eqHeight = (float) Math.sqrt(3)*len/2;
  }
  if (mousePressed == true && mouseButton == LEFT) {
    len += n;
    eqHeight = (float) Math.sqrt(3)*len/2;
  }
}