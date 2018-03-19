#!/bin/bash

while read line
do
  echo "[bits 64]" > asm.asm
  echo "section .text" >> asm.asm
  echo "_start:" >> asm.asm
  echo -e "\t$line" >> asm.asm
  nasm -f elf64 asm.asm -o ops
  opCode=`objdump -d ops | grep "0:" | sed "s/0://"`
  echo -e "$line \t\t $opCode"
done
