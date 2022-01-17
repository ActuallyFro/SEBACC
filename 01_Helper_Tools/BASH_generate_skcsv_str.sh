#!/bin/bash

# check if $1 is empty, error out
if [ -z "$1" ]; then
  echo "[ERROR] No STRING provided!"
  exit 1
fi

#iterate over substring, broken up by comma
for componentCostStr in $(echo $1 | tr "," "\n"); do
  echo "[DEBUG] Looking at: $componentCostStr"

done
