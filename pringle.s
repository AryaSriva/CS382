
/*  Name: Aryaman Srivastava
    Pledge: I pledge my honor that I have abided by the Stevens Honors System
 */

.global pringle

pringle:
   SUB SP, SP, 8 //deallocate stack
   STR X30, [SP]
   ADR X19, temp    //temp string
   ADR X20, destination //destination string
   MOV X21, 0 //offset for destination string
   MOV X22, 0 //offset for parameter string
   MOV X23, X0  //parameter string
   MOV X24, 0 //character count
   MOV X25, 0 //counter for which specifier we are on
   MOV X26, 8 //offset for stack if we have more than three arrays
   B OriginalFlavor
OriginalFlavor:
    LDRB W8, [X23, X22] //load first byte and check if it is null terminator
    CBZ W8, exit
    ADD X22, X22, 1
    LDRB W9, [X23, X22] //load second byte then store first and second byte into temp
    SUB X22, X22, 1
    STRB W8, [X19, 0]
    STRB W9, [X19, 1]
    MOV X0, X19
    BL count_specs //count number of specifiers in temp
    CMP X0, 1
    B.EQ SourCreamAndOnion //if its one, we have to add an array
    B Ranch //otherwise we just add the character
SourCreamAndOnion:
    ADD X25, X25, 1 //increment the specifier counter
    CMP X25, 1 //check what number specifier we are on so we know what parameter to access
    B.EQ Barbeque
    CMP X25, 2
    B.EQ CheddarCheese
    CMP X25, 3
    B.EQ SaltAndVinegar
    CMP X25, 4
    B.EQ HotHoney
    B EnchiladaAdobada
EverythingBagel:
    BL concat_array
    MOV X8, 0  //offset for converted array
LasMerasMerasHabaneras:
    LDRB W9, [X0, X8] //load byte and check if it is null terminator
    CBZ W9, FrenchFriesAndKetchup
    STRB W9, [X20, X21] //if it isn't store the byte into destination
    ADD X21, X21, 1 //increment counter and offsets
    ADD X8, X8, 1
    ADD X24, X24, 1
    B LasMerasMerasHabaneras
FrenchFriesAndKetchup:
    ADD X22, X22, 2 //increment offset
    B OriginalFlavor
Barbeque: //case when we need to access the 1st parameter array
    MOV X0, X1
    MOV X1, X2 
    B EverythingBagel
CheddarCheese: //case when we need to access the 2nd parameter array
    MOV X0, X3 
    MOV X1, X4 
    B EverythingBagel
SaltAndVinegar: //case when we need to access the 3rd parameter array
    MOV X0, X5
    MOV X1, X6
    B EverythingBagel
HotHoney: //case when we need to access the 4th parameter array
    MOV X0, X7
    LDR X1, [SP, X26]
    ADD X26, X26, 8
    B EverythingBagel
EnchiladaAdobada: //case when we need to access a parameter array stored on the stack
    LDR X0, [SP, X26]
    ADD X26, X26, 8
    LDR X1, [SP, X26]
    ADD X26, X26, 8
    B EverythingBagel 
Ranch:
    LDRB W8, [X23, X22] //load the character and store into destination 
    STRB W8, [X20, X21]
    ADD X22, X22, 1 //increment offsets
    ADD X21, X21, 1
    ADD X24, X24, 1 //increment counter
    B OriginalFlavor
exit:
   STRB WZR, [X20, X21] //store null terminator
   MOV X0, 1 //print out the destination string
   MOV X1, X20
   MOV X2, X24
   MOV X8, 64 
   SVC 0 
   LDR X30, [SP]
   ADD SP, SP, 8 //reallocate stack and return the number of characters printed
   MOV X0, X24
   RET
/*
    Declare .data here if you need.
*/
.data
    temp: .fill 1024, 1, 0
    destination: .fill 1024, 1, 0
