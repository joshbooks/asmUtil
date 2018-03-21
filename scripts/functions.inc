#!/bin/bash

# accepts up to two arguments, the format of both is a bash snippet
# that will be substituted into getOpcodes in a position well placed
# to take advantage of a populated variable, for the first argument 
# the variable I had in mind was $byte, which will take the value of
# each byte of each opcode generated from the assembly instructions
# read from stdin
# The variable I had in mind for the second bash snippet was $opCode
# which will take the value of each opcode (in the form of space 
# separated hexadecimal bytes) generated from the assembly instructions
# read from stdin
function execWithOpcode
{
  echo > tempScript.sh

  while read -r line
  do
    #read trashes the leading spaces
    if [[ "$line" == "#PLACEHOLDER 1" ]]
    then
      echo "$1" >> tempScript.sh
    elif [[ "$line" == "#PLACEHOLDER 2" ]]
    then
      echo "$2" >> tempScript.sh
    else
      echo "$line" >> tempScript.sh
    fi
  done < scripts/getOpcodes.sh

  source tempScript.sh
  rm tempScript.sh
}

# make a file that contains the bare minimum to start turning
# instructions into binary
function textOnlyNasmTemplate()
{
  echo "[bits 64]" > $1
  echo "section .text" >> $1
  echo "_start:" >> $1
}

