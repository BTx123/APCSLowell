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
  frameRate(200);
}

void draw() {
  l.display();
  l.reset();
}

class LightningBolt {
  // starting point for lightning bolt
  int startX, startY, endX, endY;

  LightningBolt() {  // initialize variables
    startX = mouseX;
    startY = 0;
    endX = mouseX;
    endY = 0;
  }
  
  int randNum(int range, int offset) {
    return (int) (Math.random()*range) + offset;
  }
  
  // Draw clouds
  void cloud() {
    noStroke();
    fill(212, 212, 210);
    int randX = (int) (Math.random()*width);
    int randY = (int) (Math.random()*50);
    int randWidth = (int) (Math.random()*100) + 50;
    int randHeight = (int) (Math.random()*50) + 25;
    ellipse(randX, randY, 100, 100);
  }
  
  // Draw lightning bolts
  void display() {
    endX += (int) (Math.random()*79) - 39;  // change endX by random horizontal distance
    endY += (int) (Math.random()*30) - 5;  // change endy by random vertical distance
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
    //    if (endY >= height) {
    //      startX = mouseX;
    //      startY = 0;
    //      endX = mouseX;
    //      endY = 0;
    //    }
  }

  void reset() {
    if (mousePressed && mouseButton == LEFT) {
      // reset background, deleting previous lightning bolt(s)
      background(bgColor);
      // TODO: stop clouds from contimuously spawning while mouse is pressed
      cloud();
      // reset start and endpoint
      startX = mouseX;
      startY = 0;
      endX = mouseX;
      endY = 0;
    }
  }
}

