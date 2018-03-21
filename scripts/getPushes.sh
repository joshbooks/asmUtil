#!/bin/bash

source scripts/functions.inc

echo -n > opCodesToBePushed
textOnlyNasmTemplate pushAsm.asm

execWithOpcode '  echo "$byte" >> opCodesToBePushed '

tac opCodesToBePushed | paste -d ' ' - - | sed -e 's/\(..\) \(..\)/\tpush WORD 0x\1\2/' -e 's/^\(..\) $/\tpush WORD 0x\190/' >> pushAsm.asm

cat gadgets/pushEpilogue.asm >> pushAsm.asm
