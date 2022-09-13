# Happy number project
import math


def happy(n):
    """
    Determines if a number is happy.
    Reference: "rosettacode.org".
    
    :param n: a positive integer
    :return: a boolean based obn the determination
    """
    cycle = set()
    while n != 1:
        n = sum(int(i)**2 for i in str(n))
        if n in cycle:
            return False
        cycle.add(n)
    return True


def get_norm(n):
    """
    Finds the norm of a happy number.
    
    :param n: a happy number
    :return: the norm
    """
    norm = n**2
    while n != 1:
        n = sum(int(i)**2 for i in str(n))
        norm += n**2
    norm = math.sqrt(norm)
    return norm


def check_args(n1, n2):
    """
    Check for validity of the input arguments.
    If the they are positive and the range is valid, pass them on to another function.
    
    :param n1: first integer input given by user
    :param n2: second integer input given by user
    """
    # Check if difference between two arguments is zero, also to reject negative integers
    if n2 == n1 or n2 < 0 or n1 < 0:
        print("\nInvalid range and/or arguments!\nExiting...\n")
        return
    print("\nFirst Argument: " + str(n1))
    print("Second Argument: " + str(n2))
    # Reverse the arguments if necessary to always get a positive difference
    if n2 < n1:
        tmp = n1
        n1 = n2
        n2 = tmp
    happy_numbers_in_range(n1, n2)   
        
        
def happy_numbers_in_range(n1, n2):
    """
    Finds all the happy numbers between the two arguments (inclusive) and prints in descending order of norms.
    
    :param n1: starting number of the range
    :param n2: ending number of the range
    """
    # Using a dictionary to store norms and happy numbers as key-value pairs respectively
    mydict = dict()
    for i in range(n1, n2 + 1):
        if happy(i):
            mydict[get_norm(i)] = i

    if len(mydict) == 0:
        print("NOBODY'S HAPPY!\n")
    else:
        # Create a list of sorted keys from the dictionary in descending order
        sorted_vals = list(sorted(mydict, reverse=True))
        # Use the sorted list of keys to print respective values from the dictionary
        for x in sorted_vals[0: 10]:
            print(mydict.get(x))
        print()


def main():
    try:
      arg1 = int(input("\nEnter first argument (a whole number): "))
      arg2 = int(input("Enter second argument (another whole number): "))
      check_args(arg1, arg2)
    except:
      print("\nInvalid range and/or arguments!\nExiting...\n")

if __name__ == "__main__":
    main()
