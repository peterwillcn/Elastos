//
//  invokedUrlCommand.h
//  elastos wallet
//
//  Created by  on 2019/5/27.
//

@end
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface invokedUrlCommand : NSObject
@property (nonatomic, readonly) NSArray* arguments;
@property (nonatomic, readonly) NSString* callbackId;
@property (nonatomic, readonly) NSString* className;
@property (nonatomic, readonly) NSString* methodName;

+ (invokedUrlCommand*)commandFromJson:(NSArray*)jsonEntry;

- (id)initWithArguments:(NSArray*)arguments
             callbackId:(NSString*)callbackId
              className:(NSString*)className
             methodName:(NSString*)methodName;

- (id)initFromJson:(NSArray*)jsonEntry;

// Returns the argument at the given index.
// If index >= the number of arguments, returns nil.
// If the argument at the given index is NSNull, returns nil.
- (id)argumentAtIndex:(NSUInteger)index;
// Same as above, but returns defaultValue instead of nil.
- (id)argumentAtIndex:(NSUInteger)index withDefault:(id)defaultValue;
// Same as above, but returns defaultValue instead of nil, and if the argument is not of the expected class, returns defaultValue
- (id)argumentAtIndex:(NSUInteger)index withDefault:(id)defaultValue andClass:(Class)aClass;
@end

NS_ASSUME_NONNULL_END
