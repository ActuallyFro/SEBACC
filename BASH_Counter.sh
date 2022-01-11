#!/bin/bash

#A simple script that will find XML tags in an bp.sbc file, find all the unique tags, and calculate total component amounts from a JSON look up file.

#check if file exists
fileName="example_file-Coelacanth_bp.sbc"
if [ -f "$1" ]; then
  # echo "File exists"
  fileName="$1"  
  # else
  #   echo "File does not exist"
  #   exit 1
fi

keyStr="SubtypeName"
results=`cat $fileName | grep SubtypeName | sed "s/<SubtypeName>//g" | sed "s/<\/SubtypeName>//g" | sort  | uniq -c | grep -v "Ice\|SubtypeName"`

#remove leading whitespace in each row -- COPILOT
results=`echo "$results" | sed 's/^[ \t]*//'`

#replace whitespace with comma
results=`echo "$results" | sed 's/ /,/g' | sed "s/,,,,,,,,,,,,,,,/,/g"`

# echo "[DEBUG] RESULTS:"
# echo "$results"

#loop over each line in $results, look up string in Blocks.json and Components.json, and add to total
total=0
declare -A counts
for line in $results; do
  # echo "DEBUG - LINE: $line"

  #split line into key and value with awk
  value=`echo "$line" | awk -F, '{print $1}'`
  key=`echo "$line" | awk -F, '{print $2}'`

  #remove whiltesapce and special characters from key
  key=`echo "$key" | sed 's/^[ \t]*//' | sed 's/[ \t]*$//' | sed 's/[^a-zA-Z0-9]//g'`
  
  #remove whiltesapce and special characters from value
  value=`echo "$value" | sed 's/^[ \t]*//' | sed 's/[ \t]*$//' | sed 's/[^a-zA-Z0-9]//g'`  

  # echo "Found: '$key' (amt: $value)"
  # echo "[DEBUG] Found: '$key' (amt: $value)"

  #look up key in Blocks.json
  doesLineExist=`cat Blocks.json | grep -c "$key"`

  doesLineExistTF="false"

  if [ "$doesLineExist" -gt 0 ]; then
    doesLineExistTF="true"
    # echo "[DEBUG] Does '$key' exist in Blocks.json? $doesLineExistTF"
  else
    echo "[ERROR] CANNOT find ''$key'' in Blocks.json"
  fi


  #COPILOT:
  counts[$key]=$value
  # counts[$key]=0 
  #Zero out the NEW Block

  # echo "-----"
done

declare -A components
# For every key in the associative array..
for KEY in "${!counts[@]}"; do
  # echo "[DEBUG] LOOKING AT KEY: $KEY" 
  # echo "[DEBUG] counts[SmallBlockSmallHydrogenThrust]: ${counts[SmallBlockSmallHydrogenThrust]}"
  # tempVal=${counts[$KEY]}
  # lines=`cat Blocks.json | jq -c '.SmallBlockSmallHydrogenThrust' | jq '.Cost' | sed '1d;$d' | sed "s/  \"//g" | sed "s/\": /,/g"`
  lines=$(cat Blocks.json | jq -c "."$KEY | jq '.Cost' | sed '1d;$d' | sed "s/  \"//g" | sed "s/\": /,/g")
  for JSONline in $lines; do
    JSONkey=`echo "$JSONline" | awk -F, '{print $1}'`
    value="${counts[$KEY]}"
    JSONvalue=`echo "$JSONline" | awk -F, '{print $2}'`
    result=$(($JSONvalue * $value))
    # echo "[DEBUG] Found Component '$JSONkey' (amt: $JSONvalue * $value = $result)"

    oldVal=${components[$JSONkey]}
    newTotal=$(($oldVal + $result))
    components[$JSONkey]=$newTotal
  done

  # # Print the KEY value
  # echo "[DEBUG] Key: $KEY"
  # # Print the VALUE attached to that KEY
  # echo "[DEBUG] Value: ${counts[$KEY]}"
  # echo "- - - "
done

  # printf "%s %s\n" "${components[0]}" "${components[1]}"

# echo $components
echo "========================="
echo "TOTAL Component  RESULTS:"
echo "========================="
for KEYCOMP in "${!components[@]}"; do
  valueCOMP="${components[$KEYCOMP]}"
  echo "$KEYCOMP,$valueCOMP"
done