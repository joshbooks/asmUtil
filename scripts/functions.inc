#!/bin/bash

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

function textOnlyNasmTemplate()
{
  echo "[bits 64]" > $1
  echo "section .text" >> $1
  echo "_start:" >> $1
}

#lovingly ripped off from https://stackoverflow.com/a/31798763/1981345
function twos()
{
  x=$((16#$1))
  [ "$x" -gt 127 ] && ((x=x-256))
  echo "$x"
}
