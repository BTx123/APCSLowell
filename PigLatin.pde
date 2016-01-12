import java.util.*;

public void setup() {
  String lines[] = loadStrings("words.txt");
  System.out.println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    System.out.println(pigLatin(lines[i]));
  }
}
public void draw() {
}
// Return index of first vowel of sWord
public int findFirstVowel(String sWord) {
  char[] arr = { 'a', 'e', 'i', 'o', 'u' };
  for (int i = 0; i < sWord.length(); i++) {
    for (char c : arr) {
      if (sWord.charAt(i) == c) return i;
    }
  }
  return -1;
}

public String pigLatin(String sWord) {
  //precondition: sWord is a valid String of length greater than 0
  //postcondition: returns the pig latin equivalent of sWord
  // if string begins with qu, move qu to end + "ay"
  // if string begins with consonant, move leading consonant(s) to end + "ay"
  // if string begins with vowels, + "way"
  // if string has no vowels, + "ay"
  int firstVowel = findFirstVowel(sWord);
  if (sWord.substring(0, 2).equals("qu")) return sWord.substring(2) + "quay";
  else if (firstVowel > 0) return sWord.substring(firstVowel) + sWord.substring(0, firstVowel) + "ay";
  else if (firstVowel == 0) return sWord + "way";
  else return sWord + "ay";
}