# Happy number project
import math


# Function to determine if a number is happy
def happy(num):
    m = 0
    cycle = set()
    while num != 1:
        m = 0
        while num > 0:
            m += (num % 10) * (num % 10)
            num = num // 10
        num = m
        if num in cycle:
            return False
        else:
            cycle.add(num)
    return True


# Function to find the norm of a happy number
def get_norm(num):
    norm = num * num
    m = 0
    while num != 1:
        m = 0
        while num > 0:
            m += (num % 10) * (num % 10)
            num = num // 10
        num = m
        norm += num * num
    norm = math.sqrt(norm)
    return norm


# Function to check input arguments
def checkArgs(n1, n2):
    # Check if difference between two arguments is zero, also to reject negative integers
    if n2 == n1 or n2 < 0 or n1 < 0:
        print("Invalid range and/or arguments!\nExiting...")
        return
    print("\nFirst Argument: " + str(n1))
    print("Second Argument: " + str(n2))
    # Reverse the arguments if necessary to always get a positive difference
    if n2 < n1:
        tmp = n1
        n1 = n2
        n2 = tmp
    happy_numbers_in_range(n1, n2)   
        
        
# Function to find all the happy numbers between the two arguments (inclusive)
def happy_numbers_in_range(n1, n2):
    # Using a dictionary to store norms and happy numbers as key-value pairs respectively
    mydict = dict()
    for i in range(n1, n2 + 1):
        if happy(i):
            mydict[get_norm(i)] = i

    if len(mydict) == 0:
        print("NOBODY'S HAPPY")
    else:
        # Create a list of sorted keys from the dictionary in descending order
        sorted_vals = list(sorted(mydict, reverse=True))
        # Use the sorted list of keys to print respective values from the dictionary
        for x in sorted_vals[0: 10]:
            print(mydict.get(x))


def main():
    try:
      arg1 = int(input("Enter first argument (a whole number): "))
      arg2 = int(input("Enter second argument (another whole number): "))
      checkArgs(arg1, arg2)
    except:
      print("Invalid range and/or arguments!\nExiting...")

if __name__ == "__main__":
    main()