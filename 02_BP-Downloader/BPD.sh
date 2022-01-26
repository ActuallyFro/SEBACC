#!/bin/bash

#save variable $header from HEREDOC string
header=$(cat <<HEREDOC
[BPD] BluePrint Downloader
==========================
Version: 0.0.1


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
    curl -s "$zipURL" > "$BluePrintModNumber.zip"
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