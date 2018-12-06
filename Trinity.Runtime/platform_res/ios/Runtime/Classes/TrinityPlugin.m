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
#import "Runtime-Swift.h"
#include <objc/message.h>

@interface TrinityPlugin()
@property (nonatomic, readwrite, strong) WhitelistFilter* filter;
@end

@implementation TrinityPlugin

@synthesize filter;

- (void)setWhitelistFilter:(WhitelistFilter *)filter {
    self.filter = filter;
}

- (BOOL)isAllowAccess:(NSString *)url {
    return [self.filter shouldAllowNavigation:url];
}

- (BOOL)trinityExecute:(CDVInvokedUrlCommand*)command
{
    NSString* methodName = [NSString stringWithFormat:@"%@:", command.methodName];
    SEL normalSelector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:normalSelector]) {
        ((void (*)(id, SEL, id))objc_msgSend)(self, normalSelector, command);
        return YES;
    } else {
        NSLog(@"ERROR: Method '%@' not defined in Plugin '%@'", methodName, command.className);
        return NO;
    }
   
}
@end

