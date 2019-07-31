//
//  HMWtransferTransactionDetailsViewController.h
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assetDetailsModel.h"



typedef NS_ENUM(NSInteger,transactionSingleType ) {
    transactionSingleIntoType,// 自转
    transactionSingleRollOutType,// 转出
     transactionMultipleIntoType,//转入
    rotationToVoteType,//自转投票
    NodeReturnsType
    
};
NS_ASSUME_NONNULL_BEGIN





@interface HMWtransferTransactionDetailsViewController : UIViewController
/*
 *<# #>
 */
@property(assign,nonatomic)transactionSingleType type;


/*
 *<# #>
 */
@property(strong,nonatomic)assetDetailsModel *model;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *iconNameString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *votesString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *TypeString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *PayloadInfoString;
@end

NS_ASSUME_NONNULL_END
