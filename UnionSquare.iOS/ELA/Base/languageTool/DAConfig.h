//
//  DAConfig.h
//  elastos wallet
//
//  Created by  on 2019/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DAConfig : NSObject
/**
 用户自定义使用的语言，当传nil时，等同于resetSystemLanguage
 */
@property (class, nonatomic, strong, nullable) NSString *userLanguage;
/**
 重置系统语言
 */
+ (void)resetSystemLanguage;
+(BOOL)isArrayType;
@end

NS_ASSUME_NONNULL_END
