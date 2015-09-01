/* Lightning
 * Author: Brian Tom
 * Date: 8/31/2015
 * Description: Draws lightning bolts
 */

// Background color
color bgColor = color(30, 60, 127);

LightningBolt l = new LightningBolt();

void setup() {
  size(1280, 720);
  background(bgColor);
  frameRate(150);
}

void draw() {
  l.display();
  l.reset();
}



class LightningBolt {
  // starting point for lightning bolt
  int startX, startY, endX, endY;

  LightningBolt() {  // initialize variables
    startX = width/2;
    startY = 0;
    endX = width/2;
    endY = 0;
  }

  // Draw lightning bolts
  void display() {
    endX += (int) (Math.random()*49) - 24;  // change endX by random horizontal distance
    endY += (int) (Math.random()*30);  // change endy by random vertical distance
    // TODO: lightning flash
    strokeWeight(7);
    stroke(255, 255, 255, 75);
    line(startX, startY, endX, endY);
    // draw lightning line
    strokeWeight(3);
    color randColor = color((int) (Math.random()*10) + 246, 255, (int) (Math.random()*256));  // set random color of lightning
    stroke(randColor);
    line(startX, startY, endX, endY);
    // set startX & startY to end of previous line
    startX = endX;
    startY = endY;
    // reset start and endpoint when lightning reaches bottom of screen, leaving previous bolt
    if (endY >= height) {
      startX = width/2;
      startY = 0;
      endX = width/2;
      endY = 0;
    }
  }

  void reset() {
    if (mousePressed && mouseButton == LEFT) {
      // reset background, deleting previous lightning bolt(s)
      background(bgColor);
      // reset start and endpoint
      startX = width/2;
      startY = 0;
      endX = width/2;
      endY = 0;
    }
  }
}

