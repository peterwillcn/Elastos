//
//  WalletManager.h
//  WalletManager
//
//  Created by xuhejun on 2018/12/10.
//  Copyright © 2018年 64. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Cordova/CDV.h>
#import "MyUtil.h"
#import "IMasterWallet.h"
#import "IDidManager.h"
#import "DIDManagerSupervisor.h"
#import "MasterWalletManager.h"
#import "ISidechainSubWallet.h"
#import "IMainchainSubWallet.h"
#import "IIdChainSubWallet.h"
#import "IDidManager.h"
#import "idid.h"
#import <string.h>
#import <map>
#import "ElaSubWalletCallback.h"
#import "FLJoinVoteInfoModel.h"
#import "PluginResult.h"
#import "invokedUrlCommand.h"


typedef Elastos::ElaWallet::IMasterWallet IMasterWallet;
typedef Elastos::DID::DIDManagerSupervisor DIDManagerSupervisor;
typedef Elastos::ElaWallet::MasterWalletManager MasterWalletManager;
typedef Elastos::ElaWallet::ISubWallet ISubWallet;
typedef std::string String;
typedef nlohmann::json Json;
typedef std::vector<IMasterWallet *> IMasterWalletVector;
typedef std::vector<ISubWallet *> ISubWalletVector;
typedef std::vector<String> StringVector;


typedef Elastos::ElaWallet::ElaSubWalletCallback ElaSubWalletCallback;

typedef Elastos::ElaWallet::ISubWalletCallback ISubWalletCallback;
typedef Elastos::ElaWallet::ISidechainSubWallet ISidechainSubWallet;
typedef Elastos::ElaWallet::IMainchainSubWallet IMainchainSubWallet;
typedef std::vector<ISubWalletCallback *> ISubWalletCallbackVector;
typedef Elastos::ElaWallet::IIdChainSubWallet IIdChainSubWallet;

typedef Elastos::DID::IDIDManager IDidManager;
typedef Elastos::DID::IDID IDID;

typedef std::map<String, IDidManager*> DIDManagerMap;


@interface ELWalletManager : NSObject {
    // Member variables go here.
    NSString *TAG; //= @"Wallet";
    DIDManagerMap *mDIDManagerMap;// = new HashMap<String, IDidManager>();
    DIDManagerSupervisor *mDIDManagerSupervisor;// = null;
    MasterWalletManager *mMasterWalletManager;// = null;
    // IDidManager mDidManager = null;
//    ElaSubWalletCallback *mCallback;
    NSString *mRootPath;// = null;
    
    NSString *keySuccess;//   = "success";
    NSString *keyError;//     = "error";
    NSString *keyCode;//      = "code";
    NSString *keyMessage;//   = "message";
    NSString *keyException;// = "exception";
    
    int errCodeParseJsonInAction;//          = 10000;
    int errCodeInvalidArg      ;//           = 10001;
    int errCodeInvalidMasterWallet ;//       = 10002;
    int errCodeInvalidSubWallet    ;//       = 10003;
    int errCodeCreateMasterWallet  ;//       = 10004;
    int errCodeCreateSubWallet     ;//       = 10005;
    int errCodeRecoverSubWallet    ;//       = 10006;
    int errCodeInvalidMasterWalletManager;// = 10007;
    int errCodeImportFromKeyStore     ;//    = 10008;
    int errCodeImportFromMnemonic      ;//   = 10009;
    int errCodeSubWalletInstance      ;//    = 10010;
    int errCodeInvalidDIDManager      ;//    = 10011;
    int errCodeInvalidDID               ;//  = 10012;
    int errCodeActionNotFound           ;//  = 10013;
    
    int errCodeWalletException         ;//   = 20000;
    int  errCodeInvalidParameters;
    int  errCodeInvalidPassword;
    int  errCodeWrongPassword;
    int  errCodeIDNotFound;
    int  errCodeSPVCreateMasterWalletError;
//    - 20005: SPV创建主钱包错误 - SPV create master wallet error
//    - 20006: SPV创建子钱包错误 - SPV create sub wallet error
//    - 20007: 解析JSON数组错误 - Parse json array error
//    - 20008: 无效助记词 - Invalid mnemonic
//    - 20009: 公钥格式错误 - Public key format error
//    - 20010: 公钥长度错误 - Public key length error
//    - 20011: 侧链充值参数错误 - Side chain deposit parameters error
//    - 20012: 侧链提现参数错误 - Side chain withdraw parameters error
//    - 20013: 创建交易过大 - Tx size too large
//    - 20014: 创建交易错误 - Create tx error
//    - 20015: 交易错误 - Invalid tx
//    - 20016: 目录不存在 - Path do not exist
//        - 20017: 注册ID payload错误 - Register ID payload error
//        - 20018: 数据库操作错误 - Sqlite error
//        - 20019: 衍生purpose错误 - Derive purpose error
//        - 20020: 错误账户类型 - Wrong account type
//        - 20021: 错误网络类型 - Wrong net type
//        - 20022: 无效币种 - Invalid coin type
//        - 20023: 无当前多签账户 - No current multi sign account
//        - 20024: 多签参与者数量错误 - Cosigner count error
//        - 20025: 多签错误 - Multi sign error
//        - 20026: keystore错误 - Key store error
//        - 20027: limit gap错误 - Limit gap error
//        - 20028: 钱包包含无效交易 - Wallet contain invalid tx
//        - 20029: 私钥错误 - Key error
//        - 20030: 二进制转字符串错误 - Hex to string error
//        - 20031: 签名类型错误 - Sign type error
//        - 20032: 地址错误 - Address error
//        - 20033: 签名错误 - Sign error
//        - 20034: keystore需要助记词密语 - keystore need phrase password
//        - 20035: 余额不足 - Balance not enough
//
    
}
/*
 *<# #>
 */
