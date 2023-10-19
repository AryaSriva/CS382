/*
Name: Aryaman Srivastava
Pledge: I pledge my honor that I have abided by the Stevens Honors System
Date: 10/3/23
CS 382 Lab 4
*/

.text
.global _start
.extern scanf

_start:
    
    ADR   X0, fmt_str   // Load address of formated string
    ADR   X1, left      // Load &left
    ADR   X2, right     // Load &right
    ADR   X3, target    // Load &target
    BL    scanf         // scanf("%ld %ld %ld", &left, &right, &target);

    ADR   X1, left      // Load &left
    LDR   X1, [X1]      // Store left in X1
    ADR   X2, right     // Load &right
    LDR   X2, [X2]      // Store right in X2
    ADR   X3, target    // Load &target
    LDR   X3, [X3]      // Store target in X3

    CMP X3, X1          //Check X3 - X1(target - left)
    B.LT L1             //If X3 - X1 < 0, go to L1
    CMP X3, X1          //Check X3 - X1(target - left)
    B.EQ L1             //If X3 - X1 = 0, go to L1
    B L2                //Otherwise, go to L2
L1: ADR X1, no          //Load the address of the no message into X1
    ADR X2, len_no      //Load the address of the length of the no message into X2
    LDR X2, [X2]        //Store the length of the no message into X2
    B Print             //Go to Print
L2: CMP X2, X3          //Check X2 - X3(right - target)
    B.LT L1             //If X2 - X3 < 0, go to L1
    CMP X2, X3          //Check X2 - X3(right - target)
    B.EQ L1             //If X2 - X3 = 0, go to L1
    B L3                //otherwise go to L3
L3: ADR X1, yes         //Load the address of the yes message into X1
    ADR X2, len_yes     //Load the address of the length of the yes message into X2
    LDR X2, [X2]        //Store the length of the yes message into X2
    B Print
Print: MOV X0, 1        //Store the destination(for printing its 1) into X0
       MOV X8, 64       //Store the system call number(for printing its 64) into X8
       SVC 0            //Print the message
       B exit           //Go to exit to end the program  


exit:
    MOV   X0, 0        // Pass 0 to exit()
    MOV   X8, 93       // Move syscall number 93 (exit) to X8
    SVC   0            // Invoke syscall

.data
    left:    .quad     0 
    right:   .quad     0
    target:  .quad     0
    fmt_str: .string   "%ld%ld%ld"
    yes:     .string   "Target is in range\n"
    len_yes: .quad     . - yes  // Calculate the length of string yes
    no:      .string   "Target is not in range\n"
    len_no:  .quad     . - no   // Calculate the length of string no
