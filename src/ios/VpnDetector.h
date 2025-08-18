#import <Cordova/CDV.h>

@interface VpnDetector : CDVPlugin

- (void)isVpnActive:(CDVInvokedUrlCommand*)command;

@end
