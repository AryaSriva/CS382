/**
 * Name: Aryaman Srivastava
 * Pledge: I pledge my honor that I have abided by the Stevens Honors System
*/

.text
.global _start

_start:
    ADR X1, src_str     //Load the address of the source string into X1
    ADR X2, dst_str     //Load the address of the destination string into X2
    MOV X3, 0           //Store 0 into X3, so that we can make X3 our counter/offest register

Loop: LDRB W4, [X1, X3] //Load a byte(one char) from X1 into W4 at each iteration of the loop
    STRB W4, [X2, X3]    //Store the char into register X2 at offset. 
    ADD X3, X3, 1       //Increment the counter(X3) by 1
    CBNZ W4, Loop        //If X4 is not zero, there are still characters to be copied

print: ADR X1, dst_str     //Load the address of the destination string into X1
    MOV X2, X3        //Load the counter(length of the string) into X2
    MOV X0, 1           //Store the value of 1 into X0
    MOV X8, 64          //Store 64(call number for printing) into X8
    SVC 0               //System call to print

exit: MOV X0, 0           //Store the value of 0 into X0
    MOV X8, 93          //Store the value of 93(call number for terminating program) into X8
    SVC 0               //System call to end the program
/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */