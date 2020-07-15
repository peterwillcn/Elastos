//
//  HMWtransferTransactionSingleAddressDetailsView.h
//  ELA
//  单地址
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,transactionSingleType ) {
    transactionSingleIntoType,//转入
    transactionSingleRollOutType// 转出
    
};

NS_ASSUME_NONNULL_BEGIN

@interface HMWtransferTransactionSingleAddressDetailsView : UIView
/*
 *<# #>
 */
@property(assign,nonatomic)transactionSingleType type;
@end

NS_ASSUME_NONNULL_END
