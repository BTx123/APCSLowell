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
  background(0);
  colony = new Bacteria[10];  // Make colony of 10 Bacteria
  for (int i = 0; i < colony.length; i++) {  // instantiate each bacteria 
    int randColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    colony[i] = new Bacteria(20, randColor);  // random color
  }
}

void draw() {
  fill(bgColor, 25);
  rectMode(LEFT);
  rect(0, 0, width, height);
  for (int i = 0; i < colony.length; i++) {
    if (!foodPresent)  // create new food if there is no food present
        food = new BacteriaFood();
    food.display();  // display food if not food present
    colony[i].update();
    colony[i].display();
    colony[i].eat();
  }
}

// Simulate bacteria
class Bacteria {
  int size, myColor, lifespan;
  float velocity;
  PVector location, vx, vy;
  // Constructor
  Bacteria(int tempSize, int tempColor) {
    location = new PVector((int) (Math.random()*width), (int) (Math.random()*height));
    size = tempSize;
    myColor = tempColor;
    lifespan = 255;
    velocity = (float) Math.random()*6;
    vx = new PVector(velocity, 0);
    vy = new PVector(0, velocity);
  }
  // Update locations of bacteria depending on food location
  void update() {
    velocity = (float) Math.random() * (4-(size-10)/10);  // reduce velocity based on size
    vx.x = velocity;
    vy.y = velocity;
    float rFood = (float) Math.random();
    float probToFood = 0.1;  // chance for bacteria to move towards food
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
    lifespan -= 2;  // reduce lifespan
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
      size += food.foodSize;  // bacteria grows bigger
      lifespan += food.foodSize;  // increase lifespan
    }
  }
  boolean isDead() {
    return true;
  }
}

// Food for bacteria to eat
class BacteriaFood {
  PVector location;
  int foodColor, foodSize;
  // Constructor
  BacteriaFood() {
    location = new PVector((float) Math.random()*width, (float) Math.random()*height);
    foodColor = color(220, 240, 250);
    foodSize = 10;
  }
  void display() {
    foodPresent = true;
    noStroke();
    fill(foodColor);
    rectMode(CENTER);
    rect(location.x, location.y, foodSize, foodSize);
  }
}

