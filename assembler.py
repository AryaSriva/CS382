# Aryaman Srivastava Collin Shen
# I pledge my honor that I have abided by the Stevens Honors System
# CS382 Project 2
# Author: Aryaman Srivastava

import sys

def binToInt(num, digit, numDigits):
    #turns a binary number into an integer
    if (digit == 0):
        return int(num[digit])*pow(2,numDigits - digit)
    else:
        return int(num[digit])*pow(2,numDigits-digit) + binToInt(num, digit - 1, numDigits)

def fix_length(string, length, signed):
    #prepends or removes leading 0s so the string is the desired length as well as perform signed extension if the given string is a signed binary int
    if (len(string) != length):
        if (len(string) > length):
            return string[len(string)-length:]
        else:
            prepend = length - len(string)
            for i in range(0, prepend):
                if (signed):
                    string = string[0] + string
                else:
                    string = '0' + string
            return string
    else:
        return string
        
file = open(str(sys.argv[1]), "r") 
instructions = file.readlines()
imageFile = open("image", "w")
convertedInstructions = "v3.0 hex words addressed\n00: "
opcodes = {"addn":320, "ldr": 834, "str": 1088, "addr":256, "mov":320, "cmp":12, "b.eq":65, "b":192, "mul": 272}
labels = {}
usesIntermediates = ["addn", "ldr", "str", "mov"]
branching = ["b.eq", "b"]
lineNumber = 0
j = 0
for line in instructions:
    lst = line.split(' ')
    if (":" in lst[0]):
        i = lst[0].find(":", 0, len(lst[0]) - 1)
        if (lst[0][0:i] in labels.keys()):
            raise SyntaxError("Duplicate label" + lst[0][0:i] + " in line " + lineNumber)
        else:
            labels[lst[0][0:i]] = lineNumber
    lineNumber += 1
lineNumber = 0
for line in range(0, len(instructions)):
    lst = instructions[line].split(' ')
    instruction = ""
    if (lst[0].strip(":") in labels):
        lst = lst[1:]
    if (lst[0] in opcodes.keys()):
        if (lst[0] in branching):
            if (lst[1].strip('\n') in labels.keys()):
                opcode = fix_length(bin(opcodes[lst[0]])[2:], 11, False)
                rn = fix_length(bin(0)[2:], 5, False)
                rd = fix_length(bin(0)[2:], 5, False)
                offset = labels[lst[1].strip('\n')] - line
                if (offset >= 0):
                    imm = fix_length(bin(offset)[2:], 11, False)
                else:
                    imm = fix_length("1" + bin(offset+128)[2:], 11, True)
                instruction += fix_length(hex(binToInt(opcode + imm + rn + rd, 31, 31))[2:], 8, False)
            else:
                raise SyntaxError("Label not found")
        elif (lst[0] in usesIntermediates):
            if (lst[0] == "mov"):
                opcode = fix_length(bin(opcodes[lst[0]])[2:], 11, False) 
                rd = fix_length(bin(int(lst[1][1:].strip(',')))[2:], 5, False)
                if (int(lst[2].strip('\n')) < 0):
                    imm = fix_length(bin((int(lst[2].strip('\n'))) + pow(2,11))[2:], 11, True)
                else:
                    imm = fix_length(bin(int(lst[2].strip('\n')))[2:], 11, False)
                rn = fix_length(bin(0)[2:], 5, False)
            else:
                opcode = fix_length(bin(opcodes[lst[0]])[2:], 11, False)
                rd = fix_length(bin(int(lst[1][1:].strip(',')))[2:],5, False)
                rn = fix_length(bin(int(lst[2][1:].strip(',')))[2:],5, False)
                if (int(lst[3].strip('\n')) < 0):
                    imm = fix_length(bin((int(lst[3].strip('\n'))) + pow(2,11))[2:],11, True)
                else:
                    imm = fix_length(bin(int(lst[3].strip('\n')))[2:],11, False)
            instruction += fix_length(hex(binToInt(opcode + imm + rn + rd, 31, 31)), 8, False)
        else:
            if (lst[0] == "cmp"):
                opcode = fix_length(bin(opcodes[lst[0]])[2:], 11, False)
                rd = fix_length(bin(0)[2:],5, False)
                rn = fix_length(bin(int(lst[1][1:].strip(',')))[2:], 5, False)
                rm = fix_length(bin(int(lst[2][1:].strip('\n')))[2:],5, False)
            else:
                opcode = fix_length(bin(opcodes[lst[0]])[2:], 11, False)
                rd = fix_length(bin(int(lst[1][1:].strip(',')))[2:], 5, False)
                rn = fix_length(bin(int(lst[2][1:].strip(',')))[2:],5, False)
                rm = fix_length(bin(int(lst[3][1:].strip('\n')))[2:],5, False)
            imm = fix_length(bin(56)[2:], 6, False)
            instruction += fix_length(hex(binToInt(opcode + imm + rm + rn + rd, 31, 31))[2:], 8, False)
        if j == 8:
            convertedInstructions += '\n'
            j = 0
            lineNumber += 8
            lineNum = hex(lineNumber)[2:]
            convertedInstructions += fix_length(lineNum, 2, False)
            convertedInstructions += ": "
        for i in range(0, len(instruction) - 1, 8):
            convertedInstructions += instruction[i:i+8]
            convertedInstructions += " "
        j += 1
            

imageFile.write(convertedInstructions)
imageFile.close()
file.close()
            
    
    
    
