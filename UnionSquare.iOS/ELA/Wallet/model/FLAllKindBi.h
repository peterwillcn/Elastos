//
//  FLAllKindBi.h
//  FLWALLET
//
//  Created by  on 2018/5/7.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLAllKindBi : NSObject
@property (nonatomic, copy)NSString*balance;
@property (nonatomic, copy)NSString*tokenAddress;
@property (nonatomic, copy)NSString*tokenName;
@property (nonatomic, copy)NSString*walletAddress;
@property (nonatomic, copy)NSString*tokenDesc;
@property(nonatomic, assign) NSInteger decimals;
@property (nonatomic, copy)NSString *convertBalance;
@property (nonatomic, copy)NSString *exchangeBalance;
@property (nonatomic, assign)NSInteger isAppend;
@property (nonatomic, copy)NSString *logo;

@property (nonatomic, copy)NSString* currentPrice;
@property (nonatomic, copy)NSString*priceLimit;
/*
 *人民币
 */
@property(copy,nonatomic)NSString *currentCYNPrice;
/*
 *美元
 */
@property(copy,nonatomic)NSString *currentUSDPrice;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *exchangeUSDBalance;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *exchangeCNYBalance;

@end
