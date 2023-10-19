/*
Name: Aryaman Srivastava
CS382 Lab 2
Date: 9/19/23
Pledge: I pledge my honor that I have abided by the Stevens Honors System.
*/

.text
.global _start

_start:
    MOV X0, 1 /*store the destination(for printing its 1), in X0*/
    ADR X1, msg /*store the address of the message in X1*/
    MOV X2, length /*store the length of the message in X2*/
    MOV X8, 64 /*store the system call number, 64(printing) in X8*/
    SVC 0 /*print the string*/
    MOV X0, 0 /*instructions to end the program*/
    MOV X8, 93
    SVC 0

.data
msg: .string "Hello World!\n" /*store the message in .data*/
length: .quad 13 /*store the length of the message in .data*/
