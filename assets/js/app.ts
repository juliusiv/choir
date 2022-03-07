// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
// @ts-ignore
import { Socket } from "phoenix"
// @ts-ignore
import { LiveSocket } from "phoenix_live_view"
import * as Tone from "tone";
import { Visualizer } from './visualization';

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

let synth = undefined;
let reverb = undefined;
let delay = undefined;
let visualizer = undefined;

const enableAudioButton = document.getElementById("enable-audio-btn")
const visualizationCanvas = document.getElementById("visualization-canvas")
const notes = ["C3", "E3", "G3", "C4", "E4", "G4", "C5"];
const envelope = {
  attack: 2,
  decay: 1.8,
  sustain: 1,
  release: 10
};

const randomInt = (max) => {
  return Math.floor(Math.random() * max);
};

if (enableAudioButton) {
  enableAudioButton.addEventListener("click", function() {
    Tone.context.resume().then(() => {
      console.log('Playback resumed successfully');
      synth = new Tone.PolySynth({
        maxPolyphony: 64,
        voice: Tone.Synth,
        volume: -6,
        options: { envelope }
      })

      reverb = new Tone.Reverb({ wet: 0.01, decay: 0.7 });
      delay = new Tone.PingPongDelay({ delayTime: "3n", feedback: 0.5, wet: 1 });
      const compressor = new Tone.Compressor(-30, 3);
      visualizer = new Visualizer(visualizationCanvas);
      
      /**
       * Audio effects chain:
       *
       * [PolySynth] --> [Reverb] --> [Delay] --> [Compressor] --> Output
       */
      synth.chain(reverb, delay, compressor, visualizer.analyser, Tone.Destination);

      visualizer.renderFrame();
    });
  });
}

const beep = () => {
  if (synth) {
    const note = notes[randomInt(4)];
    synth.triggerAttackRelease(note, 0.5);
  }
}

const randomTic = () => {
  beep();
  setTimeout(randomTic, Math.random() * 1000);
}
randomTic();

// connect if there are any LiveViews on the page
liveSocket.connect()
// @ts-ignore
window.liveSocket = liveSocket

