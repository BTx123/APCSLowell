//your variable declarations here
public void setup() {
  //your code here
}
public void draw() {
  //your code here
}
class SpaceShip extends Floater {
  private int[] myXs, myYs;
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
    myColor = color(255, 255, 255);
    myCenterX = myCenterY = 0;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int tempX) { myCenterX = tempX; }
  public int getX() { return 0; }
  public void setY(int tempY) { myCenterY = tempY; }
  public int getY() { return 0; }
  public void setDirectionX(double tempX) { myDirectionX = tempX; }
  public double getDirectionX() { return myDirectionX; }
  public void setDirectionY(double tempY) { myDirectionY = tempY; }
  public double getDirectionY() { return myDirectionY; }
  public void setPointDirection(int tempDegrees) { myPointDirection = tempDegrees; }
  public double getPointDirection() { return myPointDirection; }
  
}
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
  public void accelerate (double dAmount) {
    // convert the current direction the floater is pointing to radians
    double dRadians = myPointDirection*(Math.PI/180);
    // change coordinates of direction of travel
    myDirectionX += ((dAmount) * Math.cos(dRadians));
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }
  // Rotates the floater by a given number of degrees
  public void rotate (int nDegreesOfRotation) {     
    myPointDirection+=nDegreesOfRotation;
  }
  // Move the floater in the current direction of travel
  public void move () {  
    // change the x and y coordinates by myDirectionX and myDirectionY
    myCenterX += myDirectionX;
    myCenterY += myDirectionY;
    // wrap around screen
    if (myCenterX >width) {
      myCenterX = 0;
    } else if (myCenterX<0) {     
      myCenterX = width;
    }
    if (myCenterY >height) {    
      myCenterY = 0;
    } else if (myCenterY < 0) {     
      myCenterY = height;
    }
  }
  // Draws the floater at the current position
  public void show () {
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

