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
  rectMode(LEFT);
  fill(bgColor, 50);
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
    lifespan = 5*size;
    velocity = (float) Math.random()*6;
    vx = new PVector(velocity, 0);
    vy = new PVector(0, velocity);
  }
  // Update locations of bacteria depending on food location
  void update() {
    if (size >= 250)
      velocity = 1;
    else if (size >= 200)
      velocity = (float) Math.random()*2 + 1;
    else if (size >= 150)
      velocity = (float) Math.random()*3 + 1;
    else if (size >= 100)
      velocity = (float) Math.random()*4 + 1;
    else if (size >= 50)
      velocity = (float) Math.random()*5 + 1;
    else
      velocity = (float) Math.random()*6 + 1;
    vx.x = velocity;
    vy.y = velocity;
    float r = (float) Math.random();
    float probToMouse = 0.3;
    float probToFood = (float) 10/dist(location.x, location.y, food.location.x, food.location.y);  // chance for bacteria to move towards food is higher if closer
    if (mousePressed && r < probToMouse) {
      // move towards mouse
      if (location.x < mouseX)
        location.add(vx);
      if (location.x > mouseX)
        location.sub(vx);
      if (location.y < mouseY)
        location.add(vy);
      if (location.y > mouseY)
        location.sub(vy);
    } else if (r < probToFood) {
      // move towards food
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
    location.x = constrain(location.x, 0, width-1);  // keep bacteria on screen
    location.y = constrain(location.y, 0, height-1);
    lifespan -= 1;  // reduce lifespan
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
      lifespan += 10*food.foodSize;  // increase lifespan
    }
  }
  boolean isDead() {
    if (lifespan <= 0)
      return true;
    return false;
  }
  float monteCarlo() {
    while (true) {
      float r1 = (float) Math.random();
      float probability = r1*r1;
      float r2 = (float) Math.random();
      if (r2 < probability)
        return r1;
    }
  }
}

// Food for bacteria to eat
class BacteriaFood {
  PVector location;
  int foodColor, foodSize;
  // Constructor
  BacteriaFood() {
    location = new PVector((float) Math.random()*width, (float) Math.random()*height);
    foodColor = color(255, 255, 200);
    foodSize = (int) (Math.random()*11) + 5;
  }
  void display() {
    foodPresent = true;
    noStroke();
    fill(foodColor);
    rectMode(CENTER);
    rect(location.x, location.y, foodSize, foodSize);
  }
}

