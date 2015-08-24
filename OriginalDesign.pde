/* Normal Original Design
 * Author: Brian Tom
 * Date: 8/21/2015
 * Description: 
 */

Walker w;

void setup() {
  size(1280, 720);
  w = new Walker();
}

float d = 0;
int velocity = 3;

void draw() {
//  background(0);
//  noStroke();
//  int bounds = minBounds();
//  fill(255, 255, 255, -0.0005*d*d - 0.0009*d + 255);
//  ellipse(width/2, height/2, d, d);
//  d += velocity;
//  if (d <= 0 || d >= bounds) {
//    velocity *= -1;
//  }
  w.step(2);
  w.display();
}

// Returns smaller size() dimension
int minBounds() {
  if (height <= width) {
    return height;
  } else {
    return width;
  }
}

