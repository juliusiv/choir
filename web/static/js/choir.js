import { Socket } from "phoenix";
import { Recon } from "./recon";
import Synthesizer from "./synthesizer.js";

var CLIENT_DATA = {
  lat: undefined,
  lon: undefined,
  temp: undefined,
  browser: undefined,
  weather: undefined
};

export var Choir = {
  start: function() {
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
      CLIENT_DATA.lat = loc.coords.latitude;
      CLIENT_DATA.lon = loc.coords.longitude;

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
  }
};
