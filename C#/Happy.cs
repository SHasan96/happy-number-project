using System.Collections.Generic;
using System.Linq;
using System;

/*
  A program that takes finds and prints the happy numbers in a given range.
  The happy numbers are printed in descending order of their norms and only a maximum of
  ten numbers in a given range will be printed.
*/

// The coding is very similar to Java. 
  
class Program {

    private static void Main(string[] args) {
        try {
            Console.Write("\nEnter first argument (a whole number): ");
            int a1 = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter second argument (another whole number): ");
            int a2 = Convert.ToInt32(Console.ReadLine());
            checkArgs(a1, a2);
        } catch {
            Console.WriteLine("\nInvalid range and/or arguments!\nExiting...\n");
        }       
    }

    /* 
      Determine if a number is happy.
      Return a boolean based on the determination.
    */
    static bool isHappy(int number) {
        int m = 0;
        HashSet<int> cycle = new HashSet<int>();
        while (number != 1 && cycle.Add(number)) {
            m = 0;
            while (number > 0) {
                m += (number%10) * (number%10);
                number /= 10;
            }
            number = m;
        }
        return number == 1;
    }
  
    /* 
      Check the validity of input arguments. 
      Then pass them onto the next function in the correct order.
    */
    static void checkArgs(int n1, int n2) {
        //Check if difference between two arguments is zero, also to reject negative integers.
        if (n2 == n1 || n2 < 0 || n1 < 0) {
            Console.WriteLine("\nInvalid range and/or arguments!\nExiting...\n");
            return;
        }
        Console.WriteLine("\nFirst Argument: " + n1);
        Console.WriteLine("Second Argument: " + n2);
        //Reverse the arguments if necessary to always get a positive difference.
        if (n2 < n1) {
            int tmp = n1;
            n1 = n2;
            n2 = tmp;
        }
        happyNumbersInRange(n1, n2);
    }

    /*
      Find all the happy numbers between the two arguments (inclusive).
      Then print them in descending order of norms.
    */
    static void happyNumbersInRange(int n1, int n2) {
        // A dictionary will be used to store happy numbers and their respective norms as key-value pairs.
        // The availability of sorted dictionaries make things simpler.
        var dict = new SortedDictionary<double, int>();
        
        for (int num = n1; num<=n2; num++) {
            if (isHappy(num)) {
                dict.Add(getNorm(num), num);
            }
        }
        if (dict.Count == 0) {
            Console.WriteLine("NOBODY'S HAPPY!");
        } else {
            int i = 0;
            foreach (var x in dict.Reverse()) {
                Console.WriteLine(x.Value);
                i++;
                if (i > 9) {
                    break;
                }
            }
        }
        Console.WriteLine();
    }

    /* 
      Find and return the norm of a happy number.
    */
    static double getNorm(int hn) {
        long hnum = hn;
        long sum = hnum*hnum;
        long m = 0;
        while (hnum != 1) {
            m = 0;
            while (hnum > 0) {
                m += (hnum % 10) * (hnum % 10);
                hnum /= 10;
            }
            hnum = m;
            sum += hnum * hnum;
        }
        double norm = Math.Sqrt(sum);
        return norm;
    }
}

    
