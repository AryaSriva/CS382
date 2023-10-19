/**
 * Name: Aryaman Srivastava
 * Pledge: I pledge my honor that I have abided by the Stevens Honors System
 */

.text
.global _start

_start:
    ADR X0, numstr     //Load the address of numstr into X0
    MOV X1, 10         //Move 10 into X1(what we want to multiply/divide by)
    MOV X2, 0          //Move 1 into X2(the offset)
    MOV X3, 1          //Move 1 into X3(keeps track of what digit we are on)
    MOV X5, 0          //Move 0 into X5(our sum variable)

Loop: LDRB W4, [X0, X2]     //Load the character at offset into W4
      CBZ W4, Reset               //Check if the byte we loaded is the null terminator, if it is, exit the loop
      MUL X3, X3, X1        //Multiply the digit tracker(X3) by 10(X1) to increment what place in the number we are on(ten's place, hundred's place etc)
      ADD X2, X2, 1         //increment the offset(X2) by 1
      B Loop
Reset:
    UDIV X3, X3, X1      //divide X3 by 10 because we start our placing of each digit at 10^0 and not 10^1
    MOV X2, 0            //reset our offset
LoopAgain: LDRB W4, [X0, X2] //Load the character at offset into W4
           CBZ W4, Store     //check if the byte we loaded is the null terminator, if it is, exit the loop
           SUB W4, W4, 48     //Subtract 48 from X4 to get the actual number of the byte we loaded(ascii conversion)
           MUL X6, X4, X3   //multiply the byte we loaded by the place in the number we are on
           ADD X5, X5, X6   //add X6(the value we calculated in its appropriate place) with X5(our sum)
           UDIV X3, X3, X1  //Divide X3 by 10 because we are going down in the digits
           ADD X2, X2, 1    //increment our offset
           B LoopAgain
Store: ADR X1, number       //Store the address of the number variable into X1
       STR X5, [X1]         //Store X5(the sum) into memory(address of number variable in X1)
/* Do not change any part of the following code */
exit:
    MOV  X0, 1
    ADR  X1, number
    MOV  X2, 8
    MOV  X8, 64
    SVC  0
    MOV  X0, 0
    MOV  X8, 93
    SVC  0
    /* End of the code. */


/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */






