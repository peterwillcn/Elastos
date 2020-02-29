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
#import "HWMCRListModel.h"
#import "HWMDIDInfoModel.h"
typedef NS_ENUM(NSInteger, FMDatabaseType) {
    friendsModelType = 0,
    walletType=1,
    sideChain=2,
    CRListType,
    DIDInfoType
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





//增加
-(BOOL)addCR:(HWMCRListModel*)CRModel withWallID:(NSString*)walletID;
//查
-(NSArray*)allSelectCRWithWallID:(NSString*)walletID;
-(BOOL)selectCRWithWalletID:(NSString*)walletID andWithDID:(NSString*)DID;
//改
-(BOOL)updateSelectCR:(HWMCRListModel *)crModel WithWalletID:(NSString*)walletID;
//删
-(BOOL)delectSelectCR:(HWMCRListModel *)crModel WithWalletID:(NSString*)walletID;









-(BOOL)addDIDCR:(HWMDIDInfoModel*)Model withWallID:(NSString*)walletID;

//查
-(NSArray*)allSelectDIDWithWallID:(NSString*)walletID;

//改
-(BOOL)updateSelectDID:(HWMDIDInfoModel *)Model WithWalletID:(NSString*)walletID;

-(HWMDIDInfoModel*)selectDIDWithWalletID:(NSString*)walletID andWithDID:(NSString*)DID;
//改
-(BOOL)updateDIDInfo:(HWMDIDInfoModel *)Model WithWalletID:(NSString*)walletID;
//删
-(BOOL)delectDIDInfo:(HWMDIDInfoModel *)Model WithWalletID:(NSString*)walletID;




@end

NS_ASSUME_NONNULL_END
