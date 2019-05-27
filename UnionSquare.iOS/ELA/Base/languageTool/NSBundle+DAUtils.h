//
//  NSBundle+DAUtils.h
//  elastos wallet
//
//  Created by  on 2019/2/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (DAUtils)
+ (BOOL)isChineseLanguage;

+ (NSString *)currentLanguage;
@end

NS_ASSUME_NONNULL_END
