
/*  
    Name: Aryaman Srivastava
    Pledge: I pledge my honor that I have abided by the Stevens Honors System
 */

.global itoascii

itoascii:
      SUB SP, SP, 56 //deallocate stack and save callee-saved registers(used by concat_array)
      STR X30, [SP]
      STR X19, [SP, 8]
      STR X20, [SP, 16]
      STR X21, [SP, 24]
      STR X22, [SP, 32]
      STR X23, [SP, 40]
      STR X24, [SP, 48]
      MOV X8, 0 //offset
      MOV X9, 1 //digit/place tracker
      MOV X10, 10 //multiplier/divider to get the place of the digit
      MOV X11, X0  //temp variable storing parameter value
      ADR X12, buffer    //address of destination string
      STR XZR, [X12]      //Clear our buffer string so that we can store the number into it 
      CBZ X0, endpt2  //If the number is already 0, just store the 0 into memory
Loop: 
      CBZ X11, Reset   //Loop while the number is not 0
      MUL X9, X9, X10  //Increment our digit tracker
      UDIV X11, X11, X10 //divide our number by 10
      B Loop
Reset: 
      UDIV X9, X9, X10  //Divide our digit tracker by 10
      MOV X11, X0       //Reset our temp variable
LoopAgain: 
      CBZ X9, end   //Loop until we've captured all the digits
      UDIV X11, X11, X9   //Divide the temp by the place we are on to get the digit
      ADD X11, X11, 48    //convert the digit into an ascii number
      STRB W11, [X12, X8] //store the digit into the destination string 
      ADD X8, X8, 1     //Increment our offset
      SUB X11, X11, 48    //convert the digit back to decimal
      MUL X11, X11, X9    //put our digit back into its original place so that we can subtract it from the number
      UDIV X9, X9, X10   //Divide our digit tracker by 10
      SUB X0, X0, X11   //subtract the digit in its place from the number so we can move on to the next digit
      MOV X11, X0        //store the number back into the temp 
      B LoopAgain
end:      
      MOV X0, X12 //store the address of destination string into X0(return value)
      STRB WZR, [X0, X8] //store the null terminator into destination string 
      B return
endpt2:
      ADD X11, X11, 48    //convert the number(0) into ascii
      ADR X0, buffer    //store the address of destination string into X0(return value)
      STRB W11, [X0, 0] //store the converted ascii string into destination string at offset 0(only one digit)
      STRB WZR, [X0, 1]  //store the null terminator into destination string
      B return
return:
      LDR X30, [SP] //reallocate stack and restore callee-saved registers(used by concat_array) then return the buffer string
      LDR X19, [SP, 8]
      LDR X20, [SP, 16]
      LDR X21, [SP, 24]
      LDR X22, [SP, 32]
      LDR X23, [SP, 40]
      LDR X24, [SP, 48]
      ADD SP, SP, 56
      RET
.data
    /* Put the converted string into buffer,
       and return the address of buffer */
    buffer: .fill 128, 1, 0


