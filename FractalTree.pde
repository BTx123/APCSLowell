private double fractionLength = 0.9; // branch length reduction factor
private int smallestBranch = 20;     // length of the smallest allowed branch
private float lineWidth = 10;        // initial width of branches
//private double branchAngle = 1;

public void setup() {
  size(640, 480);
}

public void draw() {
  background(0);
  drawBranches(320, 380, 65, 3*Math.PI/2, lineWidth);
  strokeWeight(lineWidth);
  stroke(139, 69, 19);
  line(320, 480, 320, 380);
}

public void drawBranches(double x, double y, double branchLength, double angle, float lineWidth) {
  double angle1 = angle + 1.39626; // right
  double angle2 = angle - 0.349066; // left
  branchLength *= fractionLength;
  double endX1 = x + branchLength*cos((float) angle1);
  double endY1 = y + branchLength*sin((float) angle1);
  double endX2 = x + branchLength*cos((float) angle2);
  double endY2 = y + branchLength*sin((float) angle2);
  strokeWeight(lineWidth);
  stroke(0, 255, 0);
  line((float) x, (float) y, (float) endX1, (float) endY1);
  line((float) x, (float) y, (float) endX2, (float) endY2);
  if (branchLength > smallestBranch) {
    lineWidth *= 0.7;
    drawBranches(endX1, endY1, branchLength, angle + 1.39626, lineWidth);
    drawBranches(endX2, endY2, branchLength, angle - 0.349066, lineWidth);
  }
}

public void mousePressed() {
  if (smallestBranch < 1) smallestBranch = 1;
  if (mouseButton == LEFT) smallestBranch--;  // increase density
  if (mouseButton == RIGHT) smallestBranch++; // decrease dnesity
}