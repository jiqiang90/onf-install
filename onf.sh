#!/bin/sh
set -e

reset="\033[0m"
cyan="\033[36m"
green="\033[32m"

#Release
VERSION=v0.2.0

#Check OS
if [ "$(uname)" == "Darwin" ]; then
  LOCATION="/usr/local/bin"
  URL="https://github.com/OnFinality-io/onf-cli/releases/download/$VERSION/onf-darwin-amd64-$VERSION"
  SYSTEM="MACOS"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  URL="https://github.com/OnFinality-io/onf-cli/releases/download/$VERSION/onf-linux-amd64-$VERSION"
  LOCATION="/usr/local/bin"
  SYSTEM="LINUX"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT"  ]; then
  URL="https://github.com/OnFinality-io/onf-cli/releases/download/$VERSION/onf-windows-amd64-$VERSION.exe"
  LOCATION="%WINDIR%\system32"
  SYSTEM="WINDOWS"
fi

#Download binary
printf "$cyan> Downloading ...$reset\n"
cd "$LOCATION"
if curl -L "$URL" --output onf ;then
  if [ "$SYSTEM" != "WINDOWS" ];then
    chmod 773 onf
  fi
  printf "$green > onf command $VERSION is ready. $reset\n"
else
  printf "$red> Failed to download $url.$reset\n"
  exit 1;
fi