var emptyFnc = function () {
};
module.exports = {
  setThreadName: function (threadName, successCallback, errorCallback) {
    cordova.exec(successCallback || emptyFnc, errorCallback || emptyFnc, "OrUtils", "setThreadName", [threadName]);
  }
};
