public void setup() {
  String lines[] = loadStrings("palindromes.txt");
  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    if (palindrome(lines[i]) == true) println(lines[i] + " IS a palidrome.");
    else println(lines[i] + " is NOT a palidrome.");
  }
}
public boolean palindrome(String word) {
  // empty strings are palindromes
  if (word.equals("")) return true;
  // remove spaces, punctuation, and capitalization
  word = charsOnly(word);
  // split word at middle
  int mid = word.length()/2;
  String sFront = word.substring(0, mid+1);
  String sBack = word.substring(mid);
  if (word.length()%2 == 0) { // even number of chars
    sFront = word.substring(0, mid);
    sBack = word.substring(mid);
  }
  else { // odd number of chars
    sFront = word.substring(0, mid+1);
    sBack = word.substring(mid);
  }
  // reverse one of the strings
  sBack = reverse(sBack);
  // compare the two strings, return true if both strings are equal
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
public String charsOnly(String word) {
  String s = new String();
  for (int i = 0; i < word.length(); i++) {
    if (Character.isLetter(word.charAt(i))) s += word.charAt(i);
  }
  return s.toLowerCase();
}