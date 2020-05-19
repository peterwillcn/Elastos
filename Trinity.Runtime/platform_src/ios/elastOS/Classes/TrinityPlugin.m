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
#import "elastOS-Swift.h"

@interface TrinityPlugin()
@property (nonatomic, readwrite, strong) WhitelistFilter* whiteListFilter;
@property (nonatomic, readwrite) NSString* pluginName;
@property (nonatomic, readwrite) AppManager* appManager;
@property (nonatomic, readwrite) AppInfo* appInfo;
@property (nonatomic, readwrite) NSString* appPath;
@property (nonatomic, readwrite) NSString* dataPath;
@property (nonatomic, readwrite) NSString* tempPath;
@property (nonatomic, readwrite) NSString* configPath;
@property (nonatomic, readwrite) NSString* appId;
@property (nonatomic, readwrite) NSString* did;
@end

@implementation TrinityPlugin

@synthesize whiteListFilter;
@synthesize pluginName;
@synthesize appManager;
@synthesize appInfo;
@synthesize appPath;
@synthesize dataPath;
@synthesize tempPath;
@synthesize configPath;
@synthesize appId;
@synthesize did;

- (void)setWhitelistPlugin: (CDVPlugin *)filter  {
    self.whiteListFilter = (WhitelistFilter*)filter;
}

- (void)setInfo: (AppInfo*)info {
    self.appInfo = info;
    self.appManager = [AppManager getShareInstance];
    self.appPath = [appManager getAppPath:info];
    self.dataPath = [appManager getDataPath:info.app_id];
    self.configPath = [appManager getConfigPath ];
    self.tempPath = [appManager getTempPath:info.app_id];
    self.appId = info.app_id;
    self.did = @"didElastosFIXME"; // TODO: FAKE DID FOR NOW
}

- (BOOL)isAllowAccess:(NSString *)url {
    return [self.whiteListFilter shouldAllowNavigation:url];
}

- (BOOL)shouldOpenExternalIntentUrl:(NSString *)url {
    return [self.whiteListFilter shouldOpenExternalIntentUrl:url];
}

- (BOOL)isUrlApp {
    return [appInfo.type isEqualToString:@"url"];
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

- (NSString*)getAppUrl {
    return [appManager getAppUrl:appInfo];
}

- (NSString*)getDataUrl {
    return [appManager getDataUrl:appInfo.app_id];
}

- (NSString*)getTempUrl {
    return [appManager getTempUrl:appInfo.app_id];
}

- (NSString*)getConfigPath {
    return configPath;
}

- (void)setError:(NSError * _Nullable *)error {
    if (error == NULL) {
        return;
    }
    NSString *domain = @"";
    NSString *desc = NSLocalizedString(@"Dir is invalid!", @"");
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };

    *error = [NSError errorWithDomain:domain
                                 code:-101
                             userInfo:userInfo];
}

- (NSString*)getCanonicalDir:(NSString *)path header:(NSString*)header error:(NSError * _Nullable *)error {
    path = [path stringByStandardizingPath];

    if ([header isEqualToString: [path stringByAppendingString:@"/"]]) {
        return @"";
    }

    if (![header hasPrefix:@"/"]) {
        path = [path substringFromIndex:1];
    }
    if (![path hasPrefix:header]) {
        return NULL;
    }
    NSString* dir = [path substringFromIndex:header.length];
    return dir;
}

- (NSString*)getCanonicalPath:(NSString*)path error:(NSError * _Nullable *)error {
    NSString* ret = NULL;
    if (path == NULL) {
        [self setError:error];
        return NULL;
    }
    
    if ([path hasPrefix:@"trinity://"]) {
        NSString*  subPath = [path substringFromIndex:10];
        NSString* id = NULL;
        NSString *_appPath = appPath, *_dataPath = dataPath, *_tempPath = tempPath;
        if (![path hasPrefix:@"trinity:///"]) {
            NSRange range = [subPath rangeOfString:@"/"];
            if ( range.length > 0 ) {
                id = [subPath substringWithRange:NSMakeRange(0, range.location)];
                subPath = [subPath substringWithRange:NSMakeRange(range.location, subPath.length - range.location)];

                AppInfo* info = [appManager getAppInfo:id];
                if (info == NULL) {
                    id = NULL;
                }
                else {
                    _appPath = [appManager getAppPath:info];
                    _dataPath = [appManager getDataPath:info.app_id];
                    _tempPath = [appManager getTempPath:info.app_id];
                }
            }
        }
        else {
            id = self.appInfo.app_id;
        }
        if (id != NULL) {
            if ([subPath hasPrefix:@"/asset/"]) {
                NSString* dir = [self getCanonicalDir:subPath header:@"/asset/" error:error];
                ret = [_appPath stringByAppendingString:dir];
            }
            else if ([subPath hasPrefix:@"/data/"]) {
                NSString* dir = [self getCanonicalDir:subPath header:@"/data/" error:error];
                ret = [_dataPath stringByAppendingString:dir];
            }
            else if ([subPath hasPrefix:@"/temp/"]) {
                NSString* dir = [self getCanonicalDir:subPath header:@"/temp/" error:error];
                ret = [_tempPath stringByAppendingString:dir];
            }
        }
    }
    else if ([path rangeOfString:@"://"].length > 0) {
        if (![path hasPrefix:@"asset://"] && [self isAllowAccess:path]) {
            ret = path;
        }
    }
    else if (![path  hasPrefix:@"/"]) {
        NSString* dir = [self getCanonicalDir:[@"/asset/" stringByAppendingString:path] header:@"/asset/" error:error];
        if (dir != NULL) {
            ret = [appPath stringByAppendingString:dir];
        }
    }

    if (ret == NULL) {
        [self setError:error];
        return NULL;
    }

    return ret;
}

- (NSString*)getDataCanonicalPath:(NSString*)path error:(NSError * _Nullable *)error {
    if (path ==NULL || ![path hasPrefix:@"trinity:///data/"]) {
        [self setError:error];
        return nil;
    }
    return [self getCanonicalPath:path error:error];
}

- (NSString*)getRelativePath:(NSString*)path error:(NSError * _Nullable *)error {
    NSString* ret = nil;
    if (path == NULL) {
        [self setError:error];
        return nil;
    }

    if (![path hasPrefix:@"asset://"] && [path rangeOfString:@"://"].length > 0) {
        if ([self.whiteListFilter shouldAllowNavigation:path]) {
            ret = path;
        }
    }
    else if ([path hasPrefix:appPath]) {
        NSString* dir = [self getCanonicalDir:path  header:appPath error:error];
        if (dir != nil) {
            ret = [@"trinity:///asset/" stringByAppendingString:dir];
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

- (void)pluginInitialize {
    if (appInfo == NULL) {
        [self setInfo:[[AppManager getShareInstance] getLauncherInfo]];
    }
    [super pluginInitialize];
}

@end

