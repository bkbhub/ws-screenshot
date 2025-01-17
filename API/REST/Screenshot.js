const puppeteer = require('puppeteer');
var hardcodedAPIKey = require("../../appconfig.json").ApiKey;
const tools = require('../shared.js');

const os = require('os')
const cpuCount = os.cpus().length
var maxConcurrency = (cpuCount)/2;
if (maxConcurrency < 1){
    maxConcurrency = 1;
}

exports.handler = async (event, context, callback) => {

    var sharedmem = context.sharedmem;
    var beginPipeline = process.hrtime();

    if ( hardcodedAPIKey != "" && event.queryStringParameters.apiKey != hardcodedAPIKey ){
        callback(null, {
            status: 400,
            content: "Invalid API Key"
        });
        return;
    }

    while ( sharedmem.getInteger("nbPuppeteerProcess") >= maxConcurrency ){
        await tools.sleep(20);
    }

    sharedmem.incInteger("nbPuppeteerProcess", 1);

    var url = event.queryStringParameters.url;
    if ( url == null || url == "" ){
        url = "https://www.google.com";
    }
    else{
        url = decodeURIComponent(url);
    }

    var isFullPage = false; if ( event.queryStringParameters.isFullPage == "true" ) { isFullPage = true; }
    var resX = 1280; if ( event.queryStringParameters.resX != null ) { resX = event.queryStringParameters.resX; }
    var resY = 900; if ( event.queryStringParameters.resY != null ) { resY = event.queryStringParameters.resY; }
    var outFormat = "jpg"; if ( event.queryStringParameters.outFormat != null ) { outFormat = event.queryStringParameters.outFormat; }
    var waitTime = 100; if ( event.queryStringParameters.waitTime != null ) { waitTime = event.queryStringParameters.waitTime; }
    var quality = 88; if ( event.queryStringParameters.quality != null ) { quality = event.queryStringParameters.quality; }
    var timeout = 120000; if ( event.queryStringParameters.timeout != null ) { timeout = event.queryStringParameters.timeout; }

    //var screenshotResult = await tools.screnshotForUrl(url, isFullPage, resX, resY, outFormat);
    var screenshotResult = null;

    try {
        const frozer = setTimeout(() => {
            sharedmem.setString("healtherror", "frozen");
        }, timeout);
        screenshotResult = await tools.screnshotForUrlTab(url, isFullPage, resX, resY, outFormat, waitTime, quality);
        clearTimeout(frozer);
    }
    catch(ex) {
        callback(null, {
            status: 500,
            content: ex
        });
        return;
    } finally {
        sharedmem.incInteger("nbPuppeteerProcess", -1);
        sharedmem.incInteger("nbScreenshots", 1);
    }

    const nanoSeconds = process.hrtime(beginPipeline).reduce((sec, nano) => sec * 1e9 + nano);
    var durationMS = (nanoSeconds/1000000);

    if ( !screenshotResult?.data ){
        callback(null, {
            status: 500,
            content: "Not processed"
        });
        return;
    }

    callback(null, {
            status: 200,
            content: screenshotResult.data.toString('base64'),
            details: screenshotResult.details,
            headers:{
                "execTime": durationMS.toFixed(2) + "ms",
                "nbPuppeteerProcess": sharedmem.getInteger("nbPuppeteerProcess"),
                "totalScreenshots": sharedmem.getInteger("nbScreenshots"),
                "Content-Type": "text/plain"
            }
    });

};
