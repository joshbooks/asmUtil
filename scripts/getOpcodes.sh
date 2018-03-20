#!/bin/bash

source scripts/functions.inc

i=0

while read line
do
  textOnlyNasmTemplate asm.asm
  echo -e "\t$line" >> asm.asm
  nasm -f elf64 asm.asm -o ops
  disAsm="$(objdump -d ops | sed -n '/0:/,$p')"

  opCode=""
  for byte in ${disAsm[@]}
  do
    if [[ $(echo "$byte" | egrep "^[a-f0-9]{2}$") ]]
    then
      opCode="$opCode $byte"
      #PLACEHOLDER 1
    fi
  done

  echo -e "$i: $line :\t\t $opCode"

  #PLACEHOLDER 2

  i=$[$i+1]
done
