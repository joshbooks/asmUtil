#!/bin/bash

echo -n > pushAsm.asm

while read line
do
  echo "[bits 64]" > asm.asm
  echo "section .text" >> asm.asm
  echo "_start:" >> asm.asm
  echo -e "\t$line" >> asm.asm
  nasm -f elf64 asm.asm -o ops
  opCode=`objdump -d ops | awk '/0:/ {print $2" "$3}'`


  echo "$opCode" | awk '{print "push WORD 0x"$2$1}' >> pushAsm.asm
done

  #nasm -f elf64 pushAsm.asm -o pushOps
  #objdump -d pushOps
  cat pushAsm.asm
