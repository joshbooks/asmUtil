#!/bin/bash

i=0

while read line
do
  echo "[bits 64]" > asm.asm
  echo "section .text" >> asm.asm
  echo "_start:" >> asm.asm
  echo -e "\t$line" >> asm.asm
  nasm -f elf64 asm.asm -o ops
  disAsm="$(objdump -d ops | sed -n '/0:/,$p')"

  opCode=""
  for dis in ${disAsm[@]}
  do
    if [[ $(echo "$dis" | egrep "^[a-z0-9]{2}$") ]]
    then
      opCode="$opCode $dis"
    fi
    #echo -e "$i: $line :\t\t $dis"
  done

  echo -e "$i: $line :\t\t $opCode"

  i=$[$i+1]
done
