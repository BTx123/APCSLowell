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

public class Lightning extends PApplet {

/* Lightning
 * Author: Brian Tom
 * Date: 8/31/2015
 * Description: Draws lightning bolts
 */

// Background color
int bgColor = color(30, 60, 127);

Lightning bob;

public void setup() {
  size(300, 300);
  strokeWeight(3);
  background(bgColor);
  bob = new Lightning();
}

public void draw() {
  bob.screenDisplay();
}

class Lightning {
  // starting point for lightning bolt
  int startX, startY, endX, endY;
  
  Lighting() {  // initialize variables
    startX = 0;
    start = 150;
    endX = 0;
    endY = 150;
  }
  
  // Draw lightning bolts
  public void screenDisplay() {
    // set random color of lightning
    int randColor = color((int) (Math.random()*10) + 246, 255, (int) (Math.random()*256));
    stroke(randColor);
    // change endX by random distance to the right
    endX += (int) (Math.random()*10);
    // change endy by random vertical distance
    endY += (int) (Math.random()*19) - 9;
    // draw line
    line(startX, startY, endX, endY);
    // set startX & startY to end of previous line
    startX = endX;
    startY = endY;
  }
}

public void mousePressed() {
  // reset background, deleting previous lightning bolt
  background(bgColor);
  // reset starting and endpoint
  startX = 0;
  startY = 150;
  endX = 0;
  endY = 150;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Lightning" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
