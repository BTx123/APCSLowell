/* Dice
 * Author: Brian T
 * Date: 9/8/2015
 * Description: Simulates the rolling of dice.
 */

Die d;

void setup() {
  size(648, 648);
  noLoop();
}

void draw() {
  background(127);
  println("BG");
  for (int i = 0; i < 3; i++) {
    d = new Die(width/2, i*height);
    d.roll();
    d.show();
  }
}

void mousePressed() {
  redraw();
}

// Models one single dice cube
class Die {
  float x, y, value;

  Die(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    value = 1;
  }

  void roll() {
    value = (int) (Math.random()*6) + 1;
    println(value);
  }

  void singleDot(float x, float y) {
    noStroke();
    fill(0);
    ellipseMode(CENTER);
    int size = 20;
    ellipse(x, y, size, size);
  }

  void show() {
    rectMode(CENTER);
    noStroke();
    fill(255);
    int size = 100;
    rect(x, y, size, size, size/10);
    if (value == 1 || value == 3 || value == 5) {
      singleDot(x, y);  // CENTER
      if (value == 3 || value == 5) {
        // draw dots on upper left & bottom right
        singleDot(x - 0.25*size, y - 0.25*size);  // TL
        singleDot(x + 0.25*size, y + 0.25*size);  // BR
      }
      if (value == 5) {
        // draw dots on upper right & bottom left
        singleDot(x + 0.25*size, y - 0.25*size);  // TR
        singleDot(x - 0.25*size, y + 0.25*size);  // BL
      }
    } else if (value == 2 || value == 4) {
      // draw dots on upper left & bottom right
      singleDot(x - 0.25*size, y - 0.25*size);  // TL
      singleDot(x + 0.25*size, y + 0.25*size);  // BR
      if (value == 4) {
        // draw dots upper right & bottom left
        singleDot(x + 0.25*size, y - 0.25*size);  // TR
        singleDot(x - 0.25*size, y + 0.25*size);  // BL
      }
    } else if (value == 6) {
      // draw 3 dots on left & 3 dots on right
      singleDot(x - 0.25*size, y - 0.25*size);  // TL
      singleDot(x - 0.25*size, y);  // CL
      singleDot(x - 0.25*size, y + 0.25*size);  // BL
      singleDot(x + 0.25*size, y - 0.25*size);  // TR
      singleDot(x + 0.25*size, y);  // CR
      singleDot(x + 0.25*size, y + 0.25*size);  // BR
    } else {
      println("ERROR: Out of bounds");
    }
  }
}

