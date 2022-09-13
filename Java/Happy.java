import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.TreeMap;

/**
  A class that takes finds and prints the happy numbers in a given range.
  The happy numbers are printed in descending order of their norms and only a maximum of
  ten numbers in a given range will be printed.
*/
public class Happy {
	
  public static void main(String[] args) {
    try {
      Scanner scan = new Scanner(System.in);
      System.out.print("\nEnter first argument (a whole number): ");
      int arg1 = scan.nextInt();
      System.out.print("Enter second argument (another whole number): ");
      int arg2 = scan.nextInt();
      scan.close();
      checkArgs(arg1, arg2);
    } catch(Exception e) { 
      System.out.println("\nInvalid range and/or arguments!\nExiting...\n");
    }
  }
	
/**
  Determine if a number is happy. 
  Reference: "rosetta.org".
  @param number - is a positive integer.
  @return a boolean based on the determination.
*/
  public static boolean happy(int number) {
    int m = 0;
    HashSet<Integer> cycle = new HashSet<Integer>();
    while(number != 1 && cycle.add(number)) {
      m = 0;
      while(number > 0) {
        m += (number % 10)*(number % 10);
        number /= 10;
      }
      number = m;
    }
    return number == 1;
  }
  
/**
  Check the validity of input arguments.
  Then pass them onto the next function in the correct order.
  @param n1 - first integer argument.
  @param n2 - second integer argument.
*/
  public static void checkArgs(int n1, int n2){
    //Check if difference between two arguments is zero, also to reject negative integers.
    if (n2==n1 || n2<0 || n1<0) {
      System.out.println("\nInvalid range and/or arguments!\nExiting...\n");
      return;
    }
    System.out.println("\nFirst Argument: " + n1);
    System.out.println("Second Argument: " +  n2);
    //Reverse the arguments if necessary to always get a positive difference.
    if (n2<n1) {
      int tmp = n1;
      n1 = n2;
      n2 = tmp;
    }
    happyNumbersInRange(n1, n2);
  }      

/** 
  Find all the happy numbers between the two arguments (inclusive) and print in descending order of norms.
  @param n1 - starting number of the range.
  @param n2 - end of the range.
*/
  public static void happyNumbersInRange (int n1, int n2) {
    //This TreeMap will store norm and happy numbers as key-value pairs in descending order of keys.
    Map<Double, Integer> map = new TreeMap<Double, Integer>(Collections.reverseOrder());

    for(int num = n1; num<=n2; num++){
      if(happy(num)) {
        map.put(getNorm(num), num);    
      }
    }
    if (map.isEmpty()) {
      System.out.println("NOBODY'S HAPPY!\n");
    } else {
      // Use an Iterator to go through the map.
      Iterator<Entry<Double, Integer>> itr = map.entrySet().iterator();
      int i = 1;
      while (itr.hasNext() && i<=10) {
        Entry<Double, Integer> entry = itr.next();
        System.out.println(entry.getValue());
        i++;
      }
      System.out.println();
    }
  }

/**
  Find the norm of a happy number.
  @param hnum - a happy number.
  @return the norm of the happy number passed in.
*/
  public static double getNorm (int hnum){
    double norm = hnum*hnum;
    int m = 0;
    while(hnum != 1){
      m = 0;
      while(hnum > 0){
        m += (hnum % 10)*(hnum % 10);
        hnum /= 10;
      }
      hnum = m;
      norm += hnum*hnum;
    }
    norm = Math.sqrt(norm);
    return norm;
  }
}
