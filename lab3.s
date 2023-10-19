/*
Name: Aryaman Srivastava
CS382 Lab 3
Date: 9/26/23
Pledge: I pledge my honor that I have abided by the Stevens Honors System.
*/

.text
.global _start
_start:
    ADR X1, vec1 //store the address of first value of vec1 into register W1
    LDR X1, [X1] //store the actual value of the first element in vec1 into W1
    ADR X2, vec2 //store the address of first element of vec2 into register W2
    LDR X2, [X2] //store the actual value of first element of vec2 into W2
    MUL X1, X1, X2 //store the result of multiplying the value stored in W1 and W2 into W1
    ADR X3, vec1 //store the address of the second value of vec1 into register W2
    LDR X3, [X3,8] //store the actual value of the second value of vec1 into register W2
    ADR X4, vec2 //store the address of the second value of vec2 into register W3
    LDR X4, [X4, 8] //store the actual value of the second value of vec2 into register W3
    MUL X3, X3, X4 //store the result of multiplying the value stored in W2 and W3 into W2
    ADR X5, vec1 // store the address of the third value of vec1 into register W3
    LDR X5, [X5, 16] //store the actual value of the third value of vec1 into register W3
    ADR X6, vec2 //store the address of the third value of vec2 into register W4
    LDR X6, [X6, 16] //store the actual value of the third value of vec2 into register W4
    MUL X5, X5, X6 //store the result of multiplying the value stored in W3 and W4 into W3
    ADD X1, X1, X3 //store the result of adding the values in W1 and W2 into W1
    ADD X1, X1, X5 //store the result of adding the values in W1 and W3 into W1(the dot product)
    ADR X7, dot //store the address of the variable that will hold the dot product
    STR X1, [X7] //store the dot product(stored in W1) into .data variable dot(memory)
    MOV X0, 0 //store 0 in X0(destination for ending the program)
    MOV X8, 93 //store the system call number to end the program(93) in X8
    SVC 0 //end the program

.data
vec1: .quad 10,20,30 //store vector 1 in .data
vec2: .quad 1,2,3 //store vector 2 in .data
dot: .quad 0 //store a variable to hold the dot product in .data
