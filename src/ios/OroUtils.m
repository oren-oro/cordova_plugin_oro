#import "OroUtils.h"
#import <CFNetwork/CFNetwork.h>

@implementation OroUtils

- (void)isVpnActive:(CDVInvokedUrlCommand*)command {
    BOOL vpnActive = [self checkVPN];

    dispatch_async(dispatch_get_main_queue(), ^{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                           messageAsBool:vpnActive];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    });
}

// VPN detection via system proxy settings
- (BOOL)checkVPN {
    NSDictionary *settings = (__bridge NSDictionary *)CFNetworkCopySystemProxySettings();
    if (settings == nil) {
        return NO;
    }

    // Check if any of the VPN-related keys are set
    NSNumber *vpnEnabled = [settings objectForKey:@"__SCOPED__"] != nil ? @YES : @NO;

    return [vpnEnabled boolValue];
}

@end
