#!/bin/bash

# include some neat little bash functions to help
# get opcodes from code
source scripts/functions.inc

# create/clear file that will hold opcodes
echo -n > opCodesToBePushed

textOnlyNasmTemplate pushAsm.asm

# I'm not sure if this counts as self modifying bash?
# it's defined in functions.inc if you're curious
# this is the bit that reads nasm syntax x86_64
# input and produces the hex representation 
# of the opcodes those lines assemble to
execWithOpcode '  echo "$byte" >> opCodesToBePushed '

tac opCodesToBePushed | \ # print out bytes backwards
paste -d ' ' - - | \ # paste every two lines into one line with two columns
sed -e 's/\(..\) \(..\)/\tpush WORD 0x\1\2/' -e 's/^\(..\) $/\tpush WORD 0x\190/' >> pushAsm.asm
# that last line turns the bytes into word push ops
# and if there's only a byte we push a word by 
# padding with a NOP

# adds a little stank on the end to make the asm program 
# actually execute if it's compiled and run
cat gadgets/pushEpilogue.asm >> pushAsm.asm
