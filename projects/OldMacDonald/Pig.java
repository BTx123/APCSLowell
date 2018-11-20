class Pig implements Animal {
  private String myType, mySound;
  public Pig(String tempType, String tempSound) {
    myType = tempType;
    mySound = tempSound;
  };
  public Pig() {
    myType = "unknown";
    mySound = "unknown";
  }
  public String getSound() {
    return mySound;
  };
  public String getType() {
    return myType;
  };
}
