class Cow implements Animal {     
  private String myType, mySound;
  public Cow(String tempType, String tempSound) {
    myType = tempType;
    mySound = tempSound;
  };
  public Cow() {
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
