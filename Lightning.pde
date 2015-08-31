/* Lightning
 * Author: Brian Tom
 * Date: 8/31/2015
 * Description: Draws lightning bolts
 */

// Background color
color bgColor = color(30, 60, 127);

Lightning l = new Lightning();

void setup() {
  size(300, 300);
  strokeWeight(3);
  background(bgColor);
}

void draw() {
  l.display();
}

void mousePressed() {
  // reset background, deleting previous lightning bolt
  background(bgColor);
  // reset starting and endpoint
  startX = 0;
  startY = 150;
  endX = 0;
  endY = 150;
}

class Lightning {
  // starting point for lightning bolt
  int startX = 0;
  int startY = 150;
  int endX = 0;
  int endY = 150;
  
  Lightning() {
  }
  
  // Draw lightning bolts
  void display() {
    // set random color of lightning
    color randColor = color((int) (Math.random()*10) + 246, 255, (int) (Math.random()*256));
    stroke(randColor);
    // change endX by random distance to the right
    endX += (int) (Math.random()*10);
    // change endy by random vertical distance
    endY += (int) (Math.random()*19) - 9;
    // draw line
    line(startX, startY, endX, endY);
    // set startX & startY to end of previous line
    startX = endX;
    startY = endY;
  }
}

