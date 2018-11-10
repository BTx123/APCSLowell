class Chick implements Animal {
  private String myType, mySound1, mySound2;
  public Chick(String tempType, String tempSound1, String tempSound2) {
    myType = tempType;
    mySound1 = tempSound1;
    mySound2 = tempSound2;
  };
  public Chick(String tempType, String tempSound1) {
    myType = tempType;
    mySound1 = tempSound1;
  };
  public Chick() {
    myType = "unknown";
    mySound1 = "unknown";
    mySound2 = "unknown";
  }
  public String getSound() {
    if (Math.random() < 0.5) return mySound1;
    return mySound2;
  };
  public String getType() {
    return myType;
  };
}

