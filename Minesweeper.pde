/* Minesweeper
 * Author: Brian Tom
 * Date: 2/19/16
 * Description: MS's Minesweeper game
 */

import de.bezier.guido.*;

private static final int NUM_ROWS  = 20; // number of rows
private static final int NUM_COLS  = 20; // number of columns
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

public void setBombs() {
  while (bombs.size() < NUM_BOMBS) {
    int row = (int) (Math.random()*NUM_ROWS);
    int col = (int) (Math.random()*NUM_COLS);
    if (!bombs.contains(buttons[row][col])) {
      bombs.add(new MSButton(row, col));
      //bombs.get(bombs.size()-1).marked = true;
    }
  }
}

public void draw () {
  background(0);
  if (isWon())
    displayWinningMessage();
}
public boolean isWon() {
  //your code here
  return false;
}
public void displayLosingMessage() {
  //your code here
}
public void displayWinningMessage() {
  //your code here
}

public class MSButton {
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc ) {
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
    clicked = true;
    //your code here
  }

  public void draw () {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel) {
    label = newLabel;
  }
  public boolean isValid(int r, int c) {
    //your code here
    return false;
  }
  public int countBombs(int row, int col) {
    int numBombs = 0;
    //your code here
    return numBombs;
  }
}
