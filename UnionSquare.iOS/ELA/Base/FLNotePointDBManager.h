//
//  FLNotePointDBManager.h
//  elastos wallet
//
//  Created by 樊晓乐 on 2019/1/28.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FLCoinPointInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FLNotePointDBManager : FMDatabase

+(instancetype)defultWithWalletID:(NSString*)WalletID;

//增加

-(BOOL)addRecord:(FLCoinPointInfoModel*)person;

//查
-(NSArray*)allRecord;
-(BOOL)hasModel:(FLCoinPointInfoModel*)note;
//删
-(BOOL)delectRecord:(FLCoinPointInfoModel*)person;

//改
-(BOOL)updateRecord:(FLCoinPointInfoModel*)person;
-(BOOL)delectAllWithWalletID:(NSString*)walletID;

@end

NS_ASSUME_NONNULL_END
