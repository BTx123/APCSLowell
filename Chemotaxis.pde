/* Chemotaxis
 * Author: Brian Tom
 * Date: 9/14/2015
 * Description: Simulates the movement of bacteria using random walks.
 */

color bgColor = color(0, 0, 0);

int foodX, foodY, foodCount;

Bacteria[] colony;
BacteriaFood food;

void setup()
{     
  size(1280, 720);
  colony = new Bacteria[10];
  for (int i = 0; i < colony.length; i++)
  {
    color randColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    colony[i] = new Bacteria(20, randColor);
  }
  food = new BacteriaFood();
  foodCount = 0;
}

void draw()
{
  background(bgColor);
  for (int i = 0; i < colony.length; i++)
  {
    colony[i].update();
    colony[i].feed();
    colony[i].display();
    colony[i].eat();
  }
}  

class Bacteria
{
  int x, y, size;
  color myColor;
  // Constructor
  Bacteria(int tempSize, color tempColor)
  {
    x = (int) (Math.random()*width);
    y = (int) (Math.random()*height);
    size = tempSize;
    myColor = tempColor;
  }
  // Update locations of bacteria depending on food location
  void update()
  {
    float prob = 0.0;
    if (x < food.x)
      x += 1;
    if (x > food.x)
      x -= 1;
    if (y < food.y)
      y += 1;
    if (y > food.y)
      y -= 1;
  }
  // Display bacteria on canvas
  void display()
  {
    noStroke();
    fill(myColor);
    ellipse(x, y, size, size);
  }
  // Feed bacteria if no food is present
  void feed()
  {
    food.display();
    if (foodCount < 1)
    {
      food = new BacteriaFood();
      foodCount++;
    }
  }
  // Remove food when bacteria is on same location
  void eat()
  {
    if (x == food.x && y == food.y)
      foodCount--;  // remove food
  }
}

class BacteriaFood
{
  int x, y;
  // Constructor
  BacteriaFood()
  {
    x = (int) (Math.random()*width);
    y = (int) (Math.random()*height);
  }
  void display()
  {
    int foodSize = 10;
    color foodColor = color(220, 240, 250);
    noStroke();
    fill(foodColor);
    rectMode(CENTER);
    rect(x, y, foodSize, foodSize);
  }
}

