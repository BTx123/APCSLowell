/* Snowflake Catcher
 * Author: Brian Tom
 * Date: 10/02/2015
 * Description: Simulates a starfield.
 */

NormalParticle particles = new NormalParticle();

int bgColor = color(0);

void setup() {
  size(1280, 720);
  //  for (int i = 0; i < particles.length; i++) {
  //    if (i%2 == 0) particles[i] = new OddballParticle();
  //    else particles[i] = new JumboParticle();
  //  }
}

void draw() {
  background(bgColor);
  particles.update();
  particles.display();
}

class NormalParticle {
  double x, y, theta, speed;
  int myColor, mySize;
  NormalParticle() {
    x = 640;
    y = 360;
    myColor = color((int) (Math.random()*256), (int) (Math.random()*256), (int) (Math.random()*256));
    theta = Math.random()*(2*PI);
    speed = 10;
    mySize = 10;
  }
  void update() {
    println(width, x, y);
    theta = Math.random()*(2*PI);
    x += Math.cos(theta)*speed;
    y += Math.sin(theta)*speed;
  }
  void display() {
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