@property(strong,nonatomic)FLWallet *currentWallet;
@property(copy,nonatomic)NSString *estimatedHeight;

+(instancetype)share;
- (void)pluginInitialize;
- (PluginResult *)coolMethod:(invokedUrlCommand *)command;
- (PluginResult *)print:(invokedUrlCommand *)command;
- (PluginResult *)getAllMasterWallets:(invokedUrlCommand *)command;
- (PluginResult *)createMasterWallet:(invokedUrlCommand *)command;
- (PluginResult *)generateMnemonic:(invokedUrlCommand *)command;
- (PluginResult *)createSubWallet:(invokedUrlCommand *)command;
- (PluginResult *)getAllSubWallets:(invokedUrlCommand *)command;
- (PluginResult *)getBalance:(invokedUrlCommand *)command;
- (PluginResult *)getSupportedChains:(invokedUrlCommand *)command;
- (PluginResult *)getMasterWalletBasicInfo:(invokedUrlCommand *)command;
- (PluginResult *)getAllTransaction:(invokedUrlCommand *)command;
- (PluginResult *)createAddress:(invokedUrlCommand *)command;
- (PluginResult *)getGenesisAddress:(invokedUrlCommand *)command;
- (PluginResult *)getMasterWalletPublicKey:(invokedUrlCommand *)command;
- (PluginResult *)exportWalletWithKeystore:(invokedUrlCommand *)command;
- (PluginResult *)exportWalletWithMnemonic:(invokedUrlCommand *)command;
- (PluginResult *)changePassword:(invokedUrlCommand *)command;
- (PluginResult *)importWalletWithKeystore:(invokedUrlCommand *)command;
- (PluginResult *)importWalletWithMnemonic:(invokedUrlCommand *)command;
-(PluginResult *)registerWalletListener:(invokedUrlCommand *)command;
-(PluginResult *)DestroySubWallet:(invokedUrlCommand *)command;
-(PluginResult *)DestroyMasterWallet:(invokedUrlCommand *)command;


- (PluginResult *)getAllSubWalletAddress:(invokedUrlCommand *)command;


-(PluginResult *)RemoveCallback:(invokedUrlCommand *)command;
-(PluginResult *)CreateTransaction:(invokedUrlCommand *)command;
-(PluginResult *)accessFees:(invokedUrlCommand *)command;
-(PluginResult *)sideChainTop_Up:(invokedUrlCommand *)command;
-(PluginResult *)sideChainTop_UpFee:(invokedUrlCommand *)command;
-(PluginResult *)mainChainWithdrawal:(invokedUrlCommand *)command;
-(PluginResult *)mainChainWithdrawalFee:(invokedUrlCommand *)command;

-(IMainchainSubWallet*)getWalletELASubWallet:(NSString*)masterWalletID;
//参加投票
-(NSInteger)RegisterProducerWithMainchainSubWallet:(IMainchainSubWallet*)ELA With:(FLJoinVoteInfoModel*)model;
-(NSInteger)UpdateProducerWithMainchainSubWallet:(IMainchainSubWallet*)ELA With:(FLJoinVoteInfoModel*)model;

-(BOOL)useMainchainSubWallet:(NSString*)mainchainSubWalletId ToVote:(NSArray*)publicKeys tickets:(NSInteger)stake pwd:(NSString*)pwd isChangeVote:(BOOL)change;
//取消选举结果
-(BOOL)CancelProducer:(NSString*)mainchainSubWalletId Pwd:(NSString*)pwd;
//拿回押金
-(BOOL)RetrieveDeposit:(NSString*)mainchainSubWalletId acount:(double)acount Pwd:(NSString*)pwd;
//上链
//-(void)PublishTransactionWith:(NSString*)mainchainSubWalletId tx:(Json*)tx;
-(PluginResult *)GetAssetDetails:(invokedUrlCommand *)command;
-(void)EMWMSaveConfigs;
@end



