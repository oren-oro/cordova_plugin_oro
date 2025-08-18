#import "VpnDetector.h"
#import <ifaddrs.h>
#import <net/if.h>

@implementation VpnDetector

- (void)isVpnActive:(CDVInvokedUrlCommand*)command {
    BOOL vpnActive = [self checkVPN];
    
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK 
                                                   messageAsBool:vpnActive];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (BOOL)checkVPN {
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    BOOL vpnActive = NO;

    if (getifaddrs(&interfaces) == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
            if ([name hasPrefix:@"utun"] || [name hasPrefix:@"ppp"]) {
                vpnActive = YES;
                break;
            }
            temp_addr = temp_addr->ifa_next;
        }
    }

    if (interfaces != NULL) {
        freeifaddrs(interfaces);
    }

    return vpnActive;
}

@end
