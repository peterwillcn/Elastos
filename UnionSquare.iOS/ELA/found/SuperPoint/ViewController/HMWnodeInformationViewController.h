//
//  HMWnodeInformationViewController.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HMWnodeInformationViewController : UIViewController
@property(nonatomic,strong)FLCoinPointInfoModel *model;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger Ranking;

@end

NS_ASSUME_NONNULL_END
