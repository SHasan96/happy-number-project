# HappyNumberProject

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

Sorting was carried out based on the data structure used. The norms were sorted in descending order.

Finally the happy numbers correspoding these norms were printed out (with the maximum number of happy numbers being printed capped at 10).

