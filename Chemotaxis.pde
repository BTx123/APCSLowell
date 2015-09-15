/* Chemotaxis
 * Author: Brian Tom
 * Date: 9/14/2015
 * Description: Simulates the movement of bacteria using random walks.
 */

color bgColor = color(0, 0, 0);

Bacteria[] colony = new Bacteria[10];

void setup() {     
  size(1280, 720);
  for (int i = 0; i < colony.length; i++) {
    color randColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    colony[i] = new Bacteria(width/2, height/2, 20, randColor);
  }
}   
void draw() {
  background(bgColor);
  for (int i = 0; i < colony.length; i++) {
    colony[i].update();
    colony[i].display();
    colony[i].feed();
  }
}  
class Bacteria {
  int x, y, size;
  color myColor;
  // Constructor
  Bacteria(int tempX, int tempY,int tempSize, color tempColor) {
    x = tempX;
    y = tempY;
    size = tempSize;
    myColor = tempColor;
  }
  void feed() {
    int foodX = (int) (Math.random()*width);
    int foodY = (int) (Math.random()*height);
    int foodSize = 10;
    color foodColor = color(220, 240, 250);
    noStroke();
    fill(foodColor);
    rectMode(CENTER);
    rect(foodX, foodY, foodSize, foodSize);
  }
  void update() {
    int randX = (int) (Math.random()*3) - 1;
    println(randX);
    int randY = (int) (Math.random()*3) - 1;
    x += randX;
    y += randY;
  }
  void display() {
    noStroke();
    fill(myColor);
    ellipse(x, y, size, size);
  }
}    

