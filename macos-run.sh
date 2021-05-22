#!/bin/bash

# Install XQuartz
if ! command -v xquartz > /dev/null; then 
    brew install xquartz;  
else 
    echo "Xquartz already installed"; 
fi

# Install SOCAT
if ! command -v socat > /dev/null; then 
    brew install socat; 
else 
    echo "SOCAT already installed"; 
fi

# Kill SOCAT if running
kill -9 $(ps aux | grep socat | awk {'print $2'}); 

# Start SOCAT
osascript -e 'tell application "Terminal" to do script "socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\\\"$DISPLAY\\\"" '

# Store IP address of device
export ROBOCODE_LOCAL_IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

# Build and run application
docker-compose up --build