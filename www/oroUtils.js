var emptyFnc = function () {
};
module.exports = {
  setThreadName: function (threadName, successCallback, errorCallback) {
    cordova.exec(successCallback || emptyFnc, errorCallback || emptyFnc, "OroUtils", "setThreadName", [threadName]);
  }
};
