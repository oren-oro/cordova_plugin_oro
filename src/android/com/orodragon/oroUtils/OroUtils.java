package com.orodragon.oroUtils;

import android.util.Log;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import java.net.NetworkInterface;
import java.util.Collections;

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
        } else if (action.equals("isVpnActive")) {
            boolean isVpn = checkVpn();
            callbackContext.success(isVpn ? 1 : 0); // return 1 = true, 0 = false
            return true;
        } else {
            callbackContext.error("Method not allowed");
            return false;
        }
    }

    private boolean checkVpn() {
        try {
            for (NetworkInterface ni : Collections.list(NetworkInterface.getNetworkInterfaces())) {
                if (ni.isUp() && !ni.isLoopback()) {
                    String name = ni.getName();
                    if (name.equals("tun0") || name.equals("ppp0") || name.equals("pptp")) {
                        return true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
