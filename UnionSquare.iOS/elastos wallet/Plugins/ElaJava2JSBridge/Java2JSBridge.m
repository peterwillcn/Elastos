/********* Wallet.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>



static CDVInvokedUrlCommand *mCallbackContext = nil;
//static Java2JSBridgeInterface java2JSBridgeInterface;
static NSString *deviceID = @"";
static NSString *getRegistrationID = @"";

@interface Java2JSBridge : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)callJSInit:(CDVInvokedUrlCommand*)command;
- (void)getResult:(CDVInvokedUrlCommand*)command;
- (void)getRegistrationID:(CDVInvokedUrlCommand*)command;
- (void)getDeviceID:(CDVInvokedUrlCommand*)command;

@end

@implementation Java2JSBridge

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)callJSInit:(CDVInvokedUrlCommand*)command
{
    mCallbackContext = command;
    
}

#warning   未完成
- (void)getResult:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString *echo = [command.arguments componentsJoinedByString:@","];
    
    NSLog(@"\n%@--%d\n%s\n", echo, __LINE__, __FILE__);
    
//    java2JSBridgeInterface.getJSEvalResult(args.toString());
    
//    if (echo != nil && [echo length] > 0) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }
//
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getRegistrationID:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:getRegistrationID];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getDeviceID:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:deviceID];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
#warning 未完成
- (void)callJS:(NSString *)message :(id) java2JSBridgeInterfaceArg
{
    CDVPluginResult* pluginResult = nil;

    if (mCallbackContext != nil) {
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:mCallbackContext.callbackId];
//        java2JSBridgeInterface = java2JSBridgeInterfaceArg;
//        PluginResult dataResult = new PluginResult(PluginResult.Status.OK, message);
//        dataResult.setKeepCallback(true);// 非常重要
        [pluginResult setKeepCallbackAsBool:YES];
//        mCallbackContext.sendPluginResult(dataResult);
    }
}

@end
