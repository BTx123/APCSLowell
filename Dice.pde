/* Dice
 * Author: Brian T
 * Date: 9/8/2015
 * Description: Simulates the rolling of dice.
 */

Die d;

int rows = 3;
int columns = 3;
int dieSize = 100;

PFont font;

void setup() {
    size(648, 700);
    noLoop();
    font = loadFont("AdobeGurmukhi-Bold-48.vlw");
}

void draw() {
    int myHeight = width;
    int dieTotal = 0;
    background(127);
    for (float y = (float) 1/(2*rows)*myHeight; y < myHeight; y += (float) 1/rows*myHeight) {
        for (float x = (float) 1/(2*columns)*width; x < width; x += (float) 1/columns*width) {
            d = new Die(x, y, dieSize);
            d.roll();
            d.show();
            dieTotal += d.value;
        }
    }
    // display sum of all dice values
    textAlign(CENTER, CENTER);
    textFont(font);
    text("Total: " + dieTotal, width/2, height - (height - width)/2);
}

// Randomize dice on click
void mousePressed() {
    if (mouseButton == LEFT) {
        redraw();
    }
}

// Change number of dice rows, columns, & size
void keyPressed() {
    // controls number of rows
    if (key == 'w') {
        rows++;
        redraw();
    } else if (key == 's' && rows > 0) {
        rows--;
        redraw();
    }
    // controls number of columns
    if (key == 'a' && columns > 0) {
        columns--;
        redraw();
    } else if (key == 'd') {
        columns++;
        redraw();
    }
    // controls die size
    if (key == 'e') {
        dieSize++;
        redraw();
    } else if (key == 'q' && dieSize > 0) {
        dieSize--;
        redraw();
    }
}

// Models one single dice cube
class Die {
    float x, y, dieSize, dotSize, value;

    Die(float tempX, float tempY, int tempDieSize) {
        x = tempX;
        y = tempY;
        dieSize = tempDieSize;
        dotSize = 0.2*dieSize;
        value = 1;
    }

    void roll() {
        value = (int) (Math.random()*6) + 1;
    }

    // Draw a single dot
    void singleDot(float x, float y) {
        noStroke();
        fill(0);
        ellipseMode(CENTER);
        ellipse(x, y, dotSize, dotSize);
    }

    // Draw die with dots depending on random value
    void show() {
        rectMode(CENTER);
        strokeWeight(3);
        stroke(100);
        fill(255);
        rect(x, y, dieSize, dieSize, dieSize/10);
        if (value == 1 || value == 3 || value == 5) {
            singleDot(x, y);  // CENTER
            if (value == 3 || value == 5) {
                // draw dots on upper left & bottom right
                singleDot(x - 0.25*dieSize, y - 0.25*dieSize);  // TL
                singleDot(x + 0.25*dieSize, y + 0.25*dieSize);  // BR
            }
            if (value == 5) {
                // draw dots on upper right & bottom left
                singleDot(x + 0.25*dieSize, y - 0.25*dieSize);  // TR
                singleDot(x - 0.25*dieSize, y + 0.25*dieSize);  // BL
            }
        } else if (value == 2 || value == 4) {
            // draw dots on upper left & bottom right
            singleDot(x - 0.25*dieSize, y - 0.25*dieSize);  // TL
            singleDot(x + 0.25*dieSize, y + 0.25*dieSize);  // BR
            if (value == 4) {
                // draw dots upper right & bottom left
                singleDot(x + 0.25*dieSize, y - 0.25*dieSize);  // TR
                singleDot(x - 0.25*dieSize, y + 0.25*dieSize);  // BL
            }
        } else if (value == 6) {
            // draw 3 dots on left & 3 dots on right
            singleDot(x - 0.25*dieSize, y - 0.25*dieSize);  // TL
            singleDot(x - 0.25*dieSize, y);  // CL
            singleDot(x - 0.25*dieSize, y + 0.25*dieSize);  // BL
            singleDot(x + 0.25*dieSize, y - 0.25*dieSize);  // TR
            singleDot(x + 0.25*dieSize, y);  // CR
            singleDot(x + 0.25*dieSize, y + 0.25*dieSize);  // BR
        } else {
            println("ERROR: Out of bounds");
        }
    }
}