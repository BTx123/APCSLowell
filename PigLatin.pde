import java.util.*;

public void setup() {
  String[] lines = loadStrings("words.txt");
  System.out.println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    System.out.println(pigLatin(lines[i]));
  }
  System.out.println();
  lines = loadStrings("LowellHymn.txt");
  System.out.println("there are " + lines.length + " lines");
  for (int i = 0; i < lines.length; i++) {
    String[] arr = lines[i].split(" ");
    //println(arr);
    for (int j = 0; j < arr.length; j++) {
      if (arr[j].equals("")) break; // deal with empty line in file
      String sPig = pigLatin(arr[j]); // converted pig latin word
      //if (j == 0) System.out.print(sPig.substring(0, 1).toUpperCase() + sPig.substring(1).toLowerCase() + " "); // capitalize first word
      System.out.print(sPig + " ");
    }
    System.out.println();
  }
}
// Return index of first vowel of sWord
public int findFirstVowel(String sWord) {
  char[] arr = { 'a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U' };
  for (int i = 0; i < sWord.length(); i++) {
    for (char c : arr) {
      if (sWord.charAt(i) == c) return i;
    }
  }
  return -1;
}
// Return sWord converted to pig latin
public String pigLatin(String sWord) {
  //precondition: sWord is a valid String of length greater than 0
  //postcondition: returns the pig latin equivalent of sWord
  int firstVowel = findFirstVowel(sWord);
  boolean isCapitalized = Character.isUpperCase(sWord.charAt(0));
  // if string begins with qu, move qu to end + "ay"
  if (sWord.length() > 2 && sWord.substring(0, 2).equals("qu")) sWord = sWord.substring(2) + "quay";
  // if string begins with consonant, move leading consonant(s) to end + "ay"
  else if (firstVowel > 0) sWord = sWord.substring(firstVowel) + sWord.substring(0, firstVowel) + "ay";
  // if string begins with vowels, + "way"
  else if (firstVowel == 0) sWord = sWord + "way";
  // if string has no vowels, + "ay"
  else sWord = sWord + "ay";
  // Capitalization
  if (isCapitalized) sWord = sWord.substring(0, 1).toUpperCase() + sWord.substring(1).toLowerCase();
  // Punctuation
  char[] punct = { ',', '.', '\'' };
  for (int i = 0; i < sWord.length(); i++) {
    for (char p : punct) {
      if (sWord.charAt(i) == p) {
        String sWordFront = sWord.substring(0, i);
        String sWordBack = sWord.substring(i);
        sWord = sWordFront + sWordBack + sWord.charAt(i);
      }
    }
    break;
  }
  return sWord;
}