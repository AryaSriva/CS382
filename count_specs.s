
/*  Name: Aryaman Srivastava
    Pledge: I pledge my honor that I have abided by the Stevens Honors System
 */

.global count_specs

count_specs:
    SUB SP, SP, 72 //deallocate stack and save callee-saved registers(used by pringle)
    STR X30, [SP]
    STR X19, [SP, 8]
    STR X20, [SP, 16]
    STR X21, [SP, 24]
    STR X22, [SP, 32]
    STR X23, [SP, 40]
    STR X24, [SP, 48]
    STR X25, [SP, 56]
    STR X26, [SP, 64]
    MOV X9, 0 //initialize offset variable
    MOV X10, 0 //initialize a counter
    MOV X11, 37 //initialize a variable storing the ascii value for % 
    MOV X12, 97 //initialize a variable storing the ascii value for a
    MOV X13, 1  //initialize another offset variable(to check the character after)
Loop:
    LDRB W14, [X0, X9] //load the character at offset into W12
    CBZ W14, end       //if the character is null terminator, exit the loop
    CMP W11, W14        //check if the character is an %
    B.EQ checkNext   //if it is, check if the next character is an a
notEqual:    
    ADD X9, X9, 1     //increment the offsets
    ADD X13, X13, 1
    B Loop
checkNext:
    LDRB W14, [X0, X13] //load the next character into W14
    CMP W12, W14 //check if the character is an a
    B.EQ increment //if it is, increment the counter
    B notEqual //otherwise return to the loop
increment:
    ADD X10, X10, 1 //increment the counter
    ADD X9, X9, 1 //increment the offsets
    ADD X13,X13,1
    B Loop
end:    
    MOV X0, X10 //store the counter into our return value(X0)
    LDR X30, [SP] //reallocate stack and restore callee-saved registers(used by pringle) 
    LDR X19, [SP, 8]
    LDR X20, [SP, 16]
    LDR X21, [SP, 24]
    LDR X22, [SP, 32]
    LDR X23, [SP, 40]
    LDR X24, [SP, 48]
    LDR X25, [SP, 56]
    LDR X26, [SP, 64]
    ADD SP, SP, 72
    RET



/*
    Declare .data here if you need.
*/
    
