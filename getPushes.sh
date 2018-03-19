#!/bin/bash
source ./execWithOpcodes.sh

echo -n > opCodesToBePushed
echo "now in test script"

execWithOpcode '  echo "$byte" >> opCodesToBePushed '

tac opCodesToBePushed | paste -d ' ' - - | sed -e 's/\(..\) \(..\)/push WORD 0x\1\2/' -e 's/^\(..\) $/push BYTE 0x\1/' > pushAsm.asm
