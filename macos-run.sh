#!/bin/bash

# Install XQuartz
if ! command -v xquartz > /dev/null; then 
    echo "Installing Xquartz"; 
    brew install xquartz;  
else 
    echo "Xquartz already installed"; 
fi
# Start XQuartz
if [[ $(ps aux | grep XQuartz | awk {'print $2'} | wc -l) -gt 1 ]]; then 
    echo "Xquartz already running"; 
else
    osascript -e 'tell application "Terminal" to do script "xquartz"';
    sleep 10;
fi


# Install SOCAT
if ! command -v socat > /dev/null; then 
    echo "Installing SOCAT";
    brew install socat; 
else 
    echo "SOCAT already installed"; 
fi

# Kill SOCAT if running
kill -9 $(ps aux | grep socat | awk {'print $2'}) > /dev/null;

# Start SOCAT
osascript -e 'tell application "Terminal" to do script "socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\\\"$DISPLAY\\\""';

# Store IP address of device
export ROBOCODE_LOCAL_IP=$(ifconfig en0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1');
echo $ROBOCODE_LOCAL_IP

# Build and run application
docker-compose up --build;

# Kill SOCAT if running
kill -9 $(ps aux | grep socat | awk {'print $2'}) > /dev/null;