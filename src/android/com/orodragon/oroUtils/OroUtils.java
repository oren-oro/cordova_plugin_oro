package com.orodragon.oroUtils;

import android.util.Log;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;

public class OroUtils extends CordovaPlugin {

    private static final String APPTAG = "OroUtils";

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("setThreadName")) {
            Log.i(APPTAG, "setThreadName");
            try {
                String threadName = args.getString(0);
                if (threadName == null || threadName.trim().length() == 0)
                    throw new JSONException("Missing thread name!");
                Thread.currentThread().setName(threadName);
                callbackContext.success();
            }
            catch (JSONException exception) {
                callbackContext.error(exception.getMessage());
            }
            return true;
        } else {
            callbackContext.error("Method not allowed");
            return false;
        }
    }
}
