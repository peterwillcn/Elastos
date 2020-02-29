//
//  HMWnodeInformationViewController.h
//  ELA
//
//  Created by  on 2019/1/6.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLCoinPointInfoModel.h"
#import "HWMCRListModel.h"


typedef enum : NSUInteger {
    CRInformationType,
   nodeInformationType
} InformationType;

@protocol HMWnodeInformationViewControllerDelegate <NSObject>

-(void)needUpdateListWithIndex:(NSInteger)index;

@end

@interface HMWnodeInformationViewController : UIViewController
@property(nonatomic,strong)FLCoinPointInfoModel *model;
@property(nonatomic,strong)HWMCRListModel *CRmodel;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger Ranking;
/*
 *<# #>
 */
@property(assign,nonatomic)InformationType type;
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWnodeInformationViewControllerDelegate>delegate;
/*
 *<# #>
 */
@property(assign,nonatomic)NSUInteger   index;

@property(copy,nonatomic)NSString * totalvotes;


@property(copy,nonatomic)NSArray * lastTimeArray ;
@end

