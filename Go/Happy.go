package main

import (
  "fmt"
  "math"
  "sort"
  "bufio"
  "os"
  "strconv"
  "strings"
  "errors"
)

func main() {
  getArgs(); // This is the function that starts and runs the whole thing.
}


// Gets user inputs for the two arguments and proceed.
// Rejects any non-integer input immediately.
// Proceeds to the next function if arguments are integers.
/* 
  Note for self: 
  The Scan(), Scanf() and Scanln() functions of the fmt package have some inconsistencies.
  Golang does not have exceptions. So it is difficult to handle incorrect input types. 
  The bufio package seemed more convenient to work with and produced the expected results when
  non-integers were inputted.
*/
func getArgs() {
  err := errors.New("\nInvalid range and/or arguments!\nExiting...\n")
  reader := bufio.NewReader(os.Stdin)
  fmt.Print("\nEnter first argument (a whole number): ")
  s1, _ := reader.ReadString('\n')
  s1 = strings.TrimSuffix(s1, "\n")
  a1, err1 := strconv.Atoi(s1)
  if err1 != nil {
    fmt.Println(err)
    return
  }
  fmt.Print("Enter second argument (another whole number): ")
  s2, _ := reader.ReadString('\n')
  s2 = strings.TrimSuffix(s2, "\n")
  a2, err2 := strconv.Atoi(s2)
  if err2 != nil {
    fmt.Println(err)
    return
  }
  checkArgs(a1, a2)
} 


// Determines if a number is happy.
// Returns a boolean based on the determination.
func isHappy(num int) bool {
  m := 0
  sums := make(map[int]int)
  for num != 1 {
    m = 0
    for num > 0 {
      m += (num % 10) * (num % 10)
      num /= 10
    }
    num = m
    if _, ok := sums[num]; ok {
      return false
    } else {
      sums[num] = 0
    }
  } 
  return true
}


// Finds and returns the norm of a happy number.
func getNorm(num int) float64 {
  sum := num * num
  m := 0
  for num != 1 {
    m = 0
    for num > 0 {
      m += (num % 10) * (num % 10)
      num /= 10
    }
    num = m
    sum += num * num
  }
  var norm float64 = math.Sqrt(float64(sum))
  return norm
}


// Checks arguments before passing them onto the next function.
func checkArgs(n1 int, n2 int) {
  err := errors.New("\nInvalid range and/or arguments!\nExiting...\n")
  if n2==n1 || n2<0 || n1<0 {
    fmt.Println(err)
    return
  }
  fmt.Println("\nFirst Argument: ", n1);
  fmt.Println("Second Argument: ", n2);
  if n2<n1 {
    tmp := n1;
    n1 = n2;
    n2 = tmp;
  }
  happyNumbersInRange(n1, n2);
}


// Finds all the happy numbers between the two arguments (inclusive). 
// Prints them in descending order of norms.
func happyNumbersInRange(n1 int, n2 int) {
  // Using a map to store norm-happy number as key-value pairs
  numMap := make(map[float64]int)
	for num := n1; num <= n2; num++ {
		if isHappy(num) {
			numMap[getNorm(num)] = num
		}
	}
  if len(numMap) == 0 {
    fmt.Println("NOBODY'S HAPPY!")
  } else {
    // Make a slice of the keys (which are the norms).
    var keys []float64
    for k := range numMap {
			keys = append(keys, k)
		}
    // Sort the slice in descending order.
    sort.Sort(sort.Reverse(sort.Float64Slice(keys)))
    if len(keys) > 10 {
      // Slice the slice to give it a length of 10.
      keys = keys[:10]
    }
    for _, k := range keys {
      fmt.Println(numMap[k])
    }
  }
  fmt.Println("");   
}
