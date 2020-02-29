
#import "JSON_private.h"
#import <Foundation/NSJSONSerialization.h>

@implementation NSArray (JSONSerializingPrivate)

- (NSString*)JSONString
{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];

    if (error != nil) {
        NSLog(@"NSArray JSONString error: %@", [error localizedDescription]);
        return nil;
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end

@implementation NSDictionary (JSONSerializingPrivate)

- (NSString*)JSONString
{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];

    if (error != nil) {
        NSLog(@"NSDictionary JSONString error: %@", [error localizedDescription]);
        return nil;
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end

@implementation NSString (JSONSerializingPrivate)

- (id)JSONObject
{
    NSError* error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    
    if (error != nil) {
        NSLog(@"NSString JSONObject error: %@, Malformed Data: %@", [error localizedDescription], self);
    }

    return object;
}

- (id)JSONFragment
{
    NSError* error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingAllowFragments
                                                  error:&error];

    if (error != nil) {
        NSLog(@"NSString JSONObject error: %@", [error localizedDescription]);
    }

    return object;
}

@end
