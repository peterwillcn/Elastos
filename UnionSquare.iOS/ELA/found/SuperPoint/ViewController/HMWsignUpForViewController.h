//
//  HMWsignUpForViewController.h
//  ELA
//
//  Created by  on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HMWsignUpForViewControllerDelegate<NSObject>

-(void)hasSignUp;

@end

@class FLJoinVoteInfoModel;
@interface HMWsignUpForViewController : UIViewController
@property(nonatomic,strong)FLJoinVoteInfoModel* model;
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *currentWallet;
/*
 *<# #>
 */
@property(weak,nonatomic)id <HMWsignUpForViewControllerDelegate> delegate;

@end
