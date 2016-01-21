public void setup() {
  String lines[] = loadStrings("palindromes.txt");
  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    if (palindrome(lines[i]) == true) println(lines[i] + " IS a palidrome.");
    else println(lines[i] + " is NOT a palidrome.");
  }
}
public boolean palindrome(String word) {
  // split word at middle
  int mid = Math.round(word.length()/2.0);
  String sFront = word.substring(0, mid);
  String sBack = word.substring(mid-1);
  // reverse one of the strings
  sBack = reverse(sBack);
  // remove spaces
  sFront = noSpaces(sFront);
  sBack = noSpaces(sBack);
  // remove all capital letters with .toLowerCase()
  sFront = sFront.toLowerCase();
  sBack = sBack.toLowerCase();
  // remove all punctuation by checking whether Character.isLetter(c) == true
  sFront = removPunct(sFront);
  sBack = removPunct(sBack);
  // compare the two strings, return true if both strings are equal
  println(sFront);
  println(sBack);
  if (sFront.equals(sBack)) return true;
  return false;
}
public String reverse(String word) {
  String s = new String();
  for (int i = word.length()-1; i >= 0; i--) {
    s += word.substring(i, i+1);
  }
  return s;
}
public String noSpaces(String word) {
  String s = new String();
  for (int i = 0; i < word.length(); i++) {
    if (word.charAt(i) != ' ') s += word.charAt(i);
  }
  return s;
}
public String removPunct(String word) {
  String s = new String();
  for (int i = 0; i < word.length(); i++) {
    if (Character.isLetter(word.charAt(i))) s += word.charAt(i);
  }
  return s;
}
