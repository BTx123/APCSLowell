/* Asteroids Game
 * Author: Brian Tom
 * Date: 10/27/15
 * Description: Replica of the classic Asteroids game
 */

// TODO Create destructible asteroids
// TODO Engine fire

int bgColor = color(0);
int asteroidCount = 10;
int screenNum = 0;

// Declarations ---------------------------------------------------------------
Game game;
Star[] stars;
Floater ship;
ArrayList<BigAsteroid> asteroids;
ArrayList<Bullet> bullets;
// Initialize stars and spaceship ---------------------------------------------
public void setup() {
  size(1280, 720);
  frameRate(90);
  smooth();
  ship = new SpaceShip();
  game = new Game((SpaceShip) ship);
  stars = new Star[100];
  for (int i = 0; i < stars.length; i++) stars[i] = new Star();

  asteroids = new ArrayList<BigAsteroid>();
  for (int i = 0; i < asteroidCount; i++) asteroids.add(new BigAsteroid());
  bullets = new ArrayList<Bullet>();
}
// Display the game -----------------------------------------------------------
public void draw() {
  game.screenFade();
  game.keyActions();
  for (int i = 0; i < stars.length; i++) stars[i].display();
  game.destroyAsteroids(asteroids);
  game.destroyBullets(bullets);
  //game.destroyShip((SpaceShip) ship);
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
  game.UI((SpaceShip) ship);
}
// Detect Spaceship controls --------------------------------------------------
boolean wPressed = false;
boolean sPressed = false;
boolean aPressed = false;
boolean dPressed = false;
boolean weaponFiring = false;
boolean hyperspaceActive = false;
boolean ctrlPressed = false;
// Detect mouse presses -------------------------------------------------------
public void mouseClicked() {
  screenNum++;
}
// Detect key presses ---------------------------------------------------------
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
  // initiate hyperspace
  if ((key == 'f' || key == 'F') && !hyperspaceActive) {
    hyperspaceActive = true;
    ((SpaceShip) ship).hyperSpace();
  }
  // detect ship "brakes" presses
  if (keyCode == CONTROL) ctrlPressed = true;
}
// Detect key releases for multiple key presses -------------------------------
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
// Game class to store game methods -------------------------------------------
class Game {
  SpaceShip myShip;
  public Game(SpaceShip tempShip) {
    myShip = tempShip;
  }
  // Fade the screen slightly to create motion blur
  public void screenFade() {
    noStroke();
    fill(bgColor, 125);
    rect(0, 0, width, height);
  }
  // Display screens and ship info
  public void UI(SpaceShip ship) {
    // display number of lives
    fill(250, 255, 0);
    textSize(30);
    text("Lives: " + ship.getLives(), 0.9*width, 0.9*height);
    if (screenNum == 0) startScreen();
    else if (asteroids.size() == 0 && bullets.size() == 0) winScreen();
    else if (ship.myLives <= 0) deathScreen();
  }
  // Beginning screen
  private void startScreen() {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("Click to begin...", width/2, height/2);
    myShip.setLives(3);
  }
  // Win screen
  private void winScreen() {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("You Win!", width/2, height/2);
  }
  // End screen on death
  private void deathScreen() {
    noStroke();
    fill(0);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("You Lose!", width/2, height/2);
  }
  // Respond to key presses
  public void keyActions() {
    double accelerationF = 0.2;
    int rotationF = 5;  // rotation in degrees
    // ship navigation
    if (wPressed) ship.accelerate(accelerationF);
    //if (sPressed) ship.accelerate(-accelerationF);
    if (aPressed) ship.rotate(-rotationF);
    if (dPressed) ship.rotate(rotationF);
    // ship "brakes" for slowing down
    if (ctrlPressed) {
      double reducF = 0.99;
      if (Math.abs(ship.myDirectionX) < 0.1) ship.myDirectionX = 0;
      if (Math.abs(ship.myDirectionY) < 0.1) ship.myDirectionY = 0;
      else {
        if (Math.abs(ship.myDirectionX) > 0) ship.myDirectionX *= reducF;
        if (Math.abs(ship.myDirectionY) > 0) ship.myDirectionY *= reducF;
      }
    }
  }
  // Destroy asteroids
  public void destroyAsteroids(ArrayList<BigAsteroid> asteroids) {
    // crashes into ship
    for (int i = 0; i < asteroids.size (); i++) {
      if (asteroids.get(i).distToShip((SpaceShip) ship) <= asteroids.get(i).getRadius()) {
        asteroids.remove(i);
        myShip.setLives(myShip.getLives()-1);
      }
    }
    // bullet hits asteroid
    for (int i = 0; i < asteroids.size (); i++) {
      for (Bullet b : bullets) {
        // Ensure asteroids size is more than i to prevent crash, remove asteroid if bullet in range
        if (asteroids.size() > i && asteroids.get(i).distToBullet(b) <= asteroids.get(i).getRadius()) asteroids.remove(i);
      }
    }
  }
  // Destroy bullets when they move off the screen
  public void destroyBullets(ArrayList<Bullet> bullets) {
    for (int i = 0; i < bullets.size (); i++) {
      int radius = bullets.get(i).mySize/2;
      int centerX = bullets.get(i).getX();
      int centerY = bullets.get(i).getY();
      // Detect bullet if on screen, destroy if off screen
      if (centerX > width+radius || centerX < 0-radius || centerY > height+radius || centerY < 0-radius) {
        bullets.remove(i);
      }
    }
  }
}
// Star class to draw monochromatic stars -------------------------------------
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
// Draws the spaceship --------------------------------------------------------
class SpaceShip extends Floater {
  private int[] myXs, myYs;
  private int myLives;
  private final int MAX_SPEED;
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
    myLives = 3;
    myColor = color(255, 94, 0);
    myCenterX = width/2;
    myCenterY = height/2;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
    MAX_SPEED = 15;
  }
  public void setLives(int tempLives) {
    myLives = tempLives;
  }
  public int getLives() {
    return (myLives < 0) ? 0 : myLives;
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
    if (Math.abs(myDirectionX) > MAX_SPEED) {
      if (myDirectionX > 0) myDirectionX = MAX_SPEED;
      else if (myDirectionX < 0) myDirectionX = -MAX_SPEED;
    }
    if (Math.abs(myDirectionY) > MAX_SPEED) {
      if (myDirectionY > 0) myDirectionY = MAX_SPEED;
      else if (myDirectionY < 0) myDirectionY = -MAX_SPEED;
    }
    //enginePropulsion();
  }
  // Draw engine flames
  //private void enginePropulsion() {
  //  int[] flameColors = { 
  //    color(226, 88, 34), 
  //    color(255, 153, 0), 
  //    color(255, 165, 0), 
  //    color(255, 88, 0), 
  //    color(255, 209, 220)
  //  };
  //  strokeWeight(10);
  //  stroke(flameColors[(int) (Math.random()*flameColors.length)]);
  //  point((float) (ship.getX()-ship.getDirectionX()), (float) (ship.getY()-ship.getDirectionY()));
  //  // fill(color(flameColors[(int) (Math.random()*flameColors.length)]));
  //  // ellipse((float) (myDirectionX-myCenterX), (float) (myDirectionY-myCenterY), 100, 100);
  //}
  // Hyperspace to new position facing new direction
  public void hyperSpace() {
    myCenterX = (int) (Math.random()*width);
    myCenterY = (int) (Math.random()*height);
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
// Draws Asteroid -------------------------------------------------------------
class Asteroid extends Floater {
  protected int rotateSpeed, radius;
  public Asteroid() {
    corners = 10;
    radius = 0;
    //xCorners = randomCorners('x', corners, radius);
    //yCorners = randomCorners('y', corners, radius);
    rotateSpeed = 0;
    int grey = (int) (Math.random()*51) + 102;
    myColor = color(grey, grey, grey);
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
  public int getRadius() {
    return radius;
  }
  public void move() {
    rotate(rotateSpeed);  // rotate by individually specified amount
    super.move();         // move according to Floater defined move() method
  }
  // Create random corners for the asteroid in a circular method
  protected int[] randomCorners(char dim, int num, int meanRadius) {
    int[] nums = new int[num];  // number of corners
    float theta = 0;
    for (int i = 0; i < nums.length; i++) {
      int radius = (int) (Math.random()*(meanRadius+1)) + (meanRadius-30);
      if (dim == 'x') nums[i] = (int) (Math.sin(theta)*radius);
      if (dim == 'y') nums[i] = (int) (Math.cos(theta)*radius);
      theta += TWO_PI/num;
    }
    return nums;
  }
  // Return distance from this asteroid to SpaceShip s
  protected float distToShip(SpaceShip s) {
    return dist(getX(), getY(), s.getX(), s.getY());
  }
  // Return distance from this asteroid to a Bullet b
  protected float distToBullet(Bullet b) {
    return dist(getX(), getY(), b.getX(), b.getY());
  }
}
// Draw Big Asteroid ----------------------------------------------------------
class BigAsteroid extends Asteroid {
  public BigAsteroid() {
    radius = 75;
    xCorners = randomCorners('x', corners, radius);
    yCorners = randomCorners('y', corners, radius);
    rotateSpeed = (int) (Math.random()*7) - 5;
  }
}
// Draw Small Asteroid --------------------------------------------------------
class SmallAsteroid extends Asteroid {
  public SmallAsteroid() {
    radius = 40;
    xCorners = randomCorners('x', corners, radius);
    yCorners = randomCorners('y', corners, radius);
    rotateSpeed = (int) (Math.random()*11) - 5;
  }
}
// Draws bullet ---------------------------------------------------------------
class Bullet extends Floater {
  int mySize, mySpeed;
  public Bullet (SpaceShip ship) {
    myCenterX = ship.getX();
    myCenterY = ship.getY();
    myPointDirection = ship.getPointDirection();
    double dRadians = myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + ship.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + ship.getDirectionY();
    mySize = 10;
    mySpeed = 5;
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
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
  }
  public void show() {
    noStroke();
    fill(255, 255, 0);
    ellipse((float) myCenterX, (float) myCenterY, mySize, mySize);
  }
}
// Abstract Floater class -----------------------------------------------------
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