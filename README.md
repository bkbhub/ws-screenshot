# ws-screenshot
A simple way to take a screenshot of a website by providing its URL. ws-screenshot include a simple web UI but also a REST API and a Websocket API to automate screenshots.

DEMO: https://backup15.terasp.net/

![](https://cf.appdrag.com/support-documentatio-cb1e1b/uploads/files/e76ed2f5-943e-4fac-b454-6ebb9208f7a6.gif)

&nbsp;

# Quickstart with Docker

Run once: 

    docker pull bkbhub/screenshot
    docker run -p 3000:3000 -it bkbhub/screenshot

or Run as a docker service:

    docker run --name ws-screenshot -d --restart always -p 3000:3000 -it bkbhub/screenshot

Then open http://yourIP:3000/ in your browser

&nbsp;
# Requirements

- Linux, Windows or Mac OS
- Node 10+ for single-threaded mode, Node 12+ for multi-threaded mode

if you are on Node 10, you can activate multi-threading by executing this in your terminal:

```bash
export NODE_OPTIONS=--experimental-worker
```


## Install Node.js 12
    sudo apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt -y install nodejs

## Clone this repository
Clone this repo then install NPM dependencies for ws-screenshot:

    git clone git@github.com:elestio/ws-screenshot.git
    cd ws-screenshot
    npm install

## Install required dependencies for chrome:
    
    ./installPuppeteerNativeDeps.sh


&nbsp;

# Run ws-screenshot

## Run directly

Finally we can start WS-SCREENSHOT Server one-time:
    
    ./run.sh

or run as a service with pm2

    npm install -g pm2
    pm2 start run.sh --name ws-screenshot
    pm2 save

## Run with docker (local version for dev)
Run just once

    docker build -t ws-screenshot .
    docker run --rm -p 3000:3000 -it ws-screenshot

Run as a docker service

    docker run --name ws-screenshot -d --restart always -p 3000:3000 -it ws-screenshot

## Run on Kubernetes
Run with helm

    helm upgrade --install ws-screenshot --namespace ws-screenshot helm/

&nbsp;
# Usage

## REST API

Make a GET request (or open the url in your browser):
    
    /api/screenshot?resX=1280&resY=900&outFormat=jpg&isFullPage=false&url=https://vms2.terasp.net

## Websocket API

```js
var event = { 
  cmd: "screenshot", 
  url: url, 
  originalTS: (+new Date()), 
  resX: resX, 
  resY: resY, 
  outFormat: outFormat, 
  isFullPage: isFullPage 
};
```

You can check /public/js/client.js and /public/index.html for a sample on how to call the Websocket API


&nbsp;
# Supported parameters
- url: full url to screenshot, must start with http:// or https://
- resX: integer value for screen width, default: 1280
- resY: integer value for screen height, default: 900
- outFormat: output format, can be jpg, png or pdf, default: jpg
- isFullPage: true or false, indicate if we should scroll the page and make a full page screenshot, default: false
- waitTime: integer value in milliseconds, indicate max time to wait for page resources to load, default: 100

&nbsp;
# Protect with an ApiKey

You can protect the REST & WS APIs with an ApiKey, this is usefull if you want to protect your screenshot server from being used by anyone
To do that, open appconfig.json and set any string like a GUID in ApiKey attribute. This will be your ApiKey to pass to REST & WS APIs

To call the REST API with an ApiKey:

    /api/screenshot?url=https://example.com&apiKey=XXXXXXXXXXXXX

To call the Websocket API with an ApiKey:

```js
var event = { 
  cmd: "screenshot", 
  url: url, 
  originalTS: (+new Date()), 
  apiKey: "XXXXXXXXXXXXX"
};
```

You can check /public/js/client.js for a sample on how to call the Websocket API


# TODO list
- Add wait duration as a param (some sites need more time to load all resources)
- Add support for cookies / localstorage auth (to be able to screenshot authenticated pages)

