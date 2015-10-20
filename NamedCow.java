class NamedCow extends Cow {
  private String myType, myName, mySound;
  public NamedCow(String tempType, String tempName, String tempSound) {
    myType = tempType;
    myName = tempName;
    mySound = tempSound;
  }
  public NamedCow() {
    myType = "unknown";
    myName = "unknown";
    mySound = "unknown";
  }
  public String getType() {
    return myType;
  }
  public String getName() {
    return myName;
  }
  public String getSound() {
    return mySound;
  }
}
