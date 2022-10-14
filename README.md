# Happy Number Project

In this project we display the ten (or less) happy numbers within a given range (inclusive) in descending order of their norms.
This was done is 8 languages.


## The program flow

The program starts by asking the user to input two integers. These integers will be the start and end values for our range (inclusive). 

All non-integer inputs will be immediately rejected. Negative integers or same arguments cannot be evaluated into a valid range, so they will also be checked
and rejected.

Once the integers are valid we use a loop starting from the smaller to the larger integer. We determine if a number within this range is happy inside the loop.

For each number determined as a happy number, the norm of that number will also be calculated. Then we store the happy number along with its norm into a data
structure that can hold data as key-value pairs, where the norm is preferrably the key. For languages that do not have such structures, we stored the happy number
and its norm in a structure (struct in C, and structure in Fortran), then build and array of these structures.

Sorting was carried out based on the data structure and programming language used. The norms were sorted in descending order.

Finally the happy numbers correspoding these norms were printed out (with the maximum number of happy numbers being printed capped at 10). (If no happy number exists
within the range a message stating that is printed.)

## Compilation and execution instructions

The names of all source code files were Happy plus the appropriate file extension.
Listed in order in which they appear in the repo we have the following.

### C\#
To compile:
```
mcs Happy.cs
```
A Happy.exe file is created.\
To run:
```
mono Happy.exe
```

### C
To compile:
```
gcc Happy.c -o Happy -lm
```
An executable with a the name "Happy" is created. 
The -lm portion must be used to link the math library when building the executable.\
To run:
```
./Happy
```
or simply:
```
Happy
```

### Fortran
To compile:
```
gfortran Happy.f95 -o Happy
```
An executable with a the name "Happy" is created.\
To run:
```
./Happy
```
or simply:
```
Happy
```

### Go
To compile and execute:
```
go run Happy.go
```

### Java 
To compile:
```
javac Happy.java
```
A Happy.class file is created.\
To run:
```
java Happy
```

### Lisp
Due to lack of proficiency with the SBCL IDE, the program was written as a script which were made executable.\
Add the following line at the top to invoke the SBCL environment:
```
#!/usr/bin/sbcl --script
```
Make the lisp file executable for the user by:
```
chmod u+x Happy.lisp
```
Then, run using:
```
./Happy.lisp
```
or just
```
Happy.lisp
```

### Perl
Also written as an executable script.\
Add this line at the top:
```
#!/usr/bin/perl
```
Make the perl file executable for the user by:
```
chmod u+x Happy.pl
```
Then, run using:
```
./Happy.pl
```
or just
```
Happy.pl
```
Perl is an interpreted language, which means that your code can be run as-is, without a compilation stage that creates a non-portable executable program.\
Alternatively, this also works:
```
perl Happy.pl
```

### Python
Also written as an executable script.\
Add this line at the top:
```
#!/usr/bin/env python3
```
Make the perl file executable for the user by:
```
chmod u+x Happy.py
```
Then, run using:
```
./Happy.py
```
or just
```
Happy.py
```
Python is an interpreted language.\
Alterantively, we can use:
```
python3 Happy.py
```

## References:
For tutorial sources such as tutorialspoint, w3schools, youtube, geeks-for-geeks, etc. were used.
Some code snippets were used from rossettacode.org, particularly the function to determine if a number is happy.
Some code ideas were taken from stackoverflow, etc, and changed to fit the program.
Code used directly or indirectly from sources were commented with a "Reference:" header.

