/* Snowflake Catcher
 * Author: Brian Tom
 * Date: 9/14/2015
 * Description: Simulates the movement of bacteria using random walks.
 */

Snowflake[] arr = new Snowflake[100];

void setup() {
  size(1280, 720);
  background(0);
  for (int i = 0; i < arr.length; i++) {
    arr[i] = new Snowflake();
  }
}
void draw() {
  for (int i = 0; i < arr.length; i++) {
    arr[i].erase();
    arr[i].lookDown();
    arr[i].move();
    arr[i].wrap();
    arr[i].show();
  }
}
void mouseDragged() {
  //your code here
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
  // Draws snowflake
  void show() {
    noStroke();
    fill(255);
    ellipse(x, y, mySize, mySize);
  }
  // Checks if snowflase is on screen and color below it is black
  void lookDown() {
    if ((y >= 0 && y <= height) && get(x, y+1) != color(0)) isMoving = false;
    isMoving = true;
  }
  // Erases snowflake by drawing black ellipse over it
  void erase() {
    fill(0);
    ellipse(x, y, mySize+1, mySize+1);
  }
  // Move the snowflake downwards
  void move() {
    if (isMoving) y++;
  }
  // Redraws snowflake at top of screen with random x position
  void wrap() {
    if (y > height) {
      y = 0;
      x = (int) (Math.random()*width);
    }
  }
}

