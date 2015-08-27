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

// Increase number of balls on click
void mouseClicked() {
    if (numBalls < maxBalls) {
        ballArray[numBalls] = new Ball(20, 10);
        numBalls++;
    }
}