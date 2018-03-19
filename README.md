# asmUtil
This was really cool to make, but I'm not sure if it makes any sense to use this when [radare2](https://github.com/radare/radare2/) exists...

- getOpcodes.sh takes lines of x86-64 nasm assembly and converts them into opcodes, pipe in a file or use it as an interactive assembler.
- execWithOpcodes.sh provides the execWithOpcode function that accepts two bash "lamdas" as arguments, see the location of PLACEHOLDER 1 and PLACEHOLDER 2 in getOpcodes for avaiable variables
- getPushes.sh takes lines of x86-64 nasm assembly and at the end spits out pushAsm.asm containing (hopefully) legal push instructions with the byte order of the opcodes reversed
