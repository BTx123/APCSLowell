/* Snowflake Catcher
 * Author: Brian Tom
 * Date: 10/02/2015
 * Description: Simulates a starfield.
 */

NormalParticle[] particles;

int bgColor = color(0);

void setup() {
  size(1280, 720);
  particles = new NormalParticle[100];
  for (int i = 0; i < particles.length; i++) {
//    if (i%2 == 0) particles[i] = new OddballParticle();
//    else particles[i] = new JumboParticle();
    particles[i] = new NormalParticle();
  }
}

void draw() {
  background(bgColor);
  for (int i = 0; i < particles.length; i++) {
    particles[i].update();
    particles[i].display();
  }
}

class NormalParticle {
  double x, y, theta, speed;
  int myColor, mySize;
  NormalParticle() {
    x = width/2;
    y = height/2;
    myColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    theta = Math.random()*(2*PI);
    speed = 10;
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
    ellipse((float) x, (float) y, mySize, mySize);
  }
}

interface Particle {
}

class OddballParticle {  // uses an interface
}

class JumboParticle {  // uses inheritance
}

