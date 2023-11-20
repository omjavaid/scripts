#!/bin/bash

# Check the OS type
ostype=$(uname -s)

# Check if the OS is Linux
if [[ $ostype == "Linux" ]]; then
  brave-browser --incognito --proxy-server="socks5://127.0.0.1:5858"
else
  # Check if the OS is Mac
  if [[ $ostype == "Darwin" ]]; then
    open -a Brave\ Browser -n --args --incognito --proxy-server="socks5://127.0.0.1:5858"    
  else
    echo "Unknown OS"
  fi
fi
