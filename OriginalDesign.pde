/* Normal Original Design
 * Author: Brian Tom
 * Date: 8/26/2015
 * Description: https://processing.org/examples/bouncybubbles.html
 */

int maxBalls = 10;  // max number of balls on screen
int numBalls = 0;   // number of balls currently on screen

Ball[] ballArray;   // array of Balls

void setup() {
    size(640, 480);
    ballArray = new Ball[maxBalls];
}

void draw() {
    background(255);
    dots(1, 127, 10);
    for (int i = 0; i < numBalls; i++) {
        ballArray[i].display();  // draw ellipse
        ballArray[i].update();   // update position & direction
    }
}

// Draw background dots
void dots(int pointSize, int grayScale, int interval) {
    strokeWeight(pointSize);
    stroke(grayScale);
    for (int i = interval/2; i < width; i += interval) {
        for (int j = interval/2; j < height; j += interval) {
            point(i, j);
        }
    }
}

class Ball {
    float ballX;
    float ballY;
    float ballDiameter;
    float ballSpeed;
    
    // Takes initializing variables for diameter and speed
    Ball(float tempDiameter, float tempSpeed) {
        ballDiameter = tempDiameter;
        ballSpeed = tempSpeed;
        //ballX = (float) (Math.random() * (0.9*width) + 10);
        //ballY = (float) (Math.random() * (0.9*height) + 10);
        ballX = mouseX;
        ballY = mouseY;
    }
    
    // Draw ellipse
    void display() {
        noStroke();
        fill(0);
        ellipse(ballX, ballY, ballDiameter, ballDiameter);
    }
    
    // Update position and direction
    void update() {
        // change balls y pos
        ballY += ballSpeed;
        // bounce off bottom of screen
        if (ballY >= height - ballDiameter/2)
            ballSpeed *= -1;
        // bounce off top of screen
        else if (ballY < ballDiameter/2)
            ballSpeed *= -1;
    }
}

// Increase number of balls on click
void mouseClicked() {
    if (numBalls < maxBalls) {
        ballArray[numBalls] = new Ball(20, 10);
        numBalls++;
    }
}