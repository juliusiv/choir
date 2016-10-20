var $ = require("jquery");


export var Utils = {
  setupStreams: (inputs) => {
    let streams = [];

    for (var i = 0; i < inputs.length; i++) {
      let input = $(inputs[i]);
      let s = flyd.stream(input.val());
      streams.push(s);

      input.change(s);
    }

    return streams;
  }
}
