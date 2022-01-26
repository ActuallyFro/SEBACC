#!/bin/bash

#save variable $header from HEREDOC string
header=$(cat <<HEREDOC
[BPD] BluePrint Downloader
==========================
Version: 1.0.0


HEREDOC
)



keyFile="BLOCKED_Key"
key=$(cat $keyFile)
downloadURL="https://api.mod.io/v1/games/264/mods/"
keyAppend="/files?api_key="

echo "$header"
echo ""

if [ ! -f "$keyFile" ]; then
    echo "[BPD] [ERROR] you need to SAVE your Mod.io API key; It does NOT exist, creating file 'BLOCKED_Key'"
    touch "$keyFile"
    echo ""
    echo "Please follow: https://www.reddit.com/r/spaceengineers/comments/he43z0/howto_downloading_from_modio/, then add your key"
    exit 1
fi

#if keyFile is empty error!
if [ ! -s "$keyFile" ]; then
    echo "[BPD] [ERROR] Keyfile is EMPTY!!! You need to SAVE your Mod.io API key!"
    echo ""
    echo "See yours here: https://mod.io/apikey"
    exit 1
fi

#rm zip and html files if "--clean" is set
if [ "$1" == "--clean" ]; then
    echo "[BPD] [INFO] Cleaning up old files..."
    rm -f *.zip
    rm -f *.html
    # rm -f *.sbc
    rm -f *.sbcB5
    rm -f *.mod
    rm -f *.png
    echo "[BPD] [INFO] Done!"
    exit
fi

BluePrintModNumber="$1"
#check if BluePrintModNumber is a number
if [ -z "$BluePrintModNumber" ] || [ "$BluePrintModNumber" -eq 0 ]; then
    echo "[BPD] [ERROR] You need to specify a Mod Number!"
    echo ""
    echo "Go to your Mod.io page: https://mod.io/members/<YOUR ID>"
    echo "Then find a Mod with its entry: (mod ID: #######)"
    exit 1
fi

echo "[BPD] [INFO] Downloading BluePrint Mod <$BluePrintModNumber>"
combinedURL="$downloadURL$BluePrintModNumber$keyAppend$key" 
combinedURLHidden="$downloadURL$BluePrintModNumber$keyAppend[HIDDEN]" 
echo "[BPD] [INFO] URL: $combinedURLHidden"

#curl file save as $BluePrintModNumber.html
#if file does not exist, run curl
if [ ! -f "$BluePrintModNumber.html" ]; then
    echo "[BPD] [INFO] File does not exist, downloading..."
    curl -s "$combinedURL" > "$BluePrintModNumber.html"
    echo "[BPD] [INFO] File downloaded!"
else
    echo "[BPD] [WARN] File already exists, skipping download..."
fi

zipURL=$(cat "$BluePrintModNumber.html" | tr -d "\"" | tr "," "\n" | grep https | sed "s/url:/\n/g" | grep http | tr -d '\\')
echo "[BPD] [INFO] ZIP URL: $zipURL"

if [ ! -f "$BluePrintModNumber.zip" ]; then
    echo "[BPD] [INFO] File does not exist, downloading..."
    curl -sL "$zipURL" > "$BluePrintModNumber.zip"
else
    echo "[BPD] [WARN] File already exists, skipping download..."
fi

if [ ! -s "$BluePrintModNumber.zip" ]; then
    echo "[BPD] [ERROR] Zipfile is EMPTY!!!"
    echo ""
    echo "Delete it and the mod's html file and try again; or run $0 --clean"
    exit 1
else
    echo "[BPD] [INFO] File downloaded!"
fi

unzip -j "$BluePrintModNumber.zip" "bp.sbc" > /dev/null 2>&1
mv "bp.sbc" "bp_$BluePrintModNumber.sbc" > /dev/null 2>&1

if [ ! -f "bp_$BluePrintModNumber.sbc" ]; then
    echo "[BPD] [ERROR] SBC file does not exist!!!"
    echo ""
    echo "Check the html and zip file to determine if your key was valid or if the zip downloaded..."
    exit 1
fi

if [ ! -s "bp_$BluePrintModNumber.sbc" ]; then
    echo "[BPD] [ERROR] SBC file is EMPTY!!!"
    echo ""
    echo "Check the html and zip file to determine if your key was valid or if the zip downloaded..."
    exit 1
fi

# firstTwo=$(cat "bp_$BluePrintModNumber.sbc" | grep "DisplayName" | head -n 2)
firstTwo=$(cat "bp_$BluePrintModNumber.sbc" | grep "DisplayName" | sed -e 1b -e '$!d')

loop="1"
user="hello"
modName="hi"

while read -r line; do
    temp=`echo "$line" | sed "s/<DisplayName>//g" | sed "s/<\/DisplayName>//g" | sed 's/^ *//g' | sed 's/ *$//g' | tr -dc '[:alnum:] -_.'`
    # echo "[BPD] [DEBUG] '$temp'"
    if [[ "$loop" == "1" ]]; then
        # echo "[BPD] [DEBUG] Saving user name... $temp"
        user="$temp"

    elif [[ "$loop" == "2" ]]; then
        # echo "[BPD] [DEBUG] Saving mod name... $temp"
        modName="$temp"
    fi

    loop=$((loop+1))
done <<< "$(echo -e "$firstTwo")"
echo "==========================" 
echo "[BPD]Blue Print '$modName' by '$user' (ID: $BluePrintModNumber) downloaded!"
echo ""
echo "Published by:"; echo "-------------" ; cat "bp_$BluePrintModNumber".sbc | grep DisplayName | sed "s/<DisplayName>//g" | sed "s/<\/DisplayName>//g"; echo "History -----------------^"
# rm -f *.html
# rm -f *.zip
