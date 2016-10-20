var flyd = require("flyd");

import { Utils } from "./utils";


var setupWeatherStreams = () => utils.setupStreams($(".weather-input"));
var setupBrowserStreams = () => utils.setupStreams($(".browser-input"));
var setupConnectionStream = () => utils.setupStreams($(".connection-input"))[0];
var setupTemperatureStream = () => utils.setupStreams($(".temperature-input"))[0];
var setupLatitudeStream = () => utils.setupStreams($(".latitude-input"))[0];
var setupLongitudeStream = () => utils.setupStreams($(".longitude-input"))[0];


export var Rehearse = {
  start: () => {
    setupWeatherStreams();
    setupBrowserStreams();
    setupConnectionStream();
    setupTemperatureStream();
    setupLatitudeStream();
    setupLongitudeStream();
  }
};
