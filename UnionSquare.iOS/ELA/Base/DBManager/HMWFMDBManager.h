//
//  HMWFMDBManager.h
//  elastos wallet
//
//  Created by  on 2019/1/12.
//

#import "FMDatabase.h"
#import "friendsModel.h"
#import "FMDBWalletModel.h"
#import "sideChainInfoModel.h"
typedef NS_ENUM(NSInteger, FMDatabaseType) {
    friendsModelType = 0,
    walletType=1,
    sideChain=2,
};

NS_ASSUME_NONNULL_BEGIN

@interface HMWFMDBManager : FMDatabase
+(instancetype)sharedManagerType:(FMDatabaseType)type;
//增加

-(BOOL)addRecord:(friendsModel *)person;

//查
-(NSArray*)allRecord;
//删
-(BOOL)delectRecord:(friendsModel *)person;

//改
-(BOOL)updateRecord:(friendsModel *)person;





//增加

-(void)addWallet:(FMDBWalletModel *)wallet;
//查
-(NSArray*)allRecordWallet;

//改
-(BOOL)updateRecordWallet:(FMDBWalletModel *)wallet;
//删
-(BOOL)delectRecordWallet:(FMDBWalletModel *)wallet;


-(BOOL)addsideChain:(sideChainInfoModel*)model;
-(sideChainInfoModel*)selectAddsideChainWithWalletID:(NSString*)walletID andWithIconName:(NSString*)iconName;
-(BOOL)delectSideChain:(NSString*)ID withIconName:(NSString*)iconName;
-(BOOL)sideChainUpdate:(sideChainInfoModel *)model;
@end

NS_ASSUME_NONNULL_END
