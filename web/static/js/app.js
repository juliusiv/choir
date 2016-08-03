// Brunch automatically concatenates all files in your watched paths. Those
// paths can be configured at config.paths.watched in "brunch-config.js".
// 
// However, those files will only be executed if explicitly imported. The only
// exception are files in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember to also remove its path
// from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths "./socket" or full
// ones "web/static/js/socket".

// import socket from "./socket"
import { Socket } from "phoenix";
import { Recon } from "./recon"
import Synthesizer from "./synthesizer.js"


var CLIENT_DATA = {
  latitude: undefined,
  longitude: undefined,
  temp: undefined,
  browser: undefined,
  weather: undefined
}

$(document).ready(function() {
  let spanSelector = ">.info"
  let browserSection = $("#browser"+spanSelector);
  let locationSection = $("#location"+spanSelector);
  let temperatureSection = $("#temperature"+spanSelector);
  let weatherSection = $("#weather"+spanSelector);
  let aggDataSection = $("#aggdata"+spanSelector);

  let token = $("meta[name=channel_token]").attr("content");
  let socket = new Socket("/socket", {params: {token: token}});
  let channel = socket.channel("voices", {});

  let synth = new Synthesizer();

  channel.on("voice_update", payload =>{
    aggDataSection.text(JSON.stringify(payload, null, 2));
    synth.setFrequency(523.25 + 50*payload.connections);
  });

  // Set the text for the client's browser.
  CLIENT_DATA.browser = Recon.getBrowser();
  browserSection.text(CLIENT_DATA.browser);

  // Get the client's geolocation coordinates as a Promise.
  let locationPromise = Recon.getLocation();

  // Handle the location coordinates and send a request for the client's weather
  // temperature as a Promise.
  locationPromise.then(function(loc) {
    CLIENT_DATA.latitude = loc.coords.latitude;
    CLIENT_DATA.longitude = loc.coords.longitude;

    let latRounded = Math.round(loc.coords.latitude * 100)/100;
    let lonRounded = Math.round(loc.coords.longitude * 100)/100;
    locationSection.text(`${latRounded}, ${lonRounded}`);

    return Recon.getTemperature(loc.coords.latitude, loc.coords.longitude);
  }, function(error) {
    console.error("Failed!", error);
  // Handle the weather Promise by using the temperature and weather
  // description.
  }).then(function(weather) {
    CLIENT_DATA.temp = parseInt(weather.temp);
    CLIENT_DATA.weather = weather.currently.toLowerCase();

    temperatureSection.text(`${weather.temp}\u00B0 ${weather.units.temp}`);
    weatherSection.text(`${weather.currently}`);

    socket.connect();
    channel.join()
      .receive("ok", resp => { channel.push("connect", CLIENT_DATA) })
      .receive("error", resp => { console.log("Unable to join", resp) });

    // Add an oscillator and start playing sound.
    synth.addOscillator();
    synth.start();
  }, function(error) {
    console.error("Failed!", error);
  });

  // When the sound control is clicked change its class so the icon on the
  // button changes and toggle the synth's mute.
  $("#sound-control").click(function() {
    $("#sound-control>span").toggleClass("fa-volume-off fa-volume-up");
    synth.mute();
  });
});
