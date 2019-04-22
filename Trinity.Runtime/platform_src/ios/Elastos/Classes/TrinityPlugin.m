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
@property (nonatomic, readwrite) NSString* appPath;
@property (nonatomic, readwrite) NSString* dataPath;
@property (nonatomic, readwrite) NSString* tempPath;
@end

@implementation TrinityPlugin

@synthesize filter;
@synthesize checkAuthority;
@synthesize pluginName;
@synthesize appPath;
@synthesize dataPath;
@synthesize tempPath;

- (void)trinityInitialize:(NSString*)pluginName whitelistFilter:(CDVPlugin *)filter
        checkAuthority:(BOOL)check appPath:(NSString*)appPath
        dataPath:(NSString*)dataPath tempPath:(NSString*)tempPath {
    self.pluginName = pluginName;
    self.filter = (WhitelistFilter*)filter;
    self.checkAuthority = check;
    self.appPath = appPath;
    self.dataPath = dataPath;
    self.tempPath = tempPath;
}

- (BOOL)isAllowAccess:(NSString *)url {
    return [self.filter shouldAllowNavigation:url];
}

- (NSString*)getAppPath {
    return appPath;
}

- (NSString*)getDataPath {
    return dataPath;
}

- (NSString*)getTempPath {
    return tempPath;
}

- (void)setError:(NSError * _Nullable *)error {
    NSString *domain = @"";
    NSString *desc = NSLocalizedString(@"Dir is invalid!", @"");
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
    
    *error = [NSError errorWithDomain:domain
                                 code:-101
                             userInfo:userInfo];
}

- (NSString*)getCanonicalDir:(NSString *)path header:(NSString*)header error:(NSError * _Nullable *)error {
    path = [path stringByStandardizingPath];
    if (![header hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    if (![path hasPrefix:header]) {
        return nil;
    }
    NSString* dir = [path substringFromIndex:header.length];
    return dir;
}

- (NSString*)getCanonicalPath:(NSString*)path error:(NSError * _Nullable *)error {
    NSString* ret = nil;
    if ([path hasPrefix:@"trinity:///assets/"]) {
        NSString* dir = [self getCanonicalDir:[path substringFromIndex:10] header:@"/assets/" error:error];
        if (dir != nil) {
            ret = [appPath stringByAppendingString:dir];
        }
    }
    else if ([path hasPrefix:@"trinity:///data/"]) {
        NSString* dir = [self getCanonicalDir:[path substringFromIndex:10] header:@"/data/" error:error];
        if (dir != nil) {
            ret = [dataPath stringByAppendingString:dir];
        }
    }
    else if ([path hasPrefix:@"trinity:///temp/"]) {
        NSString* dir = [self getCanonicalDir:[path substringFromIndex:10] header:@"/temp/" error:error];
        if (dir != nil) {
            ret = [tempPath stringByAppendingString:dir];
        }
    }
    else if ([path rangeOfString:@"://"].length > 0) {
        if (![path hasPrefix:@"assets://"] && [self.filter shouldAllowNavigation:path]) {
            ret = path;
        }
    }
    else if (![path  hasPrefix:@"/"]) {
        NSString* dir = [self getCanonicalDir:[@"/assets/" stringByAppendingString:path] header:@"/assets/" error:error];
        if (dir != nil) {
            ret = [appPath stringByAppendingString:dir];
        }
    }
    
    if (ret == nil) {
        [self setError:error];
        return nil;
    }

    return ret;
}

- (NSString*)getRelativePath:(NSString*)path error:(NSError * _Nullable *)error {
    NSString* ret = nil;
    if (![path hasPrefix:@"assets://"] && [path rangeOfString:@"://"].length > 0) {
        if ([self.filter shouldAllowNavigation:path]) {
            ret = path;
        }
    }
    else if ([path hasPrefix:appPath]) {
        NSString* dir = [self getCanonicalDir:path  header:appPath error:error];
        if (dir != nil) {
            ret = [@"trinity:///assets/" stringByAppendingString:dir];
        }
    }
    else if ([path hasPrefix:dataPath]) {
        NSString* dir = [self getCanonicalDir:path  header:dataPath error:error];
        if (dir != nil) {
            ret = [@"trinity:///data/" stringByAppendingString:dir];
        }
    }
    else if ([path hasPrefix:tempPath]) {
        NSString* dir = [self getCanonicalDir:path  header:tempPath error:error];
        if (dir != nil) {
            ret = [@"trinity:///temp/" stringByAppendingString:dir];
        }
    }
    if (ret == nil) {
        [self setError:error];
        return nil;
    }
    
    return ret;
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

