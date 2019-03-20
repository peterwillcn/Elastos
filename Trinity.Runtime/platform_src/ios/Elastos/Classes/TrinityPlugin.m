/*
 * Copyright (c) 2018 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#import "TrinityPlugin.h"
#import "Elastos-Swift.h"
#include <objc/message.h>

@interface TrinityPlugin()
@property (nonatomic, readwrite, strong) WhitelistFilter* filter;
@property (nonatomic, readwrite) BOOL checkAuthority;
@property (nonatomic, readwrite, copy) NSString* pluginName;
@property (nonatomic, readwrite) NSString* dataPath;
@end

@implementation TrinityPlugin

@synthesize filter;
@synthesize checkAuthority;
@synthesize pluginName;
@synthesize dataPath;

- (void)trinityInitialize:(NSString*)pluginName whitelistFilter:(CDVPlugin *)filter
        checkAuthority:(BOOL)check dataPath:(NSString*)path {
    self.pluginName = pluginName;
    self.filter = (WhitelistFilter*)filter;
    self.checkAuthority = check;
    self.dataPath = path;
}

- (BOOL)isAllowAccess:(NSString *)url {
    return [self.filter shouldAllowNavigation:url];
}

- (NSString*)getDataAbsolutePath:(NSString*)dir error:(NSError * _Nullable *)error {
    NSString* path = [dataPath stringByAppendingPathComponent:dir];
    path = [path stringByStandardizingPath];
    if (![path hasPrefix:dataPath]) {
        
        NSString *domain = @"";
        NSString *desc = NSLocalizedString(@"Dir is invalid!", @"");
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        *error = [NSError errorWithDomain:domain
                                             code:-101
                                         userInfo:userInfo];
        return nil;
    }
    return path;
}

- (NSString*)getDataRelativePath:(NSString*)path error:(NSError * _Nullable *)error {
    path = [path stringByStandardizingPath];
    if (![path hasPrefix:dataPath]) {
        
        NSString *domain = @"";
        NSString *desc = NSLocalizedString(@"Dir is invalid!", @"");
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
        
        *error = [NSError errorWithDomain:domain
                                     code:-102
                                 userInfo:userInfo];
        return nil;
    }
    NSString* dir = [path substringFromIndex: [dataPath length] - 1];
    return dir;
}

- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    NSString* methodName = [NSString stringWithFormat:@"%@:", command.methodName];
    SEL normalSelector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL, id))objc_msgSend)(self, normalSelector, command);
        return YES;
    } else {
        NSString* msg = [NSString stringWithFormat:@"ERROR: Method '%@' not defined in Plugin '%@'", methodName, command.className];
        NSLog(@"%@", msg);
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msg];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        return YES;
    }
}

- (BOOL)trinityExecute:(CDVInvokedUrlCommand*)command
{
    if (checkAuthority) {
        int authority = [self.filter getPluginAuthority:self.pluginName
                                        trinityPlugin: self
                                        invokedUrlCommand: command];
        if (authority == AppInfo.AUTHORITY_ASK) {
            NSString* msg = [NSString stringWithFormat:@"Plugin:'%@' have not run authority.", pluginName];
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msg];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            return YES;
        }
        else if (authority == AppInfo.AUTHORITY_NOINIT || authority == AppInfo.AUTHORITY_ASK) {
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
            [result setKeepCallbackAsBool:YES];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            return YES;
        }
    }
    
    return [self execute:command];
}
@end

