//
//  FLTradeModel.h
//  FLWALLET
//
//  Created by  on 2018/5/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTradeModel : NSObject
@property (nonatomic, copy)NSString*daysBefore;
@property (nonatomic, copy)NSString*direction;
@property (nonatomic, copy)NSString*fromAddress;
@property (nonatomic, copy)NSString*remark;
@property (nonatomic, copy)NSString*transHash;
@property (nonatomic, copy)NSString*value;
@property (nonatomic, copy)NSString*status;
@property (nonatomic, copy)NSString*toAddress;


// 交易回调结果
@property (nonatomic, copy)NSString*contractAddress;
@property (nonatomic, copy)NSString*blockHash;
@property (nonatomic, copy)NSString*transactionHash;
@property (nonatomic, copy)NSString*blockNumber;
@property (nonatomic, copy)NSString*cumulativeGasUsed;
@property (nonatomic, copy)NSString*gasUsed;
@property (nonatomic, copy)NSString*to;
@property (nonatomic, copy)NSString*gasPrice;
@property (nonatomic, copy)NSString*gasLimit;
@property (nonatomic, copy)NSString*transDateTime;
@property (nonatomic, copy)NSString*mineFee;




@end










