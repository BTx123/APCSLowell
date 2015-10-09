/* Snowflake Catcher
 * Author: Brian Tom
 * Date: 10/02/2015
 * Description: Simulates a starfield.
 */

Particle[] particles;

int bgColor = color(0);

void setup() {
  size(1280, 720);
  smooth();
  particles = new Particle[150];
  for (int i = 0; i < particles.length; i++) {
    if (i == particles.length-2) particles[i] = new OddballParticle();
    else if (i == particles.length-1) particles[i] = new JumboParticle();
    else particles[i] = new NormalParticle();
  }
}

void draw() {
  background(bgColor);
  for (int i = 0; i < particles.length; i++) {
    particles[i].update();
    particles[i].respawn();
    particles[i].display();
  }
}
// Particle interface with basic functions
interface Particle {
  public void update();
  public void display();
  public void respawn();
}

class NormalParticle implements Particle {
  double x, y, theta, speed, mySize, sizeF;
  int myColor;
  // Constructor
  NormalParticle() {
    theta = Math.random()*TWO_PI;  // random heading
    speed = Math.random()*(max(width, height)/2);  // random starting position
    x = width/2 + Math.cos(theta)*speed;  // adjust for starting position
    y = height/2 + Math.sin(theta)*speed;
    speed = 0.5;  // set speed to default
    sizeF = 0.01;
    mySize = dist((float) x, (float) y, (float) width/2, (float) height/2)*sizeF;  // set size depending on distance from center
    myColor = color((int) (Math.random()*11)+245, (int) (Math.random()*256), 0);  // random color
  }
  // Update position and size of particles
  public void update() {
    x += Math.cos(theta)*speed;
    y += Math.sin(theta)*speed;
    mySize = dist((float) x, (float) y, (float) width/2, (float) height/2)*sizeF;
  }
  // Display particle
  public void display() {
    noStroke();
    fill(myColor);
    ellipse((float) x, (float) y, (float) mySize, (float) mySize);
  }
  // Spawn particle back at center with new size, position, direction, and color
  public void respawn() {
    double adj = mySize/2;
    if (x < 0-adj || x > width-1+adj || y < 0-adj || y > height-1+adj) {
      mySize = 0;
      x = width/2;
      y = height/2;
      theta = Math.random()*TWO_PI;
      myColor = color((int) (Math.random()*11)+245, (int) (Math.random()*256), 0);
    }
  }
}

class OddballParticle implements Particle {  // uses an interface
  double x, y, theta, speed, mySize;
  int myColor;
  OddballParticle() {
    x = width/2;
    y = height/2;
    myColor = color(255);
    theta = Math.random()*TWO_PI;
    speed = 5;
    mySize = 50;
  }
  void update() {
    theta = Math.random()*TWO_PI;
    x += Math.cos(theta)*speed;
    y += Math.sin(theta)*speed;
  }
  void display() {
    noStroke();
    fill(myColor);
    ellipse((float) x, (float) y, (float) mySize, (float) mySize);
    rectMode(CENTER);
    rect((float) x, (float) y, (float) (1.5*mySize), (float) (0.25*mySize), 10);
  }
  void respawn() {
    double adj = mySize/2;
    if (x < 0-adj || x > width-1+adj || y < 0-adj || y > height-1+adj) {
      theta = Math.random()*TWO_PI;
      x = width/2;
      y = height/2;
    }
  }
}

class JumboParticle extends NormalParticle {  // uses inheritance
  int maxSize = 100;
  JumboParticle() {
    sizeF = 0.5;
    mySize = dist((float) x, (float) y, (float) width/2, (float) height/2)*sizeF;
  }
  public void update() {
    mySize = dist((float) x, (float) y, (float) width/2, (float) height/2)*sizeF;
    if ( mySize > maxSize) mySize = maxSize;
    x += Math.cos(theta)*speed;
    y += Math.sin(theta)*speed;
  }
}

