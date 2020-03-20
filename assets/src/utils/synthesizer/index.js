import { useState, useEffect } from "react";

// Might not actually really need this because the state is stored in the synth anyway...
const useSynthesizer = () => {
  const [synthesizer, setSynthesizer] = useState(new Synthesizer());

  return synthesizer;
};

class Synthesizer {
  constructor() {
    try {
      // Fix up for prefixing
      window.AudioContext = window.AudioContext || window.webkitAudioContext;
      this.audioContext = new AudioContext();

      this.oscillators = {
        bass: this.audioContext.createOscillator(),
        treble: this.audioContext.createOscillator(),
        alto: this.audioContext.createOscillator(),
        soprano: this.audioContext.createOscillator(),
      };

      this._connectAllOscillators();
    }
    catch (e) {
      throw new Error("Web Audio API is not supported in this browser");
    }

    this.isStarted = false;
    this.isMuted = undefined;
  }

  start = () => {
    // The synth must be explicitly started in order to work. We do this because some browsers (Safari)
    // require the audio context to be started after a user action.
    if (!this.isStarted) {
      this.oscillators.bass.start();
      this.oscillators.treble.start();
      this.oscillators.alto.start();
      this.oscillators.soprano.start();

      this.isStarted = true;
    }
  }

  setFrequency = hz => {
    this.oscillators.bass.frequency.value = hz;
    this.oscillators.treble.frequency.value = hz;
    this.oscillators.alto.frequency.value = hz;
    this.oscillators.soprano.frequency.value = hz;
  }

  mute = () => {
    this.isMuted = true;
    this._disconnectAllOscillators();
  }

  unmute = () => {
    this.isMuted = false;
    this._connectAllOscillators();
  }

  _connectAllOscillators = () => {
    this.oscillators.bass.connect(this.audioContext.destination);
    this.oscillators.treble.connect(this.audioContext.destination);
    this.oscillators.alto.connect(this.audioContext.destination);
    this.oscillators.soprano.connect(this.audioContext.destination);
  }

  _disconnectAllOscillators = () => {
    this.oscillators.bass.disconnect(this.audioContext.destination);
    this.oscillators.treble.disconnect(this.audioContext.destination);
    this.oscillators.alto.disconnect(this.audioContext.destination);
    this.oscillators.soprano.disconnect(this.audioContext.destination);
  }
};

export default Synthesizer;
export {
  useSynthesizer
};
