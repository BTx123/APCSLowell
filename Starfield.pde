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
  particles = new Particle[500];
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
    particles[i].respawn();
    particles[i].display();
  }
}

interface Particle {
  public void update();
  public void display();
  public void respawn();
}

class NormalParticle implements Particle {
  double x, y, theta, speed;
  int myColor, mySize;
  NormalParticle() {
    x = width/2;
    y = height/2;
    myColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    theta = Math.random()*TWO_PI;
    speed = 3;
    mySize = 10;
  }
  public void update() {
    x += Math.cos(theta)*speed;
    y += Math.sin(theta)*speed;
  }
  public void display() {
    noStroke();
    fill(myColor);
    ellipse((float) x, (float) y, mySize, mySize);
  }
  public void respawn() {
    if (x < 0 || x > width-1 || y < 0 || y > height-1) {
      theta = Math.random()*TWO_PI;
      x = width/2;
      y = height/2;
    }
  }
}

class OddballParticle implements Particle {  // uses an interface
  double x, y, theta, speed;
  int myColor, mySize;
  OddballParticle() {
    x = width/2;
    y = height/2;
    myColor = color(255);
    theta = Math.random()*TWO_PI;
    speed = 1;
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
    rectMode(CENTER);
    rect((float) x, (float) y, mySize, mySize);
  }
  void respawn() {
    float adj = mySize/2;
    if (x < 0-adj || x > width-1+adj || y < 0-adj || y > height-1+adj) {
      theta = Math.random()*TWO_PI;
      x = width/2;
      y = height/2;
    }
  }
}

class JumboParticle extends NormalParticle {  // uses inheritance
  JumboParticle() {
    mySize *= 10;
  }
}

