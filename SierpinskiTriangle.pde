float xPos, yPos, len, xOff, yOff, lim;
public void setup() {
  size(800, 800);
  len = width;
  xPos = width/2;
  yPos = height/2;
  lim = 20;
}
public void draw() {
  background(0);
  xOff = len/2;
  yOff = len/2;
  changeSize();
  sierpinski(xPos, yPos, len);
  text("Length: " + len, 0, 10);
  text("Limit: " + lim, 0, 20);
}
public void sierpinski(float x, float y, float len) {
  noStroke();
  fill(255);
  if (len >= lim) {
    x = x-len/4;
    y = y+len/4;
    sierpinski(x, y, len/2);
    sierpinski(x+len/2, y, len/2);
    sierpinski(x+len/4, y-len/2, len/2);
  } else {
    triangle(x, y, x+len, y, x+len/2, y-len);
  }
}
public void keyPressed() {
  if (key == 'r') {
    len = width;
    xPos = width/2;
    yPos = height/2;
    lim = 20;
  } else if (lim < len && keyCode == LEFT) lim++;
  else if (lim > 1 && keyCode == RIGHT) lim--;
}
public void changeSize() {
  int n = 10;
  if (len > 0 && mousePressed == true && mouseButton == RIGHT) {
    len -= n;
  }
  if (mousePressed == true && mouseButton == LEFT) {
    len += n;
  }
}