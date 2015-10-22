/* Thingies
 * Author: Brian Tom
 * Date: 10/21/2015
 * Description: Encapsulation Practice
 */

public void setup() {
  Thingy bob = new Thingy();
  Thingy mary = new Thingy();
  bob.setX(30);
  bob.setY(30);
  mary.setX(70);
  mary.setY(70);
  System.out.println("Distance between bob and mary is " + dist(bob.getX(), bob.getY(), mary.getX(), mary.getY()));
}
