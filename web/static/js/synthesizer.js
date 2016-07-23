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

function defaultFor(arg, val) {
  return typeof arg !== "undefined" ? arg : val;
}

var synthesizer = {
  AC: new (window.AudioContext || window.webkitAudioContext)(),
  oscillators: [],
  isPlaying: false,

  // Stop the Player (e.g. all oscillators) from playing.
  stop: function() {
    for (var i = 0; i < this.oscillators.length; ++i)
      this.oscillators[i].stop(this.AC.currentTime);
    this.isPlaying = false;
  },

  // Start the Player (e.g. all oscillators).
  start: function() {
    for (var i = 0; i < this.oscillators.length; ++i)
      this.oscillators[i].start();
    this.isPlaying = true;
  },

  // Add a new oscillator to the Player.
  addOscillator: function(freq) {
    freq = defaultFor(freq, FREQUENCIES.c5);

    var o = this.AC.createOscillator();
    o.frequency.value = freq;
    o.connect(this.AC.destination);

    this.oscillators.push(o);
    return this.oscillators.length - 1;
  },

  setFrequency: function(freq) {
    this.oscillators[0].frequency.value = freq;
  },
}

export default synthesizer;