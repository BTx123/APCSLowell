/* Original Fractal //<>//
 * Author: Brian Tom
 * Date: 2/8/16
 * Description: 
 */

int n = 20;
int[] colors = new int[10];

public void setup() {
  size(800, 800);
  background(0);
}

public void draw() {
  original(width/2, height/2, width/2, n);
  noLoop();
}

public void original(float x, float y, float w, int n) {
  float fac = w/2;
  if (w > n) {
    original(x, y, fac, n);
    original(x-fac, y-fac, fac, n);
    original(x-fac, y+fac, fac, n);
    original(x+fac, y-fac, fac, n);
    original(x+fac, y+fac, fac, n);
  }
  noStroke();
  fill((int) (Math.random()*255));
  rectMode(CENTER); //<>//
  rect(x, y, w, w, w/10);
  fill(0);
  //ellipse(x, y, w/1.1, w/1.1);
}
public void mousePressed() {
  loop();
}