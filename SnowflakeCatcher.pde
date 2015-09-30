/* Snowflake Catcher
 * Author: Brian Tom
 * Date: 9/14/2015
 * Description: Simulates snowflakes with a snowflake catcher.
 */

Snowflake[] arr = new Snowflake[200];

void setup() {
  size(1280, 720);
  smooth();
  background(0);
  for (int i = 0; i < arr.length; i++) {
    arr[i] = new Snowflake();
  }
}
void draw() {
  for (int i = 0; i < arr.length; i++) {
    arr[i].lookDown();
    arr[i].erase();
    arr[i].update();
    arr[i].wrap();
    arr[i].display();
  }
}
void mouseDragged() {
  int mySize;
  if (mouseButton == LEFT) {
    mySize = 50;
    noStroke();
    fill(0, 255, 0);
    ellipse(mouseX, mouseY, mySize, mySize);
  }
  if (mouseButton == RIGHT) {
    mySize = 60;
    noStroke();
    fill(0);
    ellipse(mouseX, mouseY, mySize, mySize);
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
    mySize = 10;
  }
  // Erases snowflake by drawing black ellipse over it
  // TODO: Fix snowflake trails
  void erase() {
    noStroke();
    fill(0);
    ellipse(x, y, mySize, mySize);
  }
  // Checks if snowflake is on screen and color below it is black'
  void lookDown() {
    if ((y >= mySize/2 && y <= height-mySize/2-1) && get(x, y+mySize/2) != color(0)) isMoving = false;
    else isMoving = true;
  }
  // Move the snowflake downwards
  void update() {
    if (isMoving) y++;
  }
  // Redraws snowflake at top of screen with random x position
  void wrap() {
    if (y > height+mySize/2) {
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

