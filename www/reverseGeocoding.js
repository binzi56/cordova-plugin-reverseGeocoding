var exec = require('cordova/exec');

var reverseGeocodingFunc = function(){};

reverseGeocodingFunc.prototype.address = function(arg0, success, error) {
    exec(success, error, "reverseGeocoding", "reverseGeocodingMethod", arg0);
};

var reverseGeocoding = new reverseGeocodingFunc();
module.exports = reverseGeocoding;
