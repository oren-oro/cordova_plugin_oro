import Foundation
import NetworkExtension
import Cordova

@objc(VpnDetector) class VpnDetector: CDVPlugin {

    @objc(isVpnActive:)
    func isVpnActive(command: CDVInvokedUrlCommand) {
        var isVPNConnected = false
        if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let scopes = settings["__SCOPED__"] as? [String: Any] {
            for key in scopes.keys {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") {
                    isVPNConnected = true
                    break
                }
            }
        }

        let pluginResult = CDVPluginResult(status: .ok, messageAs: isVPNConnected)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
}
