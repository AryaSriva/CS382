
/*  Name: Aryaman Srivastava
    Pledge: I pledge my honor that I abided by the Stevens Honors System
 */

.global concat_array

concat_array:
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
   MOV X19, 32 //variable to store decimal value for whitespace
   MOV X21, X0 //address of the array 
   MOV X22, X1 //length of the array
   ADR X23, concat_array_outstr  //address of the destination string 
   STR XZR, [X23] //clear the destination string
   MOV X24, 0  //offset for array
   MOV X20, 0   //offset for destination string
Loop:
   CBZ X22, end //loop while we still have numbers in the array(length > 0)
   LDR X0, [X21, X24]  //Load the number into X0(parameter for itoascii)
   BL itoascii       //convert the number to an ascii string
   MOV X9, 0   //offset for converted number
LoopInsideLoop:
   LDRB W10, [X0, X9] //Load the character from the converted number 
   CBZ W10, outOfLoop  //if the character is the null terminator, exit the loop
   STRB W10, [X23, X20] //store character into destination string
   ADD X20, X20, 1 //increment offsets
   ADD X9, X9, 1
   B LoopInsideLoop
outOfLoop:
   STRB W19, [X23, X20] //add a white space to the destination string 
   ADD X20, X20, 1 //increment offsets and decrement length
   SUB X22, X22, 1 
   ADD X24, X24, 8 
   B Loop
end:   
   MOV X0, X23 //store the address of the destination string into X0 (our return value)
   STRB WZR, [X0, X20] //store the null terminator in destination string
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

.data
    /* Put the converted string into concat_array_outstrer,
       and return the address of concat_array_outstr */
    concat_array_outstr:  .fill 1024, 1, 0
