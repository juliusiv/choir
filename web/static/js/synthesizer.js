var FREQUENCIES = {
  c5: 523.25,
  d5: 587.33,
  e5: 659.25,
  f5: 698.46,
  g5: 783.99,
  a5: 880.00,
  b5: 987.77,
  c6: 1046.50
};

export default class Synthesizer {
  constructor() {
    this.AC = new (window.AudioContext || window.webkitAudioContext)();

    // masterGain is used to control muting for the site. This should be the
    // only node connected directly to the destination.
    this.masterGain = this.AC.createGain();
    this.masterGain.connect(this.AC.destination);

    this.oscillators = [];
    this.isPlaying = false;
  }

  // Stop the Player (e.g. all oscillators) from playing.
  stop() {
    for (var i = 0; i < this.oscillators.length; ++i)
      this.oscillators[i].stop(this.AC.currentTime);
    this.isPlaying = false;
  }

  // Start the Player (e.g. all oscillators).
  start() {
    for (var i = 0; i < this.oscillators.length; ++i)
      this.oscillators[i].start();
    this.isPlaying = true;
  }

  // Add a new oscillator to the Player.
  addOscillator(freq = FREQUENCIES.c5) {
    var o = this.AC.createOscillator();
    o.frequency.value = freq;
    o.connect(this.masterGain);

    this.oscillators.push(o);
    return this.oscillators.length - 1;
  }

  setFrequency(freq) {
    this.oscillators[0].frequency.value = freq;
  }

  // Toggle the synthesizer's mute.
  mute() {
    let muted = this.masterGain.gain.value === 0;
    this.masterGain.gain.value = muted ? 1 : 0;
  }
}
