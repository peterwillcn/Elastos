//
//  ELABaseModel.h
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/14.
//  Copyright © 2020 64. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELABaseModel : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *message;

@end

NS_ASSUME_NONNULL_END
