/*
Name: Aryaman Srivastava
Pledge: I pledge my honor that I have abided by the Stevens Honors System
Date: 10/3/23
CS 382 Lab 4
*/

.text
.global _start

_start:
    ADR X1, side_a      //Load &side_a into X1
    LDR X1, [X1]        //Store the value of side_a into X1
    ADR X2, side_b      //Load &side_b into X2
    LDR X2, [X2]        //Store the value of side_b into X2
    ADR X3, side_c      //Load &side_c into X3
    LDR X3, [X3]        //Store the value of side_c into X3
    MUL X1, X1, X1      //Multiply the value stored in X1 by itself and store the product into X1
    MUL X2, X2, X2      //Multiply the value stored in X2 by itself and store the product into X2
    ADD X1, X1, X2      //Add the values stored in X1 and X2 and store the summation into X1
    MUL X3, X3, X3      //Multiply the value stored in X3 by itself and store the product into X3
    SUB X3, X3, X1      //Subtract X1 from X3 and store the result in X3
    MOV X0, 1           //Store the destination(for printing its 1) into X0
    MOV X8, 64          //Store the system call number for printing(64) into X8
    CBZ X3, L1          //If X3 is zero, meaning the triangle is a right triangle, go to L1
    B L2                //If X3 is not zero, meaning the triangle is not a right triangle, go to L2
L1: ADR X1, yes         //Load the address of the message stating it is a right triangle into X1
    ADR X2, len_yes     //Load the address of the length of the yes message into X2
    LDR X2, [X2]        //Store the length of the yes message into X2
    SVC 0               //Print the message
    B End               //Go to End
L2: ADR X1, no          //Load the address of the message stating it is not a right triangle into X1
    ADR X2, len_no      //Load the address of the length of the no message into X2
    LDR X2, [X2]        //Store the length of the no message into X2
    SVC 0               //Print the message
End: MOV X0, 0          //Store 0 into X0
    MOV X8, 93          //Store the system call number for ending the program(93) into X8
    SVC 0               //End the program




.data
side_a: .quad 3 //store the value of side_a into memory with a variable in .data
side_b: .quad 4 //store the value of side_b into memory with a variable in .data
side_c: .quad 5 //store the value of side_c into memory with a variable in .data
yes: .string "It is a right triangle.\n" //store the yes message into a variable in .data
len_yes: .quad . - yes // Calculate the length of string yes and store it into a variable in .data
no: .string "It is not a right triangle.\n" //store the no message into a variable in .data
len_no: .quad . - no // Calculate the length of string no and store it into a variable in .data
