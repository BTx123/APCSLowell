/* Doodads
 * Author: Brian Tom
 * Date: 10/22/2015
 * Description: Encapsulation Practice
 */

public void setup() {
  Doodad one = new Doodad();
  Doodad two = new Doodad();
  one.setNum(3.14159);
  two.setNum(2.71828);
  System.out.println("Sum is " + (one.getNum() + two.getNum()));
}
