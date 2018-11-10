class NamedCow extends Cow {
  private String myName;
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
  public String getName() {
    return myName;
  }
}
