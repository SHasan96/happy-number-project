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

# C\#
To compile:
```
mcs Happy.cs
```
A Happy.exe file is created.
To run:
```
mono Happy.exe
```

# C
To compile:
```
gcc Happy.c -o Happy -lm
```
An executable with a the name "Happy" is created. The -lm portion must be used to link the math library when building the executable.
To run:
```
./Happy
```
or simply:
```
Happy
```

# Fortran
To compile:
```
gfortran Happy.f95 -o Happy
```
An executable with a the name "Happy" is created.
To run:
```
./Happy
```
or simply:
```
Happy
```

