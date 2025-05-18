var emptyFnc = function () {
};
module.exports = {
  setThreadName: function (successCallback, errorCallback) {
    cordova.exec(successCallback || emptyFnc, errorCallback || emptyFnc, "OrUtils", "setThreadName", []);
  }
};
