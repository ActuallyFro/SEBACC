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
    exit 1
fi

echo "[BPD] [INFO] Downloading BluePrint Mod <$BluePrintModNumber>"
combinedURL="$downloadURL$BluePrintModNumber$keyAppend$key" 
echo "[BPD] [INFO] URL: $combinedURL"

#curl file save as $BluePrintModNumber.html
#if file does not exist, run curl
if [ ! -f "$BluePrintModNumber.html" ]; then
    echo "[BPD] [INFO] File does not exist, downloading..."
    curl -s "$combinedURL" > "$BluePrintModNumber.html"
    echo "[BPD] [INFO] File downloaded!"
else
    echo "[BPD] [WARN] File already exists, skipping download..."
fi
