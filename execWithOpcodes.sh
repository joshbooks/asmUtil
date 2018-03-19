#!/bin/bash

function execWithOpcode
{
  echo "Now in execWithOpcode"
  echo > tempScript.sh

  while read -r line
  do
    #read trashes the spaces
    if [[ "$line" == "#PLACEHOLDER 1" ]]
    then
      echo "$1" >> tempScript.sh
    elif [[ "$line" == "#PLACEHOLDER 2" ]]
    then
      echo "$2" >> tempScript.sh
    else
      echo "$line" >> tempScript.sh
    fi
  done < getOpcodes.sh

  source tempScript.sh
}
