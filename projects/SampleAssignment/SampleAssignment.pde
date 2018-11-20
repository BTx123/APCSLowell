/* Resizable Smiley Face
 * Author: Brian Tom
 * Date: 8/20/2015
 * Description: Resize face by changing d (width and height)
 */

void setup() {
  size(640, 480);
}

// Smiley face function
void smileyFace(int x, int y, int d) {
  // Face
  fill(255, 255, 0);
  ellipse(x, y, d, d);
  // Mouth
  arc(x, y, 0.75*d, 0.75*d, PI/8, 7*PI/8);
  // Eyes
  fill(0, 0, 0);
  ellipse(x - 0.15*d, y - 0.2*d, 0.125*d, 0.1875*d);
  ellipse(x + 0.15*d, y - 0.2*d, 0.125*d, 0.1875*d);
}

int x = 320;
int d = 400;
int dir = 3; //<>//

void draw() {
  background(100, 100, 100);
  smileyFace(x, height/2, d);
  x += dir;
  if (x < d/2 || x > width - d/2) {
    dir *= -1;
  }
}
