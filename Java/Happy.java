import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.TreeMap;

//Happy number project

public class Happy {
	
	public static void main(String[] args){
      try{
          Scanner scan = new Scanner(System.in);
          System.out.print("Enter first argument (a whole number): ");
          int arg1 = scan.nextInt();
          System.out.print("Enter second argument (another whole number): ");
          int arg2 = scan.nextInt();
          scan.close();
          System.out.println("\nFirst Argument: " + arg1);
          System.out.println("Second Argument: " + arg2);
          happyNumbersInRange(arg1, arg2);
      }
      catch (Exception e){ 
          System.out.println("Error! Please make sure your inputs are valid.");
      }
	}
	
//Function to determine if a number is happy (code taken from "rosetta.org")	
	public static boolean happy(int number){
	      int m = 0;
	      int digit = 0;
	      HashSet<Integer> cycle = new HashSet<Integer>();
	      while(number != 1 && cycle.add(number)){
	          m = 0;
	          while(number > 0){
	              digit = number % 10;
	              m += digit*digit;
	              number /= 10;
	          }
	          number = m;
	      }
	      return number == 1;
	  }

//Function to find all the happy numbers between the two arguments (inclusive)
	public static void happyNumbersInRange (int n2, int n1) {
		//Check if difference between two arguments is zero, also to reject negative integers
		if (n2==n1 || n2<0 || n1<0) {
			System.out.println("Invalid range and/or arguments!");
		    return;
		}
		
		//Reverse the arguments if necessary to always get a positive difference
		if (n2<n1) {
			int tmp = n1;
			n1 = n2;
			n2 = tmp;
		} 
		
		//This TreeMap will store norm and happy numbers as key-value pairs in descending order of keys
		Map<Double, Integer> map = new TreeMap<Double, Integer>(Collections.reverseOrder());
		
        for(int num = n1, count = 0; count<=(n2-n1); count++, num++){
        	if(happy(num)) 
        	   map.put(getNorm(num), num);    
        }
        
        if (map.isEmpty())
        	System.out.println("NOBODY'S HAPPY!");
        
        else {
        	Iterator<Entry<Double, Integer>> itr = map.entrySet().iterator();
        	int i = 1;
        	while (itr.hasNext() && i<=10) {
                Entry<Double, Integer> entry = itr.next();
        		    System.out.println(entry.getValue());
        		    i++;
        	 }
        }
	}

//Function to find the norm of a happy number
	public static double getNorm (int hnum) {
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
