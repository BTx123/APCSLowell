/* Lightning
 * Author: Brian Tom
 * Date: 8/31/2015
 * Description: Draws lightning bolts
 */

// Background color
color bgColor = color(0, 0, 50);

void setup() {
  size(1280, 720);
  background(bgColor);
  frameRate(30);
  clouds();
  noLoop();
}

void draw() {
  LightningBolt l = new LightningBolt();
  l.display();
  l.userClick();
}

int randNum(int range, int offset) {
  return (int) (Math.random()*range) + offset;
}

class LightningBolt {
  // starting point for lightning bolt
  int startX, startY, endX, endY;

  LightningBolt() {  // constructor initializes variables
    startX = mouseX;
    startY = 0;
    endX = mouseX;
    endY = 0;
  }

  // Draw lightning bolts
  void display() {
    // TODO: lightning flash
    int opacity = 255;
    // draw lightning until reaches bottom of screen
    while (endY < height) {
      noStroke();
      fill(255, 255, 255, opacity);
      rect(0, 0, width, height);
      endX += randNum(151, -75);  // change endX by random horizontal distance
      endY += randNum(61, -10);   // change endy by random vertical distance
      // Draw lightning flash behind lightning line
      strokeWeight(8);
      stroke(255, 255, 255, 75);
      line(startX, startY, endX, endY);
      // Draw lightning line
      strokeWeight(3);
      color randColor = color((int) (Math.random()*10) + 246, 255, (int) (Math.random()*256));  // set random color of lightning
      stroke(randColor);
      line(startX, startY, endX, endY);
      // set startX & startY to end of previous line
      opacity--;
      startX = endX;
      startY = endY;
    }
  }

  void userClick() {
    if (mousePressed && mouseButton == RIGHT) {
      // reset background, deleting previous lightning bolt(s)
      background(bgColor);
      clouds();
      // reset start and endpoint
      startX = mouseX;
      startY = 0;
      endX = mouseX;
      endY = 0;
    }
  }
}

// Draw clouds
void clouds() {
  noStroke();
  fill(212, 212, 210);
  int randX, randY, randWidth, randHeight;
  randWidth = 0;
  for (int i = 0; i < width; i += randWidth/3) {
    randX = randNum(width, 0);
    randY = randNum(50, 0);
    randWidth = randNum(100, 50);
    randHeight = randNum(50, 25);
    ellipse(randX, randY, randWidth, randHeight);
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    redraw();
  }
}

