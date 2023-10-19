/**
 * Name: Aryaman Srivastava
 * Pledge: I pledge my honor that I have abided by the Stevens Honors System
*/


.text
.global _start

_start:
    ADR X1, target  //Load the address of the target variable into X1
    LDR X1, [X1]    //Load the actual value of X1 into X1
    ADR X2, arr     //Load the address of the array into X2
    ADR X3, length  //Load the address of the length of the array into X3
    LDR X3, [X3]    //Load the actual value of X3 into X3(our upper bound)
    MOV X7, 8       //Move 8 into X7, size of each element so that we can calculate the index from offset.
    MOV X9, 2       //Move 2 into X9, since we are going to be adding and then dividing by 2 for the algorithm
    MOV X6, 0       //Move 0 into X6(our lower bound)
    ADD X4, X3, X6  //Add lower and upper bound and put that into X4
    UDIV X4, X4, X9 //Divide X4(which is the sum of the upper and lower bounds) and put that into X9
    MUL X4, X4, X7  //Calculate the offset by multiplying X4 and X3 and store that into X4
    B Loop          //Go to the loop
Higher:
    MOV X6, X4 //Move our lower bound(X6) to the index of our guess (X4)
    ADD X6, X6, 1   //Add 1 to X6(lower bound) so that we can use it in our calculation of the index of our next guess
    B Loop          
Lower:
    MOV X3, X4      //Move our upper bound(X3) to the index of our guess(X4)
    SUB X3, X3, 1   //subtract 1 from our upper bound(X3) so that we can use it in our calculation of the index of our next guess
    B Loop          
Loop:
    CMP X3, X6 //Compare the lower and upper bounds
    B.LT No //If the upper bound is lower than our lower bound, we didn't find the target
    MOV X10, X3 //move our upper bound into X10 first to start the calculation
    SUB X10, X10, X6 //then subtract our lower bound from our value as the second step in the calculation(distance between upper and lower bound)
    UDIV X10, X10, X9 //then divide X10 by X9(2) to get the value of half the distance between upper and lower bound(what we have to add to lower bound to get the index)
    ADD X10, X6, X10   //Finally add X6(lower bound) into X10 as the final part of our calculation(now we have the index of our next guess)
    MOV X4, X10 //Store the calculated guess index into X4
    MUL X4, X4, X7 //Multiply X4 by X7 and store into X4 to calculate the offset
    LDR X5, [X2, X4]    //Load the value of the next guess into X5
    UDIV X4, X4, X7 //Divide the offset(X4) by X7(element size) to get the index and store into X4
    CMP X1, X5          //compare the target(X1) and the guess(X5)
    B.LT Lower          //if X1(target) is less than the guess, go to the Lower instruction
    B.Eq Yes            //if X1 = X5, we found the target in the array, so go to the yes instruction
    B Higher            //Otherwise, target > the guess, so go to the higher instruction
No:
    ADR X1, msg2        //store the address of the no message in X1
    ADR X6, length_no   //store the address of the length of the no message into X6
    LDR X6, [X6]        //load the actual value of the length of the no message into X6
    B print             //go to the print instruction
Yes:
    ADR X1, msg1        //store the address of the yes message in X1
    ADR X6, length_yes  //store the address of the length of the yes message into X6
    LDR X6, [X6]        //load the actual value of the length of the yes message into X6
    B print             //go to the print instruction
print:
    MOV X2, X6  //move X6, which contains the length of the string to print, into X2
    MOV X0, 1   //Move 1 into X0
    MOV X8, 64  //Move 64 into X8
    SVC 0       //print the program

exit:    MOV X0, 0   //move 0 into X0
    MOV X8, 93  //move 93 into X8
    SVC 0       //end the program




/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */
 .data
    length_yes: .quad 25
    length_no:  .quad 29
