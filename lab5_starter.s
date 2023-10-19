/*
    Name: Aryaman Srivastava
    Pledge: I pledge my honor that I have abided by the Stevens Honors System
    Date: 10/17/23
    CS382 Lab 5
 */


.text
.global _start
.extern printf


/* char _uppercase(char lower) */
_uppercase:
    /* Your code here 
    
        You must follow calling convention,
        and make this a procedure.

    */
    SUB SP, SP, 8 //subtract 8(the frame size) from stack pointer
    STR X30, [SP] //store X30 into stack pointer

    SUB W2, W2, 32  //subtract 32 from W2 to get the uppercase value

    LDR X30, [SP]   //Load stack pointer into X30
    ADD SP, SP, 8   //add 8(frame size) to stack pointer
    RET //return


/* int _toupper(char* string) */
_toupper:
    /* Your code here 

        You must call _uppercase() for every character in string.
        Both loop and recursion are good.

        You must follow calling convention,
        and make this a procedure.

    */
    SUB SP, SP, 8 //subtract 8(the frame size) from stack pointer
    STR X30, [SP] //store X30 into stack pointer
    MOV X1, 0      //move 0 into X1(our iterator)
    LDRB W2, [X0, X1]   //Load the first character into W2

Loop: BL _uppercase //call uppercase
    STRB W2, [X0, X1]   //store the new character(in W2) to the memory at X0 with offset X1
    ADD X1, X1, 1       //increment offset by 1
    LDRB W2, [X0, X1]   //load the character in X0 at offset X1 to W2
    CBNZ W2, Loop       //if W2 is not zero, continue looping

    MOV X0, X1          //Store X1(the number of characters converted) into X0(return value)
    LDR X30, [SP]       //Load stack pointer into X30
    ADD SP, SP, 8       //add 8(frame size) to stack pointer
    RET                 //return

_start:

    /* You code here:

        1. Call _toupper() to convert str;
        2. Call printf() to print outstr to show the result.
    
    */
    ADR X0, str     //store the address of the string into X0
    BL _toupper     //call lowercase
    MOV X1, X0    //store the number of characters we converted into X1.
    ADR X0, outstr     //store the address of the string into X0
    ADR X2, str         //store the address of the string into X2
    BL printf           //call printf
    MOV  X0, 0          //Move 0 into X0
    MOV  X8, 93         //Move 93 into X8
    SVC  0              //end the program


.data
str:    .string   "helloworld"
outstr: .string   "Converted %ld characters: %s\n"
