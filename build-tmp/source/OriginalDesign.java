import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class OriginalDesign extends PApplet {

/* Normal Original Design
 * Author: Brian Tom
 * Date: 8/26/2015
 * Description: https://processing.org/examples/bouncybubbles.html
 */

// TODO: Fix bug - ball stuck on edge of screen when spawning too close to edge

int maxBalls = 30;  // max number of balls on screen
int numBalls = 0;   // number of balls currently on screen

Ball[] ballArray;   // array of Balls

public void setup() {
    size(640, 480);
    ballArray = new Ball[maxBalls];
    noLoop();
}

public void draw() {
    background(255);
    dots(1, 127, 10);
    for (int i = 0; i < numBalls; i++) {
        ballArray[i].display();  // draw ellipse
        ballArray[i].update();   // update position & direction
    }
}

// Draw background dots
public void dots(int pointSize, int grayScale, int interval) {
    strokeWeight(pointSize);
    stroke(grayScale);
    for (int i = interval/2; i < width; i += interval) {
        for (int j = interval/2; j < height; j += interval) {
            point(i, j);
        }
    }
}

// Ball class
class Ball {
    float ballX;
    float ballY;
    float ballDiameter;
    float ballSpeed;

    // Takes initializing variables for diameter and speed
    Ball(float tempDiameter, float tempSpeed) {
        ballDiameter = tempDiameter;
        ballSpeed = tempSpeed;
        // ballX = (float) (Math.random() * (0.9*width) + 10);
        // ballY = (float) (Math.random() * (0.9*height) + 10);

        // ball spawns at mouse position
        ballX = mouseX;
        ballY = mouseY;
    }
    
    int ballColor = color((int) (Math.random()*255), (int) (Math.random()*255), (int) (Math.random()*255));
    
    // Draw ellipse
    public void display() {
        noStroke();
        fill(ballColor);
        ellipse(ballX, ballY, ballDiameter, ballDiameter);
    }

    // Update position and direction
    public void update() {
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
public void mouseClicked() {
    if (numBalls < maxBalls) {
        ballArray[numBalls] = new Ball(20, 10);
        numBalls++;
    }
}

public void play() {
    
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "OriginalDesign" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
