private float branchLength = 50;    // base branch length
private float k1 = .65;             // factor of left branch
private float k2 = .65;            // factor of left branch
private float fractionLength = 0.95; // branch length reduction factor
private int smallestBranch = 20;    // length of the smallest allowed branch
private float lineWidth = 10;       // initial width of branches
private float leftAngle = 20;       // degrees left
private float rightAngle = 80;      // degrees right
private boolean play = false;       // start with animation off

public void setup() {
  //fullScreen();
  size(640, 480);
}

public void draw() {
  background(0);
  drawBranches(320.0, 380.0, k1*branchLength, k2*branchLength, 3 * (float) Math.PI/2, lineWidth);
  strokeWeight(lineWidth);
  stroke(139, 69, 19);
  line(320, 480, 320, 380);
  animate();
}
// Recursively draw branches
public void drawBranches(float x, float y, float branchLength1, float branchLength2, float angle, float lineWidth) {
  float angle1 = angle - radians(leftAngle);  // left
  float angle2 = angle + radians(rightAngle); // right
  branchLength1 *= fractionLength;
  branchLength2 *= fractionLength;
  float endX1 = x + branchLength*cos(angle1);
  float endY1 = y + branchLength*sin(angle1);
  float endX2 = x + branchLength*cos(angle2);
  float endY2 = y + branchLength*sin(angle2);
  strokeWeight(lineWidth);
  stroke(0, 255, 0);
  line(x, y, endX1, endY1);
  line(x, y, endX2, endY2);
  lineWidth *= 0.7;
  if (branchLength1 > smallestBranch) drawBranches(endX1, endY1, branchLength1, branchLength2, angle - radians(leftAngle), lineWidth);
  if (branchLength2 > smallestBranch) drawBranches(endX2, endY2, branchLength1, branchLength2, angle + radians(rightAngle), lineWidth);
}
// Increase branch length and increase angle measures for animation
public void animate() {
  if (smallestBranch > 15 && mousePressed && mouseButton == LEFT) smallestBranch--;  // increase density
  else if (smallestBranch < 100 && mousePressed && mouseButton == RIGHT) smallestBranch++; // decrease density
  if (play) {
    leftAngle += radians(180);
    rightAngle += radians(180);
  }
}
// Use SPACE to toggle animation
public void keyPressed() {
  if (key == ' ') play = !play;
}
