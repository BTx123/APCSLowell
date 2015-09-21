/* Chemotaxis
 * Author: Brian Tom
 * Date: 9/14/2015
 * Description: Simulates the movement of bacteria using random walks.
 */

int bgColor = color(0, 0, 0);  // background color

int foodX, foodY;              // position of food
boolean foodPresent = false;   // food is not on canvas

Bacteria[] colony;
BacteriaFood food;

void setup() {     
  size(1280, 720);
  colony = new Bacteria[10];  // Make colony of 10 Bacteria
  for (int i = 0; i < colony.length; i++) {  // instantiate each bacteria 
    int randColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    colony[i] = new Bacteria(20, randColor);  // random color
  }
}
void draw() {
  background(bgColor);
  if (!foodPresent)  // create new food if there is no food present
      food = new BacteriaFood();
  food.display();  // display food if not food present
  for (int i = 0; i < colony.length; i++) {
    colony[i].update();
    colony[i].display();
    colony[i].eat();
  }
}
// Simulate bacteria
class Bacteria {
  PVector location, vx, vy;
  int velocity, size, myColor;
  // Constructor
  Bacteria(int tempSize, int tempColor) {
    location = new PVector((int) (Math.random()*width), (int) (Math.random()*height));
    velocity = 1;
    vx = new PVector(velocity, 0);
    vy = new PVector(0, velocity);
    size = tempSize;
    myColor = tempColor;
  }
  // Update locations of bacteria depending on food location
  void update() {
    float rFood = (float) Math.random();
    float probToFood = 0.25;  // chance for bacteria to move towards food
    if (rFood < probToFood) {
      // move toawrds food
      if (location.x < food.location.x)
        location.add(vx);
      if (location.x > food.location.x)
        location.sub(vx);
      if (location.y < food.location.y)
        location.add(vy);
      if (location.y > food.location.y)
        location.sub(vy);
    } else {
      // move in random direction
      float rRandom = (float) Math.random();
      if (rRandom < 0.25)
        location.add(vx);
      else if (rRandom < 0.5)
        location.sub(vx);
      else if (rRandom < 0.75)
        location.add(vy);
      else
        location.sub(vy);
    }
  }
  // Display bacteria on canvas
  void display() {
    noStroke();
    fill(myColor);
    ellipse(location.x, location.y, size, size);
  }
  // Remove food when bacteria is on same location
  void eat() {
    // if (location.x >= food.location.x-1 && location.x <= food.location.x+1 && location.y >= food.location.y-1 && location.y <= food.location.y+1)
    if (get((int) food.location.x, (int) food.location.y) != color(food.foodColor)) {
      foodPresent = false;
      size += 20;  // bacteria grows bigger
    }
  }
}
// Food for bacteria to eat
class BacteriaFood {
  PVector location;
  int foodColor;
  // Constructor
  BacteriaFood() {
    location = new PVector((float) Math.random()*width, (float) Math.random()*height);
    foodColor = color(220, 240, 250);
  }
  void display() {
    foodPresent = true;
    int foodSize = 10;
    noStroke();
    fill(foodColor);
    rectMode(CENTER);
    rect(location.x, location.y, foodSize, foodSize);
  }
}

