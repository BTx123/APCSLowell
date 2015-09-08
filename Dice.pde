/* Dice
 * Author: Brian T
 * Date: 9/8/2015
 * Description: Simulates the rolling of dice.
 */

Die d;

void setup()
{
  size(648, 648);
  noLoop();
  d = new Die(width/2, height/2);
}

void draw()
{
  background(127);
  d.roll();
  d.show();
}

void mousePressed()
{
  redraw();
}

// Models one single dice cube
class Die
{
  int x, y, value;

  Die(int tempX, int tempY) //constructor
  {
    x = tempX;
    y = tempY;
    value = 1;
  }

  void roll()
  {
    value = (int) (Math.random()*6) + 1;
    println(value);
  }

  void singleDot(int x, int y) {
    noStroke();
    fill(0);
    ellipseMode(CENTER);
    int d = 20;
    ellipse(x, y, d, d);
  }

  void show()
  {
    rectMode(CENTER);
    int d = 100;
    rect(x, y, d, d, d/10);
    if (value == 1 || value == 3 || value == 5) {
      singleDot(x, y);
      if (value == 3) {
        // draw dots on upper left & bottom right
        singleDot(x, y);
      }
      if (value == 5) {
        // draw dots on upper right & bottom left
        singleDot(x, y);
      }
    } else if (value == 2 || value == 4) {
      // draw dots on upper left & bottom right
      singleDot(x, y);
      if (value == 4) {
        // draw dots upper right & bottom left
        singleDot(x, y);
      }
    } else if (value == 6) {
      // draw 3 dots on left & 3 dots on right
      singleDot(x, y);
    } else {
      println("ERROR: Out of bounds");
    }
  }
}

