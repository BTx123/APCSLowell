public final static String e = "2.718281828459045235360287471352662497757247093699959574966967627724076630353547594571382178525166427427466391932003059";  
public void setup() {
   boolean isFound = false;
   int startIndex = 2;
   while (!isFound) {
     if (startIndex+10 > e.length()) {
       println("Not found!");
       break;
     }
     String digits = e.substring(startIndex, startIndex+10);
     println(digits);
     double dNum = Double.parseDouble(digits);
     if (isPrime(dNum)) {
       isFound = true;
       System.out.println(dNum);
     }
     startIndex++;
   }
   println("done");
}

public void draw() {   
	//not needed for this assignment
}

public boolean isPrime(double dNum) {   
  for (int i = 0; i <= Math.sqrt(dNum); i++) {
    if (dNum % i == 0) return false;
  }
  return true;  
}