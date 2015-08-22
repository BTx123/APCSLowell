//void setup() {
//	size(640, 480);
//	background(0);
//}

//float d = 0;
//int velocity = 3;
//void draw() {
//	ellipse(width/2, height/2, d, d);
//	d += velocity;
//	if (d == 0 || d == minBounds()) {
//		velocity *= -1;
//	}
//}

//// Returns smaller size() dimension
//int minBounds() {
//	if (height < width) {
//		return height;
//	} else {
//		return width;
//	}
//}

/* Normal Distribution of Random Numbers
 * Author: Brian Tom
 * Date: 8/20/2015
 * Description: Demonstrates the use of Random() to create gaussian distributions
 */

import java.util.*;  // Random() class library

Random generator;

void setup() {
  size(640, 360);
  background(0);
  generator = new Random();
}

void draw() {
  // generates random gaussian number (double to float typecast)
  float numX = (float) generator.nextGaussian();
  float numY = (float) generator.nextGaussian();
  // center of guassian shape
  int meanX = width/2;
  int meanY = height/2;
  // standard deviation (size of shape in pixels)
  int stdev = 60;
  // calculate new gaussian number with standard deviation and mean
  float x = numX*stdev + meanX;
  float y = numY*stdev + meanY;
  // draw ellipses
  noStroke();
  fill(255, 15);
  ellipse(x, y, 20*numX, 20*numY);
  fill(255, 0, 0, 1);
  ellipse(x, y, 10/numX, 10/numY);
}