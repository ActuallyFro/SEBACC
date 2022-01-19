#!/bin/bash

function print-help() {
    echo "Usage: $0 <STRING>"
    echo "Generate a string of semi-colon-keyed, comma separated values from a user specified string"
    echo "Example: $0 \"c;mg,fe;12,ni;5,co;3\""
}

function print-components(){
  echo "200 - 200mm Missile Container"
  echo "25 - 25x184mm NATO Ammo Container"
  echo "556 - 5.56x45mm NATO Magazine"
  echo "bg - Bulletproof Glass"
  echo "ca - Canvas"
  echo "co - Computer"
  echo "cc - Construction Component"
  echo "dc - Detector Components"
  echo "di - Display"
  echo "ex - Explosives"
  echo "gi - Girder"
  echo "gc - Gravity Generator Components"
  echo "ip - Interior Plate"
  echo "lt - Large Steel Tube"
  echo "20 - MR-20 Magazine"
  echo "mc - Medical Components"
  echo "mg - Metal Grid"
  echo "mo - Motor"
  echo "pc - Power Cell"
  echo "rc - Radio-Communication"
  echo "ec - Reactor Components"
  echo "st - Small Steel Tube"
  echo "sc - Solar Cell"
  echo "sp - Steel Plate"
  echo "uc - Superconductor Component"
  echo "tc - Thruster Components"
}

function print-ores(){
  echo "Cobalt Ore"
  echo "Gold Ore"
  echo "Iron Ore"
  echo "Magnesium Ore"
  echo "Nickel Ore"
  echo "Platinum Ore"
  echo "Silicon Ore"
  echo "Silver Ore"
  echo "Gravel"
  echo "Stone"
  echo "Uranium Ore"
}

function print-materials(){
  echo "co - Cobalt Ingot" 
  echo "au - Gold Ingot" 
  echo "gravel - Gravel"
  echo "fe - Iron Ingot" 
  echo "mg - Magnesium Powder"
  echo "ni - Nickel Ingot" 
  echo "pt - Platinum Ingot" 
  echo "si - Silicon Wafer"
  echo "ag - Silver Ingot" 
  echo "u - Uranium Ingot"
}

if [ -z "$1" ]; then
  print-help
  echo ""
  echo "[ERROR] No STRING provided!"
  exit 1
fi

loopCounter=0
outStr=""

for componentCostStr in $(echo $1 | tr "," "\n"); do
  # echo "[DEBUG] Looking at: $componentCostStr"

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
    # echo "[DEBUG] Checking material!"
    compString=""

    if [ "$key" != "c" ]; then
      echo "[ERROR] No component provided!"
      exit
    fi
    
    #Component Check:
    compStr=""
    if [ "$value" == "bg" ]; then
      compString="Bulletproof Glass" #FIX

    elif [ "$value" == "ca" ]; then
      compString="Canvas" #FIX

    elif [ "$value" == "co" ]; then
      compString="Computer" #FIX
    else
      print-components
      echo ""
      echo "[ERROR] UNKNOWN component provided! ($value)"
      exit
    fi

    # echo "[DEBUG] Processing Component: $compString"
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
      print-materials
      echo ""
      echo "[ERROR] UNKNOWN material! ($key)"
      exit
    fi

    # echo "[DEBUG] Processing Material: "$matStr
    outStr="$outStr $matStr, $value,"
  fi


  loopCounter=$((loopCounter + 1))

done

echo "RECCOMEND: "
echo "$outStr"
