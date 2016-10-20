var flyd = require("flyd");
var jsdom = require("jsdom");
var $ = require("jquery")(jsdom.jsdom().defaultView);
// var $ = require("jquery")(window);

import { Utils } from "../../web/static/js/utils.js";


describe("setupStreams()", function() {
  it("creates an array of streams from an array of inputs", function() {
    let initialVal = 0;
    let mockInputs = [
      $(`<input type="number" value=${initialVal}>`),
      $(`<input type="number" value=${initialVal}>`),
      $(`<input type="number" value=${initialVal}>`),
    ];

    let streams = Utils.setupStreams(mockInputs);

    for (var i = 0; i < streams.length; i++) {
      assert.true(flyd.isStream(streams[i]));
    }
  });
});
