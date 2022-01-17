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

  if [ "$loopCounter" == "0" ]; then
    echo "[DEBUG] Checking material!"
    compString=""

    if [ "$key" != "m" ]; then
      echo "[WARNING] No material provided!"
    fi

    #Material Check:
    if [ "$value" == "bg" ]; then
      echo "[DEBUG] Processing Bulletproof Glass"
      compString="Bulletproof Glass" #FIX

    elif [ "$value" == "ca" ]; then
      echo "[DEBUG] Processing Canvas"
      compString="Canvas" #FIX

    elif [ "$value" == "co" ]; then
      echo "[DEBUG] Processing Computer"
      compString="Computer" #FIX

    fi

    newStr="$outStr $compString,"
    outStr="$newStr"

  else 
    if [ "$key" != "i" ]; then
      echo "[DEBUG] Processing Iron"

    elif [ "$key" != "s" ]; then
      echo "[DEBUG] Processing Silcon"

    fi

  fi


  loopCounter=$((loopCounter + 1))

done

echo "RECCOMEND: "
echo "$outStr"
