//
//  HMWnodeInformationViewController.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"


typedef enum : NSUInteger {
    CRInformationType,
   nodeInformationType
} InformationType;

@interface HMWnodeInformationViewController : UIViewController
@property(nonatomic,strong)FLCoinPointInfoModel *model;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger Ranking;
/*
 *<# #>
 */
@property(assign,nonatomic)InformationType type;
@end

