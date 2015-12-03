/* Asteroids Game
 * Author: Brian Tom
 * Date: 10/27/15
 * Description: Replica of the classic Asteroids game
 */

// TODO Engine fire

int bgColor = color(0);

// Declarations
Star[] stars;
Floater ship;
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
// Initialize stars and spaceship
public void setup() {
  size(1280, 720);
  smooth();
  stars = new Star[100];
  for (int i = 0; i < stars.length; i++) stars[i] = new Star();
  ship = new SpaceShip();
  asteroids = new ArrayList<Asteroid>();
  for (int i = 0; i < 10; i++) asteroids.add(new Asteroid());
  bullets = new ArrayList<Bullet>();
}
// Display the game
public void draw() {
  screenFade();
  for (int i = 0; i < stars.length; i++) stars[i].display();
  keyActions();
  destroyAsteroids();
  for (Asteroid a : asteroids) {
    a.move();
    a.show();
  }
  for (Bullet b : bullets) {
    b.move();
    b.show();
  }
  ship.move();
  ship.show();
}
// Fade the screen slightly to create motion blur
public void screenFade() {
  noStroke();
  fill(bgColor, 125);
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
boolean weaponFiring = false;
boolean hyperspaceActive = false;
boolean ctrlPressed = false;
public void keyPressed() {
  // detect ship navigation presses
  if (key == 'w' || key == 'W') wPressed = true;
  if (key == 's' || key == 'A') sPressed = true;
  if (key == 'a' || key == 'S') aPressed = true;
  if (key == 'd' || key == 'D') dPressed = true;
  // fire weapon, spawning new bullet
  if (key == ' ' && !weaponFiring) {
    weaponFiring = true;
    bullets.add(new Bullet((SpaceShip) ship));
  }
  // hyperspace initiated
  if ((key == 'f' || key == 'F') && !hyperspaceActive) {
    hyperspaceActive = true;
    hyperspace();
  }
  // detect ship "brakes" presses
  if (keyCode == CONTROL) ctrlPressed = true;
}
// Hyperspace to new position facing random direction
public void hyperspace() {
  ship.setX((int) (Math.random()*width));
  ship.setY((int) (Math.random()*height));
  ship.setPointDirection((int) (Math.random()*360));
  ship.setDirectionX(0);
  ship.setDirectionY(0);
}
// Respond to key presses
public void keyActions() {
  double accelerationF = 0.2;
  int rotationF = 5;  // rotation in degrees
  // ship navigation
  if (wPressed) ship.accelerate(accelerationF);
  if (sPressed) ship.accelerate(-accelerationF);
  if (aPressed) ship.rotate(-rotationF);
  if (dPressed) ship.rotate(rotationF);
  // ship "brakes" for slowing down
  if (ctrlPressed) {
    double reducF = 0.05;
    if ((Math.abs(ship.getDirectionX()) <= 0.5)) ship.setDirectionX(0);
    if ((Math.abs(ship.getDirectionY()) <= 0.5)) ship.setDirectionY(0);
    if (ship.getDirectionX() > 0) ship.setDirectionX(ship.myDirectionX - reducF);
    else if (ship.getDirectionX() < 0) ship.setDirectionX(ship.myDirectionX + reducF);
    if (ship.getDirectionY() > 0) ship.setDirectionY(ship.myDirectionY - reducF);
    else if (ship.getDirectionY() < 0) ship.setDirectionY(ship.myDirectionY + reducF);
  }
}
// For multiple key presses
public void keyReleased() {
  // detect ship navigation releases
  if (key == 'w' || key == 'W') wPressed = false;
  if (key == 's' || key == 'A') sPressed = false;
  if (key == 'a' || key == 'S') aPressed = false;
  if (key == 'd' || key == 'D') dPressed = false;
  // detect weapon fire release
  if (key == ' ') weaponFiring = false;
  // detect hyperspace release
  if (key == 'f' || key == 'F') hyperspaceActive = false;
  // detect ship "brakes" release
  if (keyCode == CONTROL) ctrlPressed = false;
}
// Destroy asteroids
public void destroyAsteroids() {
  for (int i = 0; i < asteroids.size (); i++) {
    if (asteroids.get(i).distToShip((SpaceShip) ship) < 50) {
      asteroids.remove(i);
    }
  }
}
// Draws the spaceship
class SpaceShip extends Floater {
  private int[] myXs, myYs;
  SpaceShip() {
    corners = 17;
    myXs = new int[] {
      25, 0, -5, 0, -10, -10, -25, -20, -10, 
      -20, -25, -10, -10, 0, -5, 0, 25
    };
    myYs = new int[] { 
      0, -10, -5, -20, -15, -10, -15, -5, 0, 
      5, 15, 10, 15, 20, 5, 10, 0
    };
    xCorners = myXs;
    yCorners = myYs;
    myColor = color(255, 94, 0);
    myCenterX = width/2;
    myCenterY = height/2;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
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
    point((float) (ship.getX()-ship.getDirectionX()), (float) (ship.getY()-ship.getDirectionY()));
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
class Asteroid extends Floater {
  private int rotateSpeed;
  public Asteroid() {
    corners = 10;
    xCorners = randomCorners('x', corners);
    yCorners = randomCorners('y', corners);
    rotateSpeed = (int) (Math.random()*11) - 5;
    int grey = (int) (Math.random()*51) + 102;
    myColor = color(grey, grey, grey, grey);
    myCenterX = Math.random()*width;
    myCenterY = Math.random()*height;
    myDirectionX = Math.random()*6 - 3;
    myDirectionY = Math.random()*6 - 3;
    myPointDirection = 0;
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
  public void move() {
    rotate(rotateSpeed);  // rotate by individually specified amount
    super.move();         // move according to Floater defined move() method
  }
  // Return distance from this asteroid to SpaceShip s
  public float distToShip(SpaceShip s) {
    return dist(s.getX(), s.getY(), getX(), getY());
  }
  // Create random corners for the asteroid in a circular method
  private int[] randomCorners(char dim, int num) {
    int[] nums = new int[num];
    float theta = 0;
    for (int i = 0; i < nums.length; i++) {
      int radius = (int) (Math.random()*51) + 20;  // mean of 50
      if (dim == 'x') nums[i] = (int) (Math.sin(theta)*radius);
      if (dim == 'y') nums[i] = (int) (Math.cos(theta)*radius);
      theta += TWO_PI/num;
    }
    return nums;
  }
}
class Bullet extends Floater {
  public Bullet (SpaceShip ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myPointDirection = ship.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + ship.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + ship.getDirectionY();
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
  public void move() {  
    // change the x and y coordinates by myDirectionX and myDirectionY
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
  }
  public void show() {
    noStroke();
    fill(255, 255, 0);
    ellipse((float) myCenterX, (float) myCenterY, 10, 10);
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

