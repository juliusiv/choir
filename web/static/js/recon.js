export var Recon = {
  getBrowser: function() {
    // Opera 8.0+
    var isOpera = (!!window.opr && !!opr.addons) || !!window.opera ||
      navigator.userAgent.indexOf(' OPR/') >= 0;
    // Firefox 1.0+
    var isFirefox = typeof InstallTrigger !== 'undefined';
    // At least Safari 3+: "[object HTMLElementConstructor]"
    var isSafari = Object.prototype.toString.call(window.HTMLElement)
      .indexOf('Constructor') > 0;
    // Internet Explorer 6-11
    var isIE = /*@cc_on!@*/false || !!document.documentMode;
    // Edge 20+
    var isEdge = !isIE && !!window.StyleMedia;
    // Chrome 1+
    var isChrome = !!window.chrome && !!window.chrome.webstore;
    // Blink engine detection
    var isBlink = (isChrome || isOpera) && !!window.CSS;

    if (isOpera)
      return "opera";
    else if (isFirefox)
      return "firefox";
    else if (isSafari)
      return "safari";
    else if (isIE)
      return "ie";
    else if (isEdge)
      return "edge";
    else if (isChrome)
      return "chrome";
    else if (isBlink)
      return "blink";
    else
      return "unknown";
  },

  getTemperature: function(lat, lon) {
    return new Promise(function(resolve, reject) {
      $.simpleWeather({
        location: `${lat}, ${lon}`,
        woeid: "",
        unit: "f",
        success: resolve,
        error: reject
      });
    });
  },

  getLocation: function() {
    return new Promise(function(resolve, reject) {
      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(function(location) {
          resolve(location);
        }, reject, {enableHighAccuracy: true});
      } else {
        reject(Error("Couldn't retrieve location."));
      }
    });
  },

  getWeather: function() {
    console.log("getting weather...");
  },
}