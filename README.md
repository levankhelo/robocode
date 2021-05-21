# Prerequisites

## MacOS
We will need to get `xhost` and `socat` to run GUI display from container

## TL;DR
```bash
if ! command -v xquartz > /dev/null; then brew install xquartz;  else echo "Xquartz already installed"; fi

if ! command -v socat > /dev/null; then brew install socat; else echo "SOCAT already installed"; fi

osascript -e 'tell application "Terminal" to do script "socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\""'

export ROBOCODE-LOCAL-IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

docker-compose up --build
```
### Install X11
```bash
if ! command -v xquartz > /dev/null; then
    brew install xquartz;
else
    echo "Xquartz already installed";
fi
```
After installation, Open up *xquartz* using command `xquartz` or icon click, go to:   
`XQUARTZ` > `Preferences` > `Security` > `Allow connections from network clients` > `✅ (check)`
### Install SOCAT
```bash
if ! command -v socat > /dev/null; then
    brew install socat;
else
    echo "SOCAT already installed";
fi
```

### Run Socat 
```bash
osascript -e 'tell application "Terminal" to do script "socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\""'
```

### Configure variables for container
```bash
export ROBOCODE-LOCAL-IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
```
### Build Docker image
Make sure docker service is running
```bash
docker-compose build
```

### Run docker image
```bash
docker-compose up
```

> or `docker-compose up --build`