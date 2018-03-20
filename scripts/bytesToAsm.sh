#!/bin/bash
# takes lines consisting of one hex byte each
# and turns them into assembly

source scripts/functions.inc

textOnlyNasmTemplate bytes.asm

while read line
do
  echo -e "\tdb 0x$line" >> bytes.asm
done

make bytes

objdump -M "intel" -d bytes | sed -n '/0:/,$p'

