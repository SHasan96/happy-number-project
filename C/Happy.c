#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//Happy Number Project

/*
    For the finding the happy numbers in a given range and sorting them in descending orders of their respective norms
    we can use structs to store happy numbers and their norms as pairs. These structs need to be stored in an array so
    that we can sort them. Since C has no built-in dynamic list like structures, one solution would be to define our own
    dynamically allocated array. We can get by using an array with a large array size for our purpose but that is
    memory inefficient. Hence I decided to write more code to make my own dynamically allocated array in the following section.
    We will be using the dynamic array for efficiency.
*/

// Using a struct to store store pairs of happy numbers and their respective norms
// A struct is used since C has no data structure like maps or dictionaries
typedef struct {
    double norm;
    int happyNum;
}NumPair_t;

// This struct is necessary for the dynamic array
typedef struct{
    NumPair_t *array;
    size_t used;
    size_t size;
} Array_t;


//Function prototypes
int happy(int num);
double getNorm(int num);
int getInput();
void checkArgumentsAndProceed(int n1, int n2);
void happyNumbersInRange(int n1, int n2);
int compareNorms(const void *pa, const void *pb);
void initArray(Array_t *a, size_t initialSize);
void insertArray(Array_t *a, NumPair_t elem);
void freeArray(Array_t *a);


int main() {
    int a1, a2;
    printf("\nEnter first argument (a whole number): ");
    a1 = getInput();
    printf("Enter second argument (another whole number): ");
    a2 = getInput();
    checkArgumentsAndProceed(a1, a2);
    return 0;
}

// Get user input and check it
// This is necessary to handle errors regarding input data type because C does not have exception handling like Java, Python, etc
int getInput() {
    int n;
    while(1) {
        if (scanf("%i", &n) != 1){
            fprintf(stderr, "\nInvalid range and/or arguments!\nExiting...\n\n");
            exit(EXIT_FAILURE);
        }
        break;
    }
    return n;
}


// Determine if a number is happy
int happy(int num) {
    int temp = num;
    int sum = 0;
    int rem = 0;
    while(sum!=1 && sum!=4) {
        sum = 0;
        while (temp>0) {
            rem = temp % 10;
            sum += rem*rem;
            temp/=10;
        }
    temp = sum;
    }
    if (sum==1)
        return 1;
    else
        return 0;
}

// Find and return the norm of a happy number
double getNorm(int hn) {
    // Using long variables to deal with large arguments and avoid overflows
    long hnum = hn;
    long sum = hnum*hnum;
    long m = 0;
    while(hnum != 1) {
        m = 0;
        while(hnum > 0){
            m += (hnum % 10)*(hnum % 10);
            hnum /= 10;
        }
    hnum = m;
    sum += hnum*hnum;
    }
    double norm = sqrt(sum);
    return norm;
}

// Check arguments for the range or reverse the parameters if need be
void checkArgumentsAndProceed(int n1, int n2) {
    if (n2==n1 || n2<0 || n1<0) {
        printf("\nInvalid range and/or arguments!\nExiting...\n\n");
	      return;
    }
    printf("\nFirst Argument: %d", n1);
    printf("\nSecond Argument: %d\n", n2);
    if (n2<n1) {
        int tmp = n1;
        n1 = n2;
        n2 = tmp;
    }
    happyNumbersInRange(n1, n2);
}

// Find all the happy numbers between the two arguments (inclusive) and print them in descending order of norms
void happyNumbersInRange(int n1, int n2) {
    // An array of structs for each happy number and norm pair
    Array_t a;
    initArray(&a, 10);
    int i;
    for (i=n1; i<=n2; i++) {
        if (happy(i)){
            NumPair_t numPair;
            numPair.norm = getNorm(i);
            numPair.happyNum = i;
            insertArray(&a, numPair);
        }
    }
    if (a.used>0) {
        // Sort the array of structs in descending order of norms using qsort() function that takes 4 paramemeters
        qsort(a.array, a.used, sizeof(NumPair_t), compareNorms);
        int j;
        for (j=0; j<a.used; j++){
            printf("%d\n", a.array[j].happyNum);
            if (j==9)
                break;  
        }
        printf("\n");
    }
    else {
        printf("NOBODY'S HAPPY!\n\n");
    }
    freeArray(&a);
}

// A comaparator function that will be needed for sorting our array
int compareNorms(const void *pa, const void *pb) {
    const NumPair_t *p1 = pa;
    const NumPair_t *p2 = pb;
    double diff = p1->norm - p2->norm;
    // The returned values determine the order of sorting
    if (diff > 0.0)
        return -1;
    else if (diff < 0.0)
        return 1;
    else
        return 0;
}

/*
  The following section includes the functions related to our dynamic array
  Reference: "https://stackoverflow.com/questions/3536153/c-dynamically-growing-array"
*/

// Initialize the dynamic array
void initArray(Array_t *a, size_t initialSize) {
  a->array = malloc(initialSize * sizeof(NumPair_t));
  if (a->array == NULL) {
    fprintf(stderr, "Allocation failed!\n\n");
    exit(EXIT_FAILURE);
  }
  a->used = 0;
  a->size = initialSize;
}

// Insert elements into the array
void insertArray(Array_t *a, NumPair_t elem) {
  if (a->used == a->size) {
    a->size *= 2;
    a->array = realloc(a->array, a->size * sizeof(NumPair_t));
    if (a->array == NULL) {
        fprintf(stderr, "Allocation failed!\n\n");
        exit(EXIT_FAILURE);
    }
  }
  a->array[a->used++] = elem;
}

// Deallocate memory used by array
void freeArray(Array_t *a) {
  free(a->array);
  a->array = NULL;
  a->used = a->size = 0;
}
