/* Snowflake Catcher
 * Author: Brian Tom
 * Date: 9/14/2015
 * Description: Simulates snowflakes with a snowflake catcher.
 */

Snowflake[] arr = new Snowflake[100];
int bgColor = color(0);

void setup() {
  size(300, 300);
  smooth();
  background(bgColor);
  for (int i = 0; i < arr.length; i++) {
    arr[i] = new Snowflake();
  }
}
void draw() {
  for (int i = 0; i < arr.length; i++) {
    arr[i].erase();
    arr[i].lookDown();
    arr[i].update();
    arr[i].wrap();
    arr[i].display();
  }
}
void mouseDragged() {
  int mySize;
  if (mouseButton == LEFT) {
    mySize = 5;
    strokeWeight(mySize);
    stroke(0, 255, 0);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
  if (mouseButton == RIGHT) {
    mySize = 30;
    strokeWeight(mySize);
    stroke(bgColor);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}

class Snowflake {
  //class member variable declarations
  int x, y, mySize;
  boolean isMoving;
  Snowflake() {
    //class member variable initializations
    x = (int) (Math.random()*width);
    y = (int) (Math.random()*height);
    isMoving = true;
    mySize = 6;
  }
  // Erases snowflake by drawing black ellipse over it
  // TODO: Fix snowflake trails
  void erase() {
    noStroke();
    fill(bgColor);
    ellipse(x, y, mySize+2, mySize+2);
  }
  // Checks if snowflake is on screen and color below it is black'
  void lookDown() {
    if ((y > 0 && y < (float) height-5) && get(x, y+4) != color(bgColor)) isMoving = false;
    else isMoving = true;
  }
  // Move the snowflake downwards
  void update() {
    if (isMoving) y++;
  }
  // Redraws snowflake at top of screen with random x position
  void wrap() {
    if (y > height) {
      y = 0;
      x = (int) (Math.random()*width);
    }
  }
  // Draws snowflake
  void display() {
    noStroke();
    fill(255);
    ellipse(x, y, mySize, mySize);
  }
}

