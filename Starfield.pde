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
  particles = new Particle[100];
  for (int i = 0; i < particles.length; i++) {
    if (i == 0) particles[i] = new OddballParticle();
    else if (i == 1) particles[i] = new JumboParticle();
    else particles[i] = new NormalParticle();
  }
}

void draw() {
  background(bgColor);
  for (int i = 0; i < particles.length; i++) {
    particles[i].update();
    particles[i].display();
  }
}

class NormalParticle implements Particle {
  double x, y, theta, speed;
  int myColor, mySize;
  NormalParticle() {
    x = width/2;
    y = height/2;
    myColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    theta = Math.random()*(2*PI);
    speed = 2;
    mySize = 10;
  }
  public void update() {
    theta = Math.random()*(2*PI);
    x += Math.cos(theta)*speed;
    y += Math.sin(theta)*speed;
    x = constrain((int) x, 0, width-1);
    y = constrain((int) y, 0, height-1);
  }
  public void display() {
    noStroke();
    fill(myColor);
    ellipse((float) x, (float) y, mySize, mySize);
  }
}

interface Particle {
  public void update();
  public void display();
}

class OddballParticle implements Particle {  // uses an interface
  double x, y, theta, speed;
  int myColor, mySize;
  OddballParticle() {
    x = width/2;
    y = height/2;
    myColor = color(255);
    theta = Math.random()*(2*PI);
    speed = 2;
    mySize = 10;
  }
  void update() {
    theta = Math.random()*(2*PI);
    x += Math.cos(theta)*speed;
    y += Math.sin(theta)*speed;
    x = constrain((int) x, 0, width-1);
    y = constrain((int) y, 0, height-1);
  }
  void display() {
    noStroke();
    fill(myColor);
    rectMode(CENTER);
    rect((float) x, (float) y, 10*mySize, 10*mySize);
  }
}

class JumboParticle extends NormalParticle {  // uses inheritance
  JumboParticle() {
    mySize *= 10;
  }
}

