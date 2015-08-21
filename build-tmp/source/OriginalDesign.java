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

public void setup() {
	size(640, 480);
	background(0);
}

float d = 0;
int velocity = 1;
public void draw() {
	ellipse(width/2, height/2, d, d);
	d += velocity;
	if (d == 0 || d == minBounds()) {
		velocity *= -1;
	}
}

// Returns smaller size() dimension
public int minBounds() {
	if (height < width) {
		return height;
	} else {
		return width;
	}
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
