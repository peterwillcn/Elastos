//
//  ELATUpdateSecretaryDidModel.h
//  YFFixedAssets
//
//  Created by xuhejun on 2020/5/14.
//  Copyright © 2020 64. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ELABaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ELATUpdateSecretaryDidModel : ELABaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isChecked;

@end

NS_ASSUME_NONNULL_END
