/* Dice
 * Author: Brian T
 * Date: 9/8/2015
 * Description: Simulates the rolling of dice.
 */
 
// TODO: shake?

Die d;  // declaration

int rows    = 3;
int columns = 3;
int dieSize = 100;  // sidelength

PFont font;

void setup()
{
  size(648, 700);
  noLoop();
  textFont(loadFont("TrebuchetMS-Bold-48.vlw"));
}

void draw()
{
  int myHeight = width;  // create square space for dice to be drawn in
  int diceSum = 0;       // keeps track of sum of all dice values
  background(127);
  // calculates x & y positions with scaling depending on the number & size of dice
  for (float y = (float) 1/(2*rows)*myHeight; y < myHeight; y += (float) 1/rows*myHeight) {
    for (float x = (float) 1/(2*columns)*width; x < width; x += (float) 1/columns*width) {
      d = new Die(x, y, dieSize);  // instantiation
      d.roll();
      d.display();
      diceSum += d.value;  // add value of current Dice d to diceSum
    }
  }
  // display sum of all dice values, # of rows & columns, # of dice
  fill(150, 25, 25);
  textSize(24);
  text("Total Sum: " + diceSum, (float) width/16, (float) (height + width)/2);
  textSize(16);
  text("Rows: " + rows, (float) 7*width/16, (float) (height + width)/2 - 10);
  text("Columns: " + columns, (float) 7*width/16, (float) (height + width)/2 + 10);
  text("# of Dice: " + rows*columns, (float) 11*width/16, (float) (height + width)/2 - 10);
  text("Size: " + dieSize, (float) 11*width/16, (float) (height + width)/2 + 10);
}

// Randomize dice on click
void mousePressed()
{
  if (mouseButton == LEFT) {
    redraw();
  }
}

// Change number of dice rows, columns, & size
void keyPressed()
{
  // controls number of rows
  if (key == 's')
  {
    rows++;
    redraw();
  }
  else if (key == 'w' && rows > 0)
  {
    rows--;
    redraw();
  }
  // controls number of columns
  if (key == 'a' && columns > 0)
  {
    columns--;
    redraw();
  }
  else if (key == 'd')
  {
    columns++;
    redraw();
  }
  // controls die size
  if (key == 'e')
  {
    dieSize++;
    redraw();
  }
  else if (key == 'q' && dieSize > 0)
  {
    dieSize--;
    redraw();
  }
}

// Models one single dice cube
class Die
{
  float x, y, dieSize, dotSize, value;
  // Constructor
  Die(float tempX, float tempY, int tempDieSize)
  {
    x = tempX;
    y = tempY;
    dieSize = tempDieSize;
    dotSize = 0.2*dieSize;
    value = 1;
  }
  // Gives die a random value from 1-6
  void roll()
  {
    value = (int) (Math.random()*6) + 1;
  }
  // Draw a single dot
  void singleDot(float x, float y)
  {
    noStroke();
    fill(0);
    ellipseMode(CENTER);
    ellipse(x, y, dotSize, dotSize);
  }
  // Draw die with dots depending on random value
  void display()
  {
    rectMode(CENTER);
    strokeWeight(0.03*dieSize);
    stroke(50);
    fill(255);
    rect(x, y, dieSize, dieSize, dieSize/10);
    // draw dot pattern depending on value of die
    if (value == 1 || value == 3 || value == 5)
    {
      // draw single dot in center
      singleDot(x, y);  // CENTER
    }
    if (value == 2 || value == 3 || value == 4 || value == 5 || value == 6)
    {
      // draw dots on upper left & bottom right
      singleDot(x - 0.25*dieSize, y - 0.25*dieSize);  // TL
      singleDot(x + 0.25*dieSize, y + 0.25*dieSize);  // BR
    }
    if (value == 4 || value == 5 || value == 6)
    {
      // draw dots on upper right & bottom left
      singleDot(x + 0.25*dieSize, y - 0.25*dieSize);  // TR
      singleDot(x - 0.25*dieSize, y + 0.25*dieSize);  // BL
    }
    if (value == 6)
    {
      // draw 1 dot on left & 1 dot on center right
      singleDot(x - 0.25*dieSize, y);  // CL
      singleDot(x + 0.25*dieSize, y);  // CR
    }
  }
}

