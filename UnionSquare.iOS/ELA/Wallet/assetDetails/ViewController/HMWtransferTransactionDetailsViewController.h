//
//  HMWtransferTransactionDetailsViewController.h
//  ELA
//
//  Created by 韩铭文 on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "assetDetailsModel.h"



typedef NS_ENUM(NSInteger,transactionSingleType ) {
    transactionSingleIntoType,// 自转
    transactionSingleRollOutType,// 转出
     transactionMultipleIntoType,//转入
    
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

@end

NS_ASSUME_NONNULL_END
