/*
* Author: Aryaman Srivastava
* Lab 1
* Date: 9/12/23
* CS 382
* Pledge: I pledge my honor that I have abided by the Stevens Honors System
*/
#include <stdio.h>
#include <stdlib.h>

void display(int8_t bit) {
    putchar(bit + 48);
}

void display_32(int32_t num) {
    for (int i = 31; i >= 0; i--) { 
        int bit = (num >> i) & 1;
        display(bit);
    }
}

int main(int argc, char const *argv[]) {
    display_32(382);
    return 0;
}

