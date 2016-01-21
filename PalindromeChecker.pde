public void setup() {
  String lines[] = loadStrings("palindromes.txt");
  println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    if(palindrome(lines[i])==true) println(lines[i] + " IS a palidrome.");
    else println(lines[i] + " is NOT a palidrome.");
  }
}
public boolean palindrome(String word) {
  // split word at middle
  // remove all capital letters with .toLowerCase()
  // remove all punctuation by checking whether Character.isLetter(c) == true
  // compare the two strings
  // return true if both strings are equal
  return false;
}

