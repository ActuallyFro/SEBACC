#!/bin/bash

# check if $1 is empty, error out
if [ -z "$1" ]; then
  echo "[ERROR] No STRING provided!"
  exit 1
fi

loopCounter=0
#iterate over substring, broken up by comm
outStr=""
for componentCostStr in $(echo $1 | tr "," "\n"); do
  # echo "[DEBUG] Looking at: $componentCostStr"

  # break componentCostStr into key and value
  key=""
  value=""
  isLoopFirstDone="false"
  isLoopSecondDone="false"

  OLDIFS="$IFS"
  IFS=';'
  for keyPair in $componentCostStr; do
    if [ "$isLoopFirstDone" == "false" ]; then
      key="$keyPair"
      isLoopFirstDone="true"
      # echo "[DEBUG] FIRST LOOP!"

    elif [ "$isLoopSecondDone" == "false" ]; then
      value="$keyPair"
      isLoopSecondDone="true"
      # echo "[DEBUG] SECOND LOOP!"
    fi 
  done
  IFS="$OLDIFS"

  #echo "[DEBUG] Key ($key): Value($value)"

  wasComponentProvided="false"

  if [ "$loopCounter" == "0" ]; then
    # echo "[DEBUG] Checking material!"
    compString=""

    if [ "$key" != "c" ]; then
      echo "[ERROR] No component provided!"
      exit
    fi
    
    # wasComponentProvided="true"

    #Component Check:
    compStr=""
    if [ "$value" == "bg" ]; then
      compString="Bulletproof Glass" #FIX

    elif [ "$value" == "ca" ]; then
      compString="Canvas" #FIX

    elif [ "$value" == "co" ]; then
      compString="Computer" #FIX
    fi

    # echo "[DEBUG] Processing Component: $compString"

    # newStr="$outStr $compString,"
    # outStr="$newStr"
    outStr="$outStr $compString,"

  else 
    matStr=""

    if [ "$key" == "co" ]; then
      matStr="Cobalt Ingot" 

    elif [ "$key" == "au" ]; then
      matStr="Gold Ingot" 

    elif [ "$key" == "gravel" ]; then
      matStr="Gravel"

    elif [ "$key" == "fe" ]; then
      matStr="Iron Ingot" 

    elif [ "$key" == "mg" ]; then
      matStr="Magnesium Powder"

    elif [ "$key" == "ni" ]; then
      matStr="Nickel Ingot" 

    elif [ "$key" == "pt" ]; then
      matStr="Platinum Ingot" 

    elif [ "$key" == "si" ]; then
      matStr="Silicon Wafer"

    elif [ "$key" == "ag" ]; then
      matStr="Silver Ingot" 

    elif [ "$key" == "u" ]; then
      matStr="Uranium Ingot"
    else
      echo "[ERROR] Unknown material! ($key)"
      exit
    fi

    # echo "[DEBUG] Processing Material: "$matStr
    outStr="$outStr $matStr, $value,"
  fi


  loopCounter=$((loopCounter + 1))

done

echo "RECCOMEND: "
echo "$outStr"
