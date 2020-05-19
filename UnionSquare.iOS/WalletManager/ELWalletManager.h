//
//  WalletManager.h
//  WalletManager
//
//  Created by  on 2018/12/10.
//  Copyright © 2018年 64. All rights reserved.
//

#import <Foundation/Foundation.h>
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
typedef Elastos::ElaWallet::IIDChainSubWallet IIdChainSubWallet;

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
    int errCodeMasterWalletAlreadyExist;
    int errSPVCreateSubWalletError;
    int errParseJsonArrayError;
    int errInvalidMnemonic;
    int errPublickeyFormatError;
    int errPublicKeyLengthError;
    int errSideShainDepositParametersError;
    int errSideChainWithdrawParametersError;
    int errTxSizeTooLarge;
    int errCreateTxError;
    int errInvalidTx;
    int errPathDoNotExist;
    int errRegisterIDPayloadError;
    int errSqliteError;
    int errDerivePurposeError;
    int errWrongAccountType;
    int errWrongNetType;
    int errInvalidCoinType;
    int errNoCurrentMultiSignAccount;
    int errCosignerCountError;
    int errMultiSignError;
    int errKeyStoreError;
    int errLimitGapError;
    int errWalletContainInvalidTx;
    int errKeyError;
    int errHexToStringError;
    int errSignTypeError;
    int errAddressError;
    int errSignError;
    int errkeystoreNeedPhrasePassword;
    int errBalanceNotEnough;
    
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
-(BOOL)useCRMainchainSubWallet:(NSString*)CRmainchainSubWalletId WithJosnString:(NSString*)josnString withPWD:(NSString*)pwd;
-(NSDictionary *)DopsVoteFeeCRMainchainSubWallet:(NSString*)CRmainchainSubWalletId ToVote:(NSArray*)publicKeys tickets:(double)stake withInvalidIDArray:(NSArray*)InvalidArr;
-(BOOL)useMainchainSubWallet:(NSString*)mainchainSubWalletId WithJsonString:(NSString*)jsonstring pwd:(NSString*)pwd;
-(PluginResult *)SignReadOnlyToVote:(invokedUrlCommand *)command;
-(PluginResult *)HowSignToVote:(invokedUrlCommand *)command;
-(PluginResult *)SignReadOnlyToCR:(invokedUrlCommand *)command;
-(PluginResult *)HowSignToCR:(invokedUrlCommand *)command;
//取消选举结果
-(BOOL)CancelProducer:(NSString*)mainchainSubWalletId Pwd:(NSString*)pwd;
//拿回押金
-(BOOL)RetrieveDeposit:(NSString*)mainchainSubWalletId acount:(double)acount Pwd:(NSString*)pwd withJSONString:(NSString*)jsonString;
//上链
//-(void)PublishTransactionWith:(NSString*)mainchainSubWalletId tx:(Json*)tx;
-(PluginResult *)GetAssetDetails:(invokedUrlCommand *)command;
-(void)EMWMFlushData;
-(NSString*)GetRegisteredProducerInfo:(NSString *)mainid;
-(NSString *)GetOwnerAddressWithID:(NSString*)masterWalletID;
-(PluginResult *)GetAllCoinBaseTransaction:(invokedUrlCommand *)command;
-(PluginResult *)getMasterWalletPublicKey:(invokedUrlCommand *)command;
-(PluginResult *)CreateCombineUTXOTransaction:(invokedUrlCommand *)command;
-(PluginResult *)GetAllUTXOs:(invokedUrlCommand *)command;
-(PluginResult *)CreateMultiSignMasterWalletMnemonic:(invokedUrlCommand *)command;
-(PluginResult *)CreateMultiSignMasterWalletmasterReadonly:(invokedUrlCommand *)command;
-(PluginResult *)CreateMultiSignMasterWalletmasterMasterWalletId:(invokedUrlCommand *)command;
-(NSString *)ExportxPrivateKey:(invokedUrlCommand *)command;
-(void*)SyncStart:(invokedUrlCommand *)command;
-(NSString*)EMWMGetVersion;
-(PluginResult *)ExportReadonlyWallet:(invokedUrlCommand *)command;
-(PluginResult *)ExportMasterPublicKey:(invokedUrlCommand *)command;
-(PluginResult *)CreateImportReadonlyWallet:(invokedUrlCommand *)command;
-(PluginResult *)GetTransactionSignedInfo:(invokedUrlCommand *)command;
-(PluginResult *)MSignAndReadOnlyCreateTransaction:(invokedUrlCommand *)command;
-(PluginResult *)QrCodeCreateTransaction:(invokedUrlCommand *)command;
-(PluginResult *)VerifyPayPassword:(invokedUrlCommand *)command;
-(PluginResult *)VerifyPassPhrase:(invokedUrlCommand *)command;
-(PluginResult *)publishtransaction:(invokedUrlCommand *)command;
-(PluginResult *)SignTransaction:(invokedUrlCommand *)command;
-(NSInteger)RegisterCRWithMainchainSubWallet:(NSString*)ELA With:(FLJoinVoteInfoModel*)model;
-(BOOL)UpdateCRProducerWithMainchainSubWallet:(NSString*)ELA With:(FLJoinVoteInfoModel*)model;
-(BOOL)CancelCRProducer:(NSString*)mainchainSubWalletId Pwd:(NSString*)pwd withDIDinfo:(NSString*)didInfo;
-(BOOL)RetrieveCRDepositTransaction:(NSString*)mainchainSubWalletId acount:(double)acount Pwd:(NSString*)pwd withJSONString:(NSString*)jsonstring;
-(PluginResult *)getDIDlist:(invokedUrlCommand *)command;
-(PluginResult *)getDetailsDIDlist:(invokedUrlCommand *)command;
-(PluginResult *)getAllPublicKeys:(invokedUrlCommand *)command;
-(NSDictionary*)GetCRFirstPublicKeysAndDID:(invokedUrlCommand *)command;
-(NSDictionary *)CRVoteFeeCRMainchainSubWallet:(NSString*)CRmainchainSubWalletId ToVote:(NSDictionary*)publicKeys tickets:(double)stake withInvalidIDArray:(NSArray*)InvalidArr;
-(PluginResult *)CreateCombineUTXOTransactionFeeAndJSONString:(invokedUrlCommand *)command;
-(BOOL)useMainchainSubWallet:(NSString*)mainchainSubWalletId ToVote:(NSArray*)publicKeys tickets:(double)stake pwd:(NSString*)pwd isChangeVote:(BOOL)change withInvalidIDArray:(NSArray*)InvalidArr;
-(NSDictionary*)RetrieveDepositFee:(NSString*)mainchainSubWalletId acount:(NSString*)acount Pwd:(NSString*)pwd;
-(NSDictionary*)RetrieveCRDepositTransactionFee:(NSString*)mainchainSubWalletId acount:(NSString*)acount Pwd:(NSString*)pwd;
-(BOOL)IsAddressValidWithMastID:(NSString*)masWalletID WithAddress:(NSString*)address;
-(PluginResult *)SpvDidAdapter_CreateIdTransactionEXWith:(invokedUrlCommand *)command;
-(void)RandomSwitchLink:(invokedUrlCommand *)command;
-(BOOL)ManualInputIP:(invokedUrlCommand *)command;
-(NSString*)adviceTheSignature:(invokedUrlCommand *)command;
- (PluginResult *)proposaSignTransaction:(invokedUrlCommand *)command;
- (PluginResult *)proposalReviewTransaction:(invokedUrlCommand *)command;
@end



