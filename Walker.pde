class Walker {
  float x;
  float y;

  Walker() {
    x = width/2;
    y = height/2;
  }

  void step(float stepSize) {
    float prob = random(1);
    if (prob < 0.5) {
      if (x < mouseX) {
        x++;
      } else {
        x--;
      }
      if (y < mouseY) {
        y++;
      } else {
        y--;
      }
    } else {
      float stepX = random(-stepSize, stepSize);
      float stepY = random(-stepSize, stepSize);
      x += stepX;
      y += stepY;
    }
  }

  void display() {
    stroke(3);
    point(x, y);
  }
}

