#!/bin/bash

keyFile="BLOCKED_Key"

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

