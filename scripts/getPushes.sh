#!/bin/bash

source scripts/functions.inc

echo -n > opCodesToBePushed
textOnlyNasmTemplate pushAsm.asm

execWithOpcode '  echo "$byte" >> opCodesToBePushed '

tac opCodesToBePushed | paste -d ' ' - - | sed -e 's/\(..\) \(..\)/\tpush WORD 0x\1\2/' -e 's/^\(..\) $/\tpush WORD 0x\100/' >> pushAsm.asm

cat pushAsm.asm | awk "/WORD 0x[8-9a-f].../"'{print;$1="";$2="";gsub("0x", "");;print}'




