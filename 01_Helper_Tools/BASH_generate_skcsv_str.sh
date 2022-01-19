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
wantsJSONComponent="false"

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

    if [ "$key" != "c" ] && [ "$key" != "jc" ]; then
      echo "[ERROR] No component provided!"
      exit
    fi
    

    if [ "$key" == "jc" ]; then
      wantsJSONComponent="true"
    fi

    #Component Check:
    compStr=""

    if [ "$wantsJSONComponent" == "false"  ]; then
      if [ "$value" == "200" ]; then
        compString="200mm Missile Container"

      elif [ "$value" == "25" ]; then
        compString="25x184mm NATO Ammo Container"

      elif [ "$value" == "556" ]; then
        compString="5.56x45mm NATO Magazine"

      elif [ "$value" == "bg" ]; then
        compString="Bulletproof Glass"

      elif [ "$value" == "ca" ]; then
        compString="Canvas"

      elif [ "$value" == "co" ]; then
        compString="Computer"

      elif [ "$value" == "cc" ]; then
        compString="Construction Component"

      elif [ "$value" == "dc" ]; then
        compString="Detector Components"

      elif [ "$value" == "di" ]; then
        compString="Display"

      elif [ "$value" == "ex" ]; then
        compString="Explosives"

      elif [ "$value" == "gi" ]; then
        compString="Girder"

      elif [ "$value" == "gc" ]; then
        compString="Gravity Generator Components"

      elif [ "$value" == "ip" ]; then
        compString="Interior Plate"

      elif [ "$value" == "lt" ]; then
        compString="Large Steel Tube"

      elif [ "$value" == "20" ]; then
        compString="MR-20 Magazine"

      elif [ "$value" == "mc" ]; then
        compString="Medical Components"

      elif [ "$value" == "mg" ]; then
        compString="Metal Grid"

      elif [ "$value" == "mo" ]; then
        compString="Motor"

      elif [ "$value" == "pc" ]; then
        compString="Power Cell"

      elif [ "$value" == "rc" ]; then
        compString="Radio-Communication"

      elif [ "$value" == "ec" ]; then
        compString="Reactor Components"

      elif [ "$value" == "st" ]; then
        compString="Small Steel Tube"

      elif [ "$value" == "sc" ]; then
        compString="Solar Cell"

      elif [ "$value" == "sp" ]; then
        compString="Steel Plate"

      elif [ "$value" == "uc" ]; then
        compString="Superconductor Component"

      elif [ "$value" == "tc" ]; then
        compString="Thruster Components"

      else
        print-components
        echo ""
        echo "[ERROR] UNKNOWN component provided! ($value)"
        exit
      fi

      # echo "[DEBUG] Processing Component: $compString"
      outStr="$outStr $compString,"
    fi


  else 
    matStr=""

    if [ "$wantsJSONComponent" == "false"  ]; then
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
  fi


  loopCounter=$((loopCounter + 1))

done

#remove last comma
outStr=${outStr%?}

echo "RECCOMEND: "
echo "$outStr"
