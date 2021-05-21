#!/bin/bash

if ! command -v xquartz > /dev/null; then brew install xquartz;  else echo "Xquartz already installed"; fi

if ! command -v socat > /dev/null; then brew install socat; else echo "SOCAT already installed"; fi

osascript -e 'tell application "Terminal" to do script "socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\""'

export ROBOCODE-LOCAL-IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

docker-compose up --build