/* Minesweeper
 * Author: Brian Tom
 * Date: 2/19/16
 * Description: MS's Minesweeper game
 */

import de.bezier.guido.*;

private static final int NUM_ROWS  = 25; // number of rows
private static final int NUM_COLS  = 25; // number of columns
private static final int NUM_BOMBS = 10; // number of bombs
private MSButton[][] buttons;            // 2d array of minesweeper buttons
private ArrayList<MSButton> bombs;       // ArrayList of just the minesweeper buttons that are mined

void setup () {
  size(400, 400);
  textAlign(CENTER, CENTER);
  Interactive.make(this); // make the manager
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int y = 0; y < NUM_ROWS; y++) {
    for (int x = 0; x < NUM_COLS; x++) {
      buttons[x][y] = new MSButton(x, y);
    }
  }
  bombs = new ArrayList<MSButton>();
  setBombs();
}
// Add randomized bombs to board
public void setBombs() {
  while (bombs.size() < NUM_BOMBS) {
    int row = (int) (Math.random()*NUM_ROWS);
    int col = (int) (Math.random()*NUM_COLS);
    if (!bombs.contains(buttons[row][col])) bombs.add(buttons[row][col]);
  }
}

public void draw () {
  background(0);
  if (isWon()) displayWinningMessage();
}
public boolean isWon() {
  for (int y = 0; y < NUM_ROWS; y++) {
    for (int x = 0; x < NUM_COLS; x++) {
      if (!bombs.contains(buttons[y][x]) && !buttons[y][x].isClicked()) return false;
    }
  }
  return true;
}
// Show losing message if bomb is clicked
public void displayLosingMessage() {
  for (int y = 0; y < NUM_ROWS; y++) {
    for (int x = 0; x < NUM_COLS; x++) {
      if (bombs.contains(buttons[y][x]) && !buttons[y][x].isClicked()) buttons[y][x].clicked = true;
    }
  }
  String message = "YOU LOSE!";
  char[] c = message.toCharArray();
  for (int x = 0; x < c.length; x++) {
    buttons[NUM_ROWS/2][(NUM_COLS-c.length)/2+x].setLabel(String.valueOf(c[x]));
  }
  println("LOSE!");
}
// Show winning message if all bombs are found
public void displayWinningMessage() {
  fill(0);
  String message = "YOU WIN!";
  char[] c = message.toCharArray();
  for (int x = 0; x < c.length; x++) {
    buttons[NUM_ROWS/2][(NUM_COLS-c.length)/2+x].setLabel(String.valueOf(c[x]));
  }
  text("WIN!", 200, 200);
  println("WIN!");
}

public class MSButton {
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;
  public MSButton (int rr, int cc) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add(this); // register it with the manager
  }
  public boolean isMarked() {
    return marked;
  }
  public boolean isClicked() {
    return clicked;
  }
  // called by manager
  public void mousePressed () {
    if (!marked && mouseButton == LEFT) clicked = true;
    if (mouseButton == RIGHT) marked = !marked; // mark unmarked buttons
    else if (!marked && bombs.contains(this)) displayLosingMessage(); // display lose screen if bomb is pressed
    else if (countBombs(r, c) > 0) label = Integer.toString(countBombs(r, c)); // show number of nearby bombs
    else { // recursively mark buttons that are unmarked and not bombs
      if (isValid(r-1, c) && !buttons[r-1][c].isClicked()) // up
        buttons[r-1][c].mousePressed();
      if (isValid(r+1, c) && !buttons[r+1][c].isClicked()) // down
        buttons[r+1][c].mousePressed();
      if (isValid(r, c-1) && !buttons[r][c-1].isClicked()) // left
        buttons[r][c-1].mousePressed();
      if (isValid(r, c+1) && !buttons[r][c+1].isClicked()) // right
        buttons[r][c+1].mousePressed();
    }
  }
  // Draw buttons
  public void draw () {
    if (marked) fill(0);
    else if (clicked && bombs.contains(this)) fill(255, 0, 0);
    else if (clicked) fill(200);
    else fill(100);
    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  // String label for buttons
  public void setLabel(String newLabel) {
    label = newLabel;
  }
  // Chekc if button is within array limits
  public boolean isValid(int r, int c) {
    return r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS;
  }
  // Return the number of bombs surrounding buttons
  public int countBombs(int row, int col) {
    int numBombs = 0;
    // left
    if (isValid(row, col-1) && bombs.contains(buttons[row][col-1])) numBombs++;
    // right
    if (isValid(row, col+1) && bombs.contains(buttons[row][col+1])) numBombs++;
    // up
    if (isValid(row-1, col) && bombs.contains(buttons[row-1][col])) numBombs++;
    // down
    if (isValid(row+1, col) && bombs.contains(buttons[row+1][col])) numBombs++;
    // top left
    if (isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1])) numBombs++;
    // top right
    if (isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1])) numBombs++;
    // bottom left
    if (isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1])) numBombs++;
    // bottom right
    if (isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1])) numBombs++;
    return numBombs;
  }
}