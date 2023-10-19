#include <stdio.h>

/*
   Name: Aryaman Srivastava
   Pledge: I pledge my honor that I have abided by the Stevens Honors System
   CS382 HW 1
   Date: 9/16/23
*/

void copy_str(char* src, char* dst) {
    /* 
    Method to copy the characters in one array to another array
     */
    int i = 0;
   L1: if (src[i] != 0) { //loop while src still has characters
       dst[i] = src[i]; //copy the character at the ith element to the array
       i++;
       goto L1;
    }
    dst[i] = 0; //set the last element of the array to 0 to indicate end of the array
   
}

int dot_prod(char* vec_a, char* vec_b, int length, int size_elem) {
    /* 
    Method to calculate the dot product of 2 vectors
    */
    int prod = 0;
    int element_tracker = 0; //initialize iterator variable and variable to store the product
    L1: if (element_tracker < length) { //loop while there are still elements in the vector
        int* a = (int*)(vec_a + size_elem*element_tracker);
        int* b = (int*)(vec_b + size_elem*element_tracker); //initialize pointers to the vector elements
        prod += *a * *b; //dereference the pointers and multiply the values they point to and add that value to the product
        element_tracker++;
        goto L1; 
    }
    return prod; 
}

void sort_nib(int* arr, int length) {
    //Sorting Algorithm: Selection Sort
    // I would like to be considered for bonus points
    char nibs[8*length];
    int i = 0;
    int j = 0;
    L1: if (i < length) { //loop while there are still integers in the array
        int elm = 28;
        L2: if (elm >= 0) {
            nibs[j] = (char)((arr[i] >> elm) & 15); //right shift the bit until it is the LSB and mask all other bits
            j++;
            elm-= 4; //decrease the amount we right shift by 4 each time because each digit is represented by 4 bits
            goto L2;
        } 
        i++;
        goto L1;
    }
    i = 0;
    Loop1: if (i < 8*length - 1) { //perform Selection Sort Algorithm
        int min = i; //set the min index
        int j = i + 1; 
        Loop2: if (j < 8*length) { //loop while there are still bits in the array
            if (nibs[j] < nibs[min]) { //if the element at the index we are at is less than the element at the min index, set the min index to this index
                min = j;
            }
            j++;
            goto Loop2;
        }
        char temp = nibs[min]; //swap the values to shift the smallest element to the left
        nibs[min] = nibs[i];
        nibs[i] = temp;
        i++;
        goto Loop1;
    }
    i = 0;
    j = 0;
    final1: if (i < length) { //copy nibs back into array
        int shift = 28;
        int element = 0;
        final2: if (shift >= 0) {
            element += (int)(nibs[j] << shift); //left shift the bit and and it to the sum
            shift-=4; //decrement the amount we left shift by 4 each time because each digit is represented by 4 bits
            j++;
            goto final2;
        }
        arr[i] = element;
        i++;
        goto final1;
    }
}


int main(int argc, char** argv) {

    /**
     * Task 1
     */

    char str1[] = "382 is the best!";
    char str2[100] = {0};

    copy_str(str1,str2);
    puts(str1);
    puts(str2);

    /**
     * Task 2
     */

    int vec_a[3] = {12, 34, 10};
    int vec_b[3] = {10, 20, 30};
    int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));
    
    printf("%d\n",dot);

    /**
     * Task 3
     */

    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
       sort_nib(arr, 3);
    for(int i = 0; i < 3; i++) {
    //   printf("0x%08x", arr[i]);
    }
    puts(" ");
    return 0;
}
