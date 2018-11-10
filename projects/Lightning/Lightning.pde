/* Lightning
 * Author: Brian T
 * Date: 8/31/2015
 * Description: Draws lightning bolts
 */

// Background color
color bgColor = color(0, 0, 25);

boolean reset = true;  // start with background and clouds

void setup() {
    size(1152, 648);
    background(bgColor);
    frameRate(60);
    smooth();
    clouds();
    noLoop();
}

void draw() {
    if (reset) {
        // reset background if user RIGHT clicks
        background(bgColor);
        clouds();
        reset = false;
    } else {
        // draw lightning bolt when user LEFT clicks
        LightningBolt l = new LightningBolt();
        l.display();
    }
}

int randNum(int range, int offset) {
    return (int) (Math.random()*range) + offset;
}

// Draw clouds
void clouds() {
    noStroke();
    fill(212, 212, 210);
    int randX, randY, randWidth, randHeight;
    randWidth = 0;
    for (int i = 0; i < width; i += randWidth/3) {
        randX = randNum(width, 0);
        randY = randNum(50, 0);
        randWidth = randNum(100, 50);
        randHeight = randNum(50, 25);
        ellipse(randX, randY, randWidth, randHeight);
    }
}

class LightningBolt {
    // starting point for lightning bolt
    int startX, startY, endX, endY;

    LightningBolt() {  // constructor initializes variables
        startX = mouseX;
        startY = 0;
        endX = mouseX;
        endY = 0;
    }

    // Draw lightning bolts
    void display() {
        // draw lightning until reaches bottom of screen
        while (endY <= height) {
            endX += randNum(121, -60);  // change endX by random horizontal distance
            endY += randNum(61, -10);   // change endy by random vertical distance
            // Draw lightning flash behind lightning line
            strokeWeight(8);
            stroke(255, 255, 255, 75);
            line(startX, startY, endX, endY);
            // Draw lightning line
            strokeWeight(3);
            color randColor = color((int) (Math.random()*10) + 246, 255, (int) (Math.random()*256));  // set random color of lightning
            stroke(randColor);
            line(startX, startY, endX, endY);
            // set startX & startY to end of previous line
            startX = endX;
            startY = endY;
        }
    }
}

void mouseClicked() {
    if (mouseButton == LEFT) {
        redraw();
    }
    if (mouseButton == RIGHT) {
        // reset background
        reset = true;
        redraw();
    }
}
