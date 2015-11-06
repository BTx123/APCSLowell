/* Asteroids Game
 * Author: Brian Tom
 * Date: 10/27/15
 * Description: Replica of the classic Asteroids game
 */

// TODO Engine fire

int bgColor = color(0);

// Declarations
Floater s;
Star[] stars;

// Initialize stars and spaceship
public void setup() {
  size(1280, 720);
  smooth();
  stars = new Star[100];
  for (int i = 0; i < stars.length; i++) stars[i] = new Star();
  s = new SpaceShip();
}
// Display the game
public void draw() {
  screenFade();
  for (int i = 0; i < stars.length; i++) stars[i].display();
  keyActions();
  s.move();
  s.show();
}
// Fade the screen slightly to create motion blur
public void screenFade() {
  noStroke();
  fill(bgColor, 150);
  rect(0, 0, width, height);
}
// Draw monochromatic stars
class Star {
  private float myX, myY, myR;
  private int myColor;
  public Star() {
    myX = (float) Math.random()*width;
    myY = (float) Math.random()*height;
    myR = (float) Math.random()*31 + 5;
    myColor = color((int) (Math.random()*256));
  }
  public void display() {
    noStroke();
    fill(myColor);
    ellipse(myX, myY, myR, myR);
  }
}
// Detect Spaceship controls
boolean wPressed = false;
boolean sPressed = false;
boolean aPressed = false;
boolean dPressed = false;
boolean fPressed = false;
boolean hyperActive = false;
boolean ctrlPressed = false;
public void keyPressed() {
  // detect ship navigation presses
  if (key == 'w' || key == 'W') wPressed = true;
  if (key == 's' || key == 'A') sPressed = true;
  if (key == 'a' || key == 'S') aPressed = true;
  if (key == 'd' || key == 'D') dPressed = true;
  // hyperspace initiated
  if ((key == 'f' || key == 'F') && !hyperActive) {
    hyperActive = true;
    hyperspace();
  }
  // detect ship "brakes" presses
  if (keyCode == CONTROL) ctrlPressed = true;
}
// Hyperspace to new position facing random direction
public void hyperspace() {
  s.setX((int) (Math.random()*width));
  s.setY((int) (Math.random()*height));
  s.setPointDirection((int) (Math.random()*360));
  s.setDirectionX(0);
  s.setDirectionY(0);
}
// Respond to key presses
public void keyActions() {
  double accelerationF = 0.2;
  int rotationF = 5;  // rotation in degrees
  // ship navigation
  if (wPressed) s.accelerate(accelerationF);
  if (sPressed) s.accelerate(-accelerationF);
  if (aPressed) s.rotate(-rotationF);
  if (dPressed) s.rotate(rotationF);
  // ship "brakes" for slowing down
  if (ctrlPressed) {
    double reducF = 0.05;
    if ((Math.abs(s.getDirectionX()) <= 0.5)) s.setDirectionX(0);
    if ((Math.abs(s.getDirectionY()) <= 0.5)) s.setDirectionY(0);
    if (s.getDirectionX() > 0) s.setDirectionX(s.myDirectionX - reducF);
    else if (s.getDirectionX() < 0) s.setDirectionX(s.myDirectionX + reducF);
    if (s.getDirectionY() > 0) s.setDirectionY(s.myDirectionY - reducF);
    else if (s.getDirectionY() < 0) s.setDirectionY(s.myDirectionY + reducF);
  }
}
// For multiple key presses
public void keyReleased() {
  // detect ship navigation releases
  if (key == 'w' || key == 'W') wPressed = false;
  if (key == 's' || key == 'A') sPressed = false;
  if (key == 'a' || key == 'S') aPressed = false;
  if (key == 'd' || key == 'D') dPressed = false;
  if (key == 'f' || key == 'F') {
    hyperActive = false;
  }
  // detect ship "brakes" releases
  if (keyCode == CONTROL) ctrlPressed = false;
}
// Draws the spaceship
class SpaceShip extends Floater {
  private int[] myXs, myYs;
  private final double MAX_SPEED;
  SpaceShip() {
    corners = 26;
    myXs = new int[] { 
      18, 16, 12, 8, 4, 4, -2, -10, -16, -18, -18, -16, -14, 
      -14, -16, -18, -18, -16, -10, -2, 4, 4, 8, 12, 16, 18
    };
    myYs = new int[] { 
      2, 6, 10, 10, 6, 4, 4, 10, 10, 8, 6, 4, 4, 
      -4, -4, -6, -8, -10, -10, -4, -4, -6, -10, -10, -6, -2
    };
    xCorners = myXs;
    yCorners = myYs;
    myColor = color(255, 94, 0);
    myCenterX = width/2;
    myCenterY = height/2;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
    MAX_SPEED = 10;
  }
  public void setX(int tempX) { 
    myCenterX = tempX;
  }
  public int getX() { 
    return (int) myCenterX;
  }
  public void setY(int tempY) { 
    myCenterY = tempY;
  }
  public int getY() { 
    return (int) myCenterY;
  }
  public void setDirectionX(double tempX) { 
    myDirectionX = tempX;
  }
  public double getDirectionX() { 
    return myDirectionX;
  }
  public void setDirectionY(double tempY) { 
    myDirectionY = tempY;
  }
  public double getDirectionY() { 
    return myDirectionY;
  }
  public void setPointDirection(int tempDegrees) { 
    myPointDirection = tempDegrees;
  }
  public double getPointDirection() { 
    return myPointDirection;
  }
  // Accelerates the floater in the direction it is pointing (myPointDirection)
  public void accelerate(double dAmount) {
    // convert the current direction the floater is pointing to radians
    double dRadians = myPointDirection * (Math.PI/180);
    // change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
    //enginePropulsion();
  }
  // TODO Draw engine flames
  private void enginePropulsion() {
    int[] flameColors = { 
      color(226, 88, 34), 
      color(255, 153, 0), 
      color(255, 165, 0), 
      color(255, 88, 0), 
      color(255, 209, 220)
    };
    strokeWeight(10);
    stroke(flameColors[(int) (Math.random()*flameColors.length)]);
    point((float) (s.getX()-s.getDirectionX()), (float) (s.getY()-s.getDirectionY()));
    // fill(color(flameColors[(int) (Math.random()*flameColors.length)]));
    // ellipse((float) (myDirectionX-myCenterX), (float) (myDirectionY-myCenterY), 100, 100);
  }
  public void hyperspace() {
    myCenterX = (int) (Math.random()*width);
    myCenterX = (int) (Math.random()*height);
    myPointDirection = (int) (Math.random()*360);
    myDirectionX = 0;
    myDirectionY = 0;
  }
  // Draw the spaceship at the current position (myCenterX, myCenterY)
  public void show() {
    noStroke();
    fill(myColor);
    //convert degrees to radians for sin and cos
    double dRadians = myPointDirection*(Math.PI/180);
    int xRotatedTranslated, yRotatedTranslated;
    beginShape();
    for (int nI = 0; nI < corners; nI++) {
      // rotate and translate the coordinates of the floater using current direction
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
      vertex(xRotatedTranslated, yRotatedTranslated);
    }
    endShape(CLOSE);
  }
}
// Abstract Floater class 
abstract class Floater {  // Do NOT modify the Floater class! Make changes in the SpaceShip class
  protected int corners;  // the number of corners, a triangular floater has 3
  protected int[] xCorners;
  protected int[] yCorners;
  protected int myColor;
  protected double myCenterX, myCenterY;       // holds center coordinates
  protected double myDirectionX, myDirectionY; // holds x and y coordinates of the vector for direction of travel
  protected double myPointDirection;           // holds current direction the ship is pointing in degrees
  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();
  // Accelerates the floater in the direction it is pointing (myPointDirection)
  public void accelerate(double dAmount) {
    // convert the current direction the floater is pointing to radians
    double dRadians = myPointDirection * (Math.PI/180);
    // change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }
  // Rotates the floater by a given number of degrees
  public void rotate(int nDegreesOfRotation) {     
    myPointDirection += nDegreesOfRotation;
  }
  // Move the floater in the current direction of travel
  public void move() {  
    // change the x and y coordinates by myDirectionX and myDirectionY
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
    // wrap around screen
    if (myCenterX > width) myCenterX = 0;
    else if (myCenterX < 0) myCenterX = width;
    if (myCenterY > height) myCenterY = 0;
    else if (myCenterY < 0) myCenterY = height;
  }
  // Draws the floater at the current position
  public void show() {
    fill(myColor);
    stroke(myColor);
    //convert degrees to radians for sin and cos
    double dRadians = myPointDirection*(Math.PI/180);
    int xRotatedTranslated, yRotatedTranslated;
    beginShape();
    for (int nI = 0; nI < corners; nI++) {
      // rotate and translate the coordinates of the floater using current direction
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);
      vertex(xRotatedTranslated, yRotatedTranslated);
    }
    endShape(CLOSE);
  }
}

