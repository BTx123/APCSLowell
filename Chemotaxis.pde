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

void setup()
{     
  size(1280, 720);
  colony = new Bacteria[10];  // Make colony of 10 Bacteria
  for (int i = 0; i < colony.length; i++)  // instantiate each bacteria 
  {
    int randColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    colony[i] = new Bacteria(20, randColor);  // random color
  }
}
void draw()
{
  background(bgColor);
  if (!foodPresent)
    food = new BacteriaFood();
  food.display();
  for (int i = 0; i < colony.length; i++)
  {
    colony[i].update();
    colony[i].display();
    colony[i].eat();
  }
}
// Simulate bacteria
class Bacteria
{
  PVector location, vx, vy;
  int size, myColor;
  // Constructor
  Bacteria(int tempSize, int tempColor)
  {
    location = new PVector((int) (Math.random()*width), (int) (Math.random()*height));
    vx = new PVector(2, 0);
    vy = new PVector(0, 2);
    size = tempSize;
    myColor = tempColor;
  }
  // Update locations of bacteria depending on food location
  void update()
  {
    //    if (!foodPresent)
    //    {
    //      location = location + velocity;
    //    }
    if (location.x < food.location.x)
      location.add(vx);
    if (location.x > food.location.x)
      location.sub(vx);
    if (location.y < food.location.y)
      location.add(vy);
    if (location.y > food.location.y)
      location.sub(vy);
    //float rand = Math.random();  // biased random direction
    //if (rand < 0.4)
    // move closer to food (shortest distance)
    //else if (rand < 0.6)
    // move other direction
    //else if (rand < 0.8)
    // move other direction
    //else
    // move other direction
  }
  // Display bacteria on canvas
  void display()
  {
    noStroke();
    fill(myColor);
    ellipse(location.x, location.y, size, size);
  }
  // Remove food when bacteria is on same location
  void eat()
  {
    // if (location.x >= food.x-1 && location.x <= food.x+1 && location.y >= food.y-1 && location.y <= food.y+1)
    if (get((int) food.location.x, (int) food.location.y) != color(food.foodColor))
    {
      foodPresent = false;
      size += 5;  // bacteria grows bigger
      
    }
  }
  // determine which perpendicular distance to food is shortest
  //int shortestDistance()
  //{
  //  float distX = abs(location.x - food.x);
  //  float distY = abs(location.y - food.y);
  //  if (distX > distY)
  //  {
  //    if (location.x < food.x)
  //      return 1;
  //    return 3;
  //  }
  //  else
  //  {
  //    if (location.y < food.y)
  //      return 2;
  //    return 0;
  //  }
  //}
}
// Food for bacteria to eat
class BacteriaFood
{
  PVector location;
  int foodColor;
  // Constructor
  BacteriaFood()
  {
    location = new PVector((float) Math.random()*width, (float) Math.random()*height);
    foodColor = color(220, 240, 250);
  }
  void display()
  {
    foodPresent = true;
    int foodSize = 10;
    noStroke();
    fill(foodColor);
    rectMode(CENTER);
    rect(location.x, location.y, foodSize, foodSize);
  }
}

