//
//  WalletManager.m
//  WalletManager
//
//  Created by  on 2018/12/10.
//  Copyright © 2018年 64. All rights reserved.
//

#import "ELWalletManager.h"
#include <dispatch/dispatch.h>
#import "sideChainInfoModel.h"
#import "HMWFMDBManager.h"
#import "HWMMessageCenterModel.h"
#import "HWMDIDManager.h"
#import "YYKit.h"
static ELWalletManager *tool;
static uint64_t feePerKB = 10000;


#pragma mark - ELWalletManager
@interface ELWalletManager ()
/*
 *
 */
@property(strong,nonatomic)NSMutableArray *resListArray;


@end


@implementation ELWalletManager


+(instancetype)share{
    
    if (!tool) {
        
        tool = [[self alloc]init];
        [tool pluginInitialize];
        
    }
    return tool;
    
}
-(instancetype)init{
    self = [super init];
    
    return self;
}
-(NSMutableArray *)resListArray{
    if (!_resListArray) {
        _resListArray =[[NSMutableArray alloc]init];
    }
    return _resListArray;
}
#pragma mark -
- (IMasterWallet *)getIMasterWallet:(String)masterWalletID
{
    if (mMasterWalletManager == nil) {
        
        return nil;
    }
    try {
        return  mMasterWalletManager->GetMasterWallet(masterWalletID);
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
}

- (ISubWallet *)getSubWallet:(String)masterWalletID :(String)chainID
{
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        
        return nil;
    }
    ISubWalletVector subWalletList;
    try {
        subWalletList = masterWallet->GetAllSubWallets();
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    for (int i = 0; i < subWalletList.size(); i++)
    {
        ISubWallet *iSubWallet = subWalletList[i];
        String  getChainID;
        
        try {
            getChainID =iSubWallet->GetChainID();
        } catch (const std:: exception & e ) {
            NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
            NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
            [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
            return nil;
        }
        
        NSString *getChainIDString = [self stringWithCString:getChainID];
        NSString *chainIDString = [self stringWithCString:chainID];
        
        if ([chainIDString isEqualToString:getChainIDString])
        {
            return iSubWallet;
        }
    }
    return nil;
}
- (IIdChainSubWallet *)getIdChainSubWallet:(String)masterWalletID :(String)chainID{
    
    ISubWallet * SubWallet=[self getSubWallet:masterWalletID :chainID];
    IIdChainSubWallet *ChainSubWallet = dynamic_cast<IIdChainSubWallet *>(SubWallet);
    return ChainSubWallet;
}
- (void)createDIDManager:(IMasterWallet *)masterWallet
{
    
}



#pragma mark -

- (NSString *)getBasicInfo:(IMasterWallet *)masterWallet
{
    Json json;
    try {
        
        json = masterWallet->GetBasicInfo();
    
    } catch (const std:: exception & e ) {
        
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return @"-1";
    }
    
    
    
    
    NSString *jsonString = [self stringWithCString:json.dump()];
    
    return jsonString;
}

- (NSString *)formatWalletName:(String)stdStr
{
    NSString *string = [self stringWithCString:stdStr];
    NSString *str = [NSString stringWithFormat:@"(%@)", string];
    return str;
}
- (NSString *)formatWalletNameWithString:(String)stdStr other:(String)other
{
    NSString *string = [self stringWithCString:stdStr];
    NSString *otherString = [self stringWithCString:other];
    NSString *str = [NSString stringWithFormat:@"(%@:%@)", string, otherString];
    return str;
}

- (PluginResult *)errCodeInvalidArg:(invokedUrlCommand *)command code:(int)code idx:(int)idx
{
    NSString *msg = [NSString stringWithFormat:@"%d %@", idx, @" parameters are expected"];
    return [self errorProcess:command code:code msg:msg];
}

- (PluginResult *)successProcess:(invokedUrlCommand *)command  msg:(id) msg
{
    
    NSDictionary *dic = [self mkJson:keySuccess value:msg];
    
    PluginResult* pluginResult = nil;
    
    
    
    pluginResult = [PluginResult resultWithStatus:CommandStatus_OK messageAsDictionary:dic];
    return pluginResult;
    
    
    
}
- (PluginResult *)errorProcess:(invokedUrlCommand *)command  code : (int) code msg:(id) msg
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[NSNumber numberWithInteger:code] forKey:keyCode];
    [dic setValue:msg forKey:keyMessage];
    
    NSDictionary *jsonDic = [self mkJson:keyError value:dic];
    PluginResult* pluginResult = nil;
    
    [[FLTools share]showErrorInfo:NSLocalizedString(msg, nil)];
    
    pluginResult = [PluginResult resultWithStatus:CommandStatus_ERROR messageAsDictionary:jsonDic];
    
    return pluginResult;
}

-(PluginResult *)errInfoToDic:(String)errInfo with:(invokedUrlCommand *)command{
    
    NSString *errString=[self stringWithCString:errInfo];
    NSDictionary *dic=  [self dictionaryWithJsonString:errString];
    
    
    return [self  errorProcess:command code:[dic[@"Code"] intValue] msg:[NSString stringWithFormat:@"err%@",dic[@"Code"]]];
    
}

- (NSDictionary *)parseOneParam:(NSString *)key value:(NSString *)value
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:value forKey:key];
    return dic;
}
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [[jsonString stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\r\\n"] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}

- (NSDictionary *)mkJson:(NSString *)key value:(id)value
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:value forKey:key];
    NSDictionary *resDic = dic;
    return resDic;
    
}
- (NSString *)dicToJSONString:(NSDictionary *)dic
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic
                                                   options:kNilOptions
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}
- (NSString *)arrayToJSONString:(NSArray *)array
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:array
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}
#pragma mark - String Json NSString

- (Json)jsonWithString:(NSString *)string
{
    String std = [self cstringWithString:string];
    Json json;
    try {
        json = Json::parse(std);
    } catch (const std:: exception & e ) {
        NSString *errString=[self stringWithCString:e.what()];
        
    }
    
    return json;
}

- (NSString *)stringWithJson:(Json)json
{
    return [self stringWithCString:json.dump()];
}
//String 转 NSString
- (NSString *)stringWithCString:(String)string
{
    
    NSString *str = [NSString stringWithCString:string.c_str() encoding:NSUTF8StringEncoding];
    return str;
}
- (String)cstringWithString:(NSString *)string
{
    String  str = [string UTF8String];
    return str;
}



#pragma mark - plugin

- (void)pluginInitialize
{
    TAG = @"Wallet";
    mDIDManagerMap  = new DIDManagerMap();
    mDIDManagerSupervisor = NULL;
    mMasterWalletManager = NULL;
    mRootPath = NULL;
    
    keySuccess   = @"success";
    keyError     = @"error";
    keyCode      = @"code";
    keyMessage   = @"message";
    keyException = @"exception";
    
    errCodeParseJsonInAction          = 10000;
    errCodeInvalidArg                 = 10001;
    errCodeInvalidMasterWallet        = 10002;
    errCodeInvalidSubWallet           = 10003;
    errCodeCreateMasterWallet         = 10004;
    errCodeCreateSubWallet            = 10005;
    errCodeRecoverSubWallet           = 10006;
    errCodeInvalidMasterWalletManager = 10007;
    errCodeImportFromKeyStore         = 10008;
    errCodeImportFromMnemonic         = 10009;
    errCodeSubWalletInstance          = 10010;
    errCodeInvalidDIDManager          = 10011;
    errCodeInvalidDID                 = 10012;
    errCodeActionNotFound             = 10013;
    errCodeWalletException            = 20000;
    errCodeMasterWalletAlreadyExist = 20001;
    errCodeInvalidParameters= 20002;
    errCodeInvalidPassword= 20003;
    errCodeWrongPassword= 20004;
    errCodeIDNotFound= 20005;
    errCodeSPVCreateMasterWalletError= 20006;
    errCodeMasterWalletAlreadyExist= 20007;
    errSPVCreateSubWalletError= 20008;
    errParseJsonArrayError= 20009;
    errInvalidMnemonic= 20010;
    errPublickeyFormatError=20011;
    errPublicKeyLengthError=20012;
    errSideShainDepositParametersError=20013;
    errSideChainWithdrawParametersError=20014;
    errTxSizeTooLarge=20015;
    errCreateTxError=20016;
    errInvalidTx=20017;
    errPathDoNotExist=20018;
    errRegisterIDPayloadError=20019;
    errSqliteError=20018;
    errDerivePurposeError=20019;
    errWrongAccountType=20020;
    errWrongNetType=20021;
    errInvalidCoinType=20022;
    errNoCurrentMultiSignAccount=20023;
    errCosignerCountError=20024;
    errMultiSignError=20025;
    errKeyStoreError=20026;
    errLimitGapError=20027;
    errWalletContainInvalidTx=20028;
    errKeyError=20029;
    errHexToStringError=20030;
    errSignTypeError=20031;
    errAddressError=20032;
    errSignError=20033;
    errkeystoreNeedPhrasePassword=20034;
    errBalanceNotEnough=20035;
    errBalanceNotEnough=20036;
    mRootPath = [MyUtil getRootPath];
    const char  *rootPath = [mRootPath UTF8String];
    try {
        if ([SDKNET isEqualToString:@"PrvNet"]){
            String configString("{\"ELA\":{\"ChainParameters\":{\"MagicNumber\":20200501,\"StandardPort\":40008,\"DNSSeeds\":[\"longrunweather.com\"],\"CheckPoints\":[[0,\"d8d33c8a0a632ecc418bd7f09cd315dfc46a7e3e98e48c50c70a253e6062c257\",1513936800,486801407]]}},\"IDChain\":{\"ChainParameters\":{\"MagicNumber\":20200503,\"StandardPort\":41008,\"DNSSeeds\":[\"longrunweather.com\"],\"CheckPoints\":[[0,\"56be936978c261b2e649d58dbfaf3f23d4a868274f5522cd2adb4308a955c4a3\",1530360000,486801407]]}}}");
            nlohmann::json netConfig = nlohmann::json::parse(configString);
            mMasterWalletManager = new MasterWalletManager(rootPath, [self cstringWithString:SDKNET],netConfig);
            
        }else{
            mMasterWalletManager = new MasterWalletManager(rootPath, [self cstringWithString:SDKNET]);
        }
        
        
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return ;
    }
    
}
-(MasterWalletManager *)mMasterWalletManager
{  if(mMasterWalletManager==nil){
    mRootPath = [MyUtil getRootPath];
    const char  *rootPath = [mRootPath UTF8String];
    
    if ([SDKNET isEqualToString:@"PrvNet"]){
        String configString("{\"ELA\":{\"ChainParameters\":{\"MagicNumber\":20200501,\"StandardPort\":40008,\"DNSSeeds\":[\"longrunweather.com\"],\"CheckPoints\":[[0,\"d8d33c8a0a632ecc418bd7f09cd315dfc46a7e3e98e48c50c70a253e6062c257\",1513936800,486801407]]}},\"IDChain\":{\"ChainParameters\":{\"MagicNumber\":20200503,\"StandardPort\":41008,\"DNSSeeds\":[\"longrunweather.com\"],\"CheckPoints\":[[0,\"56be936978c261b2e649d58dbfaf3f23d4a868274f5522cd2adb4308a955c4a3\",1530360000,486801407]]}}}");
        nlohmann::json netConfig = nlohmann::json::parse(configString);
        
        mMasterWalletManager = new MasterWalletManager(rootPath, [self cstringWithString:SDKNET],netConfig);
        
    }else{
        mMasterWalletManager = new MasterWalletManager(rootPath, [self cstringWithString:SDKNET]);
    }
    
}
    
    return mMasterWalletManager;
}
- (PluginResult *)coolMethod:(invokedUrlCommand *)command
{
    PluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    if (echo != nil && [echo length] > 0) {
        pluginResult = [PluginResult resultWithStatus:CommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [PluginResult resultWithStatus:CommandStatus_ERROR];
    }
    return pluginResult;
}
- (PluginResult *)print:(invokedUrlCommand *)command
{
    PluginResult *pluginResult = nil;
    NSString *text = [command.arguments objectAtIndex:0];
    
    if(!text || ![text isEqualToString:@""])
    {
        pluginResult = [PluginResult resultWithStatus:CommandStatus_OK messageAsDictionary:[self parseOneParam:@"text" value:text]];
        
    }
    else
    {
        NSString *error = @"Text not can be null";
        pluginResult = [PluginResult resultWithStatus:CommandStatus_ERROR messageAsString:error];
    }
    return pluginResult;
}

- (PluginResult *)getAllMasterWallets:(invokedUrlCommand *)command
{
    
    //    try{
    NSMutableArray *masterWalletListJson=[[NSMutableArray alloc]init];
    StringVector vectoIDS;
    try {
        vectoIDS = mMasterWalletManager-> GetAllMasterWalletID();
        NSString *sstring;
        for (int i = 0; i < vectoIDS.size(); i++) {
            String string = vectoIDS[i];
            NSString *sstring = [self stringWithCString:string];
            //            IMasterWallet *iMasterWallet = vector[i];
            //            String idStr = iMasterWallet->GetID();
            //            NSString *str = [self stringWithCString:idStr];
            [masterWalletListJson addObject:sstring];
        }
        //             NSString *msg = [self arrayToJSONString:masterWalletListJson];
        return [self successProcess:command msg:masterWalletListJson];
    } catch (const std:: exception &e) {
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return nil;
    }
    
    
    
    //        for (int i = 0; i < vector.size(); i++) {
    //            IMasterWallet *iMasterWallet = vector[i];
    //            String idStr = iMasterWallet->GetID();
    //            NSString *str = [self stringWithCString:idStr];
    //            [masterWalletListJson addObject:str];
    //        }
    //        NSString *msg = [self arrayToJSONString:masterWalletListJson];
    //        //NSLog(@"钱包===%@",msg);
    //        return [self successProcess:command msg:msg];
    //    } catch (const std:: exception & e ) {
    //
    //        NSString *errString=[self stringWithCString:e.what()];
    //        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
    //        [[FLTools share]showErrorInfo:dic[@"Message"]];
    //        return nil;
    //    }
    
}
- (PluginResult *)createMasterWallet:(invokedUrlCommand *)command
{
    int idx = 0;
    NSArray *array = command.arguments;
    
    String masterWalletID = [self cstringWithString:[array objectAtIndex:idx++]];
    String mnemonic       = [self cstringWithString:[array objectAtIndex:idx++]];;
    String phrasePassword = [self cstringWithString:[array objectAtIndex:idx++]];;
    String payPassword    = [self cstringWithString:[array objectAtIndex:idx++]];
    Boolean singleAddress = [[array objectAtIndex:idx++] boolValue];
    
    NSArray *args = command.arguments;
    if (args.count != idx) {
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    
    IMasterWallet *masterWallet;
    try {
        masterWallet = mMasterWalletManager->CreateMasterWallet(
                                                                masterWalletID, mnemonic, phrasePassword, payPassword, singleAddress);
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        
        return [self errInfoToDic:e.what() with:command];
    }
    
    
    if (masterWallet == NULL) {
        NSString *msg = [NSString stringWithFormat:@"Create %@", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeCreateMasterWallet msg:msg];
        
    }
    
    NSString *jsonString = [self getBasicInfo:masterWallet];
    [self createDIDManager:masterWallet];
    return [self successProcess:command msg:jsonString];
    
}

- (PluginResult *)generateMnemonic:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String  language = [self  cstringWithString: args[idx++]];
    //
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeInvalidMasterWalletManager msg:msg];
    }
    String mnemonic;
    try {
        mnemonic = mMasterWalletManager->GenerateMnemonic(language);
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    NSString *mnemonicString = [self stringWithCString:mnemonic];
    NSDictionary *dic = [self mkJson:keySuccess value:mnemonicString];
    
    PluginResult *pluginResult = [PluginResult resultWithStatus:CommandStatus_OK messageAsDictionary:dic];
    return pluginResult;
    
}
- (PluginResult *)createSubWallet:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    long feePerKb         = [args[idx++] boolValue];
    
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    ISubWallet *subWallet;
    try {
        subWallet = masterWallet->CreateSubWallet(chainID);
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Create", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeCreateSubWallet msg:msg];
    }
    Json json;
    try {
        json = subWallet->GetBasicInfo();
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    
    return [self successProcess:command msg:jsonString];
    
}
- (PluginResult *)getAllSubWallets:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil)
    {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    NSMutableArray *subWalletJsonArray = [[NSMutableArray alloc] init];
    ISubWalletVector subWalletList;
    
    
    try {
        subWalletList= masterWallet->GetAllSubWallets();
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    for (int i = 0; i < subWalletList.size(); i++)
    {
        ISubWallet *iSubWallet = subWalletList[i];
        String chainId;
        try {
            chainId = iSubWallet->GetChainID();
        } catch (const std:: exception &e) {
            return [self errInfoToDic:e.what() with:command];
        }
        
        NSString *chainIdString = [self stringWithCString:chainId];
        [subWalletJsonArray addObject:chainIdString];
    }
    NSString *msg = [self arrayToJSONString:subWalletJsonArray];
    return [self successProcess:command msg:msg];
    
}

- (PluginResult *)getBalance:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    long type    = [ args[idx++] intValue];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID :chainID];
    
    
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeCreateSubWallet msg:msg];
        
    }
    uint64_t balance;
    try {
        String balanceSt = subWallet->GetBalance();
        NSString * balanceString= [NSString stringWithCString:balanceSt.c_str() encoding:NSUTF8StringEncoding];
        balance=[balanceString integerValue];
        
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSNumber *balanceStr = [NSNumber numberWithUnsignedLongLong:balance];
    
    return [self successProcess:command msg:balanceStr];
}
- (PluginResult *)getSupportedChains:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    StringVector stringVec;
    try {
        stringVec  = masterWallet->GetSupportedChains();
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < stringVec.size(); i++)
    {
        String string = stringVec[i];
        NSString *sstring = [self stringWithCString:string];
        [stringArray addObject:sstring];
    }
    return [self successProcess:command msg:stringArray];
}

- (PluginResult *)getMasterWalletBasicInfo:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];;
    
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    NSString *jsonString = [self getBasicInfo:masterWallet];
    return [self successProcess:command msg:jsonString];
    
}

- (PluginResult *)getAllTransaction:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    int    start          = [args[idx++] intValue];
    int    count          = [args[idx++] intValue];
    String addressOrTxId  = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID : chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidSubWallet msg:msg];
    }
    Json json;
    try {
        json = subWallet->GetAllTransaction(start, count, addressOrTxId);
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    NSString *jsonString = [self stringWithCString:json.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    
    return [self successProcess:command msg:dic];
    
}
- (PluginResult *)createAddress:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID :chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidSubWallet msg:msg];
    }
    String address;
    
    try {
        address = subWallet->CreateAddress();
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    
    NSString *jsonString = [self stringWithCString:address];
    return [self successProcess:command msg:jsonString];
    
}

- (PluginResult *)getAllSubWalletAddress:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];;
    String chainID        = [self cstringWithString:args[idx++]];;
    
    uint32_t start=[args[idx++] intValue];
    uint32_t count =[args[idx++] intValue];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID :chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidSubWallet msg:msg];
    }
    Json  address;
    try {
        address = subWallet->GetAllAddress(start,count);
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    NSString *jsonString = [self stringWithCString:address.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    
    
    
    return [self successProcess:command msg:dic];
    
}



- (PluginResult *)getGenesisAddress:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];;
    String chainID        = [self cstringWithString:args[idx++]];;
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID :chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidSubWallet msg:msg];
    }
    ISidechainSubWallet *sidechainSubWallet = dynamic_cast<ISidechainSubWallet *>(subWallet);
    if(sidechainSubWallet == nil)
    {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", [self formatWalletNameWithString:masterWalletID other:chainID], @" is not instance of ISidechainSubWallet"];
        return [self errorProcess:command code:errCodeSubWalletInstance msg:msg];
    }
    
    String address ;
    try {
        address = sidechainSubWallet->GetGenesisAddress();
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:address];
    return [self successProcess:command msg:jsonString];
    
}

- (PluginResult *)getMasterWalletPublicKey:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    Json json ;
    try {
        json = masterWallet->GetPubKeyInfo();
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    return [self successProcess:command msg:jsonString];
    
}

- (PluginResult *)exportWalletWithKeystore:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String payPassword = [self cstringWithString:args[idx++]];
    String backupPassword= [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    
    Json json ;
    
    try {
        json = masterWallet->ExportKeystore(backupPassword, payPassword);
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    String str = json.dump();
    NSString *jsonString = [self stringWithCString:json.dump()];
    return [self successProcess:command msg:jsonString];
    
}

- (PluginResult *)exportWalletWithMnemonic:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String backupPassword = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    
    Json json;
    try {
        json = masterWallet->ExportMnemonic(backupPassword);
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return [self successProcess:command msg:jsonString];
    
}
-(PluginResult *)VerifyPayPassword:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String backupPassword = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    
    bool isRight;
    try {
        isRight = masterWallet->VerifyPayPassword(backupPassword);
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *isRightString=@"0";
    if (isRight==true) {
        isRightString=@"1";
    }
    return [self successProcess:command msg:isRightString];
    
}

- (PluginResult *)changePassword:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String oldPassword = [self cstringWithString:args[idx++]];
    String newPassword = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletName:masterWalletID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    
    
    
    try {
        masterWallet->ChangePassword(oldPassword, newPassword);
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    
    return [self successProcess:command msg:@"Change password OK"];
    
}

- (PluginResult *)importWalletWithKeystore:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *  masterWalletIDStr=args[idx++];
    String masterWalletID = [self cstringWithString:masterWalletIDStr];
    
    NSString *keystoreContentStr=args[idx++];
    
    Json keystoreContent = [self jsonWithString:keystoreContentStr];
    String backupPassword = [self cstringWithString:args[idx++]];
    String payPassword = [self cstringWithString:args[idx++]];
    NSString * walletID=args[idx++];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet;
    try {
        masterWallet  = mMasterWalletManager->ImportWalletWithKeystore(
                                                                       masterWalletID, keystoreContent, backupPassword, payPassword);
        
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with keystore"];
        return [self errorProcess:command code:errCodeImportFromKeyStore msg:msg];
    }
    
    NSString *jsonString = [self getBasicInfo:masterWallet];
    [self createDIDManager:masterWallet];
    
    return [self successProcess:command msg:jsonString];
}

- (PluginResult *)importWalletWithMnemonic:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String mnemonic       = [self cstringWithString:args[idx++]];
    String phrasePassword = [self cstringWithString:args[idx++]];
    String payPassword    = [self cstringWithString:args[idx++]];
    Boolean singleAddress =  [args[idx++] boolValue];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    IMasterWallet *masterWallet;
    try {
        masterWallet = mMasterWalletManager->ImportWalletWithMnemonic(
                                                                      masterWalletID, mnemonic, phrasePassword, payPassword, singleAddress);
    } catch (const std:: exception &e) {
        return    [self errInfoToDic:e.what() with:command];
    }
    
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with mnemonic"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    NSString *jsonString = [self getBasicInfo:masterWallet];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    [self createDIDManager:masterWallet];
    return [self successProcess:command msg:jsonString];
    
}
-(PluginResult *)registerWalletListener:(invokedUrlCommand *)command{
    
    NSArray *args = command.arguments;
    int idx = 0;
    NSString * masterWalletIDString=args[idx++];
    
    
    String masterWalletID = [self cstringWithString:masterWalletIDString];
    NSString * chainIDString=args[idx++];
    NSString *MID=[NSString stringWithFormat:@"%@%@",masterWalletIDString,chainIDString];
    if ([self.resListArray containsObject:MID]) {
        return  nil;
    }
    String chainID= [self cstringWithString:chainIDString];
    ISubWallet *subWallet = [self getSubWallet:masterWalletID : chainID];
    NSString *callIDString=[NSString stringWithFormat:@"%@,%@,%@",masterWalletIDString,chainIDString,command.methodName];
    String callBackID=[self cstringWithString:callIDString];
    try {
        ElaSubWalletCallback *callback =new ElaSubWalletCallback(callBackID);
        subWallet->AddCallback(callback);
        [self.resListArray addObject:MID];
    } catch (const std:: exception & e) {
        return   [self errInfoToDic:e.what() with:command];
    }
    
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with mnemonic"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    
    return nil;
    
    
}
- (PluginResult *)DestroySubWallet:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletIDString=args[idx++];
    String masterWalletID = [self cstringWithString:masterWalletIDString];
    NSString *chainIDString=args[idx++];
    String chainID        = [self cstringWithString:chainIDString];
    NSString *MID=[NSString stringWithFormat:@"%@%@",masterWalletIDString,chainIDString];
    if ([self.resListArray containsObject:MID]) {
        [self.resListArray removeObject:MID];
    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    try {
        masterWallet->DestroyWallet(chainID);
    } catch (const std:: exception & e) {
        return     [self errInfoToDic:e.what() with:command];
    }
    return [self successProcess:command msg:@"close OK"];
}
-(PluginResult *)DestroyMasterWallet:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    try {
        mMasterWalletManager ->DestroyWallet(masterWalletID);
        
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    return [self successProcess:command msg:@"DestroyMasterWallet OK"];
}
-(PluginResult *)RemoveCallback:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString * masterWalletIDString=args[idx++];
    String masterWalletID = [self cstringWithString:masterWalletIDString];
    NSString * chainIDString=args[idx++];
    String chainID= [self cstringWithString:chainIDString];
    ISubWallet *subWallet = [self getSubWallet:masterWalletID : chainID];
    NSString *callIDString=[NSString stringWithFormat:@"%@,%@,%@",masterWalletIDString,chainIDString,command.methodName];
    String callBackID=[self cstringWithString:callIDString];
    try {
        subWallet->RemoveCallback();
    } catch (const std:: exception & e) {
        return [self errInfoToDic:e.what() with:command];
    }
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with mnemonic"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
}
-(PluginResult *)CreateTransaction:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    String fromAddress = [self cstringWithString:args[idx++]];
    String toAddress = [self cstringWithString:args[idx++]];
    String amount = [self cstringWithString:args[idx++]];
    String memo = [self cstringWithString:args[idx++]];
    String remark = [self cstringWithString:args[idx++]];
    String PWD = [self cstringWithString:args[idx++]];
    if ([self IsAddressValid:masterWalletID withAddres:toAddress]==NO) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"收款人地址错误", nil),[self stringWithCString:toAddress]];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    Boolean useVotedUTXO =  [args[idx++] boolValue];
    ISubWallet * suWall;
    Json josn;
    suWall = [self getSubWallet:masterWalletID :chainID];
    try {
        josn=suWall->CreateTransaction(fromAddress, toAddress, amount, memo);
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    Json signedTx;
    Json result;
    try {
        signedTx=  suWall->SignTransaction(josn, PWD);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    try {
        result = suWall->PublishTransaction(signedTx);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    [self saveTradingWithhash:dic[@"TxHash"] withTradingType:2 withWalletID:[self stringWithCString:masterWalletID] withChainID:[self stringWithCString:chainID]];
    return [self successProcess:command msg:dic];
}
-(PluginResult *)GetTransactionSignedInfo:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    ISubWallet * suWall;
    Json josn=[self jsonWithString:args[idx++]];
    suWall = [self getSubWallet:masterWalletID :chainID];
    try {
        josn=suWall->GetTransactionSignedInfo(josn);
    } catch (const std:: exception & e) {
        
        [[FLTools share]showErrorInfo:[self stringWithCString:e.what()]];
        return  [self errInfoToDic:e.what() with:command];
        
    }
    NSString *jsonString = [self stringWithCString:josn.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
    
}
-(PluginResult *)MSignAndReadOnlyCreateTransaction:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    String fromAddress = [self cstringWithString:args[idx++]];
    String toAddress = [self cstringWithString:args[idx++]];
    String amount = [self cstringWithString:args[idx++]];
    String memo = [self cstringWithString:args[idx++]];
    String remark = [self cstringWithString:args[idx++]];
    String PWD = [self cstringWithString:args[idx++]];
    if ([self IsAddressValid:masterWalletID withAddres:toAddress]==NO) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"收款人地址错误", nil),[self stringWithCString:toAddress]];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    Boolean useVotedUTXO =  [args[idx++] boolValue];
    ISubWallet * suWall;
    Json josn;
    suWall = [self getSubWallet:masterWalletID :chainID];
    try {
        josn=suWall->CreateTransaction(fromAddress, toAddress, amount, memo);
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:josn.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
-(PluginResult *)QrCodeCreateTransaction:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    String fromAddress = [self cstringWithString:args[idx++]];
    String toAddress = [self cstringWithString:args[idx++]];
    String amount = [self cstringWithString:args[idx++]];
    String memo = [self cstringWithString:args[idx++]];
    String remark = [self cstringWithString:args[idx++]];
    String PWD = [self cstringWithString:args[idx++]];
    ISubWallet * suWall;
    Json josn;
    
    
    suWall = [self getSubWallet:masterWalletID :chainID];
    try {
        josn=suWall->CreateTransaction(fromAddress, toAddress, amount, memo);
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    Json signedTx;
    Json result;
    
    try {
        signedTx=  suWall->SignTransaction(josn, PWD);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    NSString *jsonString = [self stringWithCString:signedTx.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
    
}
-(PluginResult *)SignTransaction:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    Json json             = [self jsonWithString:args[idx++]];
    String PWD = [self cstringWithString:args[idx++]];
    ISubWallet * suWall;
    suWall = [self getSubWallet:masterWalletID :chainID];
    Json signedTx;
    try {
        signedTx=  suWall->SignTransaction(json, PWD);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:signedTx.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
    
}
-(PluginResult *)accessFees:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    String fromAddress = [self cstringWithString:args[idx++]];
    fromAddress=[self cstringWithString:@""];
    NSString *toAddressString=args[idx++];
    String toAddress = [self cstringWithString:toAddressString];
    //    NSString * am=[[FLTools share]CRVotingDecimalNumberByMultiplying:args[idx++] withCRMermVoting:[NSString stringWithFormat:@"%d",unitNumber]];
    
    String amount = [self cstringWithString:args[idx++]];
    NSString *memoString=args[idx++];
    if (memoString.length==0) {
        memoString=@"11";
    }
    if (toAddressString.length>0) {
        if ([self IsAddressValid:masterWalletID withAddres:toAddress]==NO) {
            NSString *msg = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"收款人地址错误", nil),[self stringWithCString:toAddress]];
            return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
        }
    }else{
        toAddress = [self cstringWithString:@"EXwi9RYP2MP5gjiemqv5vhFq3M6coNCEZr"];
    }
    
    String memo =[self cstringWithString:memoString];
    
    String remark = [self cstringWithString:args[idx++]];
    Boolean useVotedUTXO =  [args[idx++] boolValue];
    //    String PWD = [self cstringWithString:args[idx++]];
    ISubWallet * suWall = [self getSubWallet:masterWalletID :chainID];
    Json josn;
    
    uint64_t fee;
    try {
        josn=suWall->CreateTransaction(fromAddress, toAddress, amount, memo);
        
    } catch (const std:: exception & err) {
        return [self errInfoToDic:err.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:josn.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    
    
    return [self successProcess:command msg:[NSString stringWithFormat:@"%@",dic[@"Fee"]]];
}

-(PluginResult *)sideChainTop_Up:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String fromSubWalletID        = [self cstringWithString:args[idx++]];
    String toSubWalletID = [self cstringWithString:args[idx++]];
    String from = [self cstringWithString:args[idx++]];
    String sidechainAddress = [self cstringWithString:args[idx++]];
    String amount = [self cstringWithString:args[idx++]];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    String pwd=[self cstringWithString:args[idx++]];
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    IMainchainSubWallet *mainchainSubWallet = dynamic_cast<IMainchainSubWallet *>(fromSubWallet);
    Json tx;
    try {
        tx  =mainchainSubWallet->CreateDepositTransaction("","IDChain" , amount, sidechainAddress,memo);
    } catch (const std:: exception & e) {
        return [self errInfoToDic:e.what() with:command];
    }
    Json result;
    Json signedTx;
    Json tmpTx;
    try {
        signedTx=  fromSubWallet->SignTransaction(tx, pwd);
    } catch (const std:: exception & e ) {
        return [self errInfoToDic:e.what() with:command];
    }
    try {
        result = fromSubWallet->PublishTransaction(signedTx);
    } catch (const std:: exception & e ) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    [self saveTradingWithhash:dic[@"TxHash"] withTradingType:6 withWalletID:[self stringWithCString:masterWalletID] withChainID:@"ELA"];
    return [self successProcess:command msg:dic];
}
-(PluginResult *)sideChainTop_UpFee:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String fromSubWalletID        = [self cstringWithString:args[idx++]];
    String toSubWalletID = [self cstringWithString:args[idx++]];
    String from = [self cstringWithString:args[idx++]];
    String sidechainAddress = [self cstringWithString:args[idx++]];
    String amount = [self cstringWithString:args[idx++]];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    String pwd=[self cstringWithString:args[idx++]];
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    IMainchainSubWallet *mainchainSubWallet = dynamic_cast<IMainchainSubWallet *>(fromSubWallet);
    Json tx;
    try {
        tx  =mainchainSubWallet->CreateDepositTransaction("","IDChain" , amount, sidechainAddress,memo);
    } catch (const std:: exception & e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:tx.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return  [self successProcess:command msg:[NSString stringWithFormat:@"%@",dic[@"Fee"]]];
}
-(PluginResult *)mainChainWithdrawal:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String fromSubWalletID = [self cstringWithString:args[idx++]];
    String from = [self cstringWithString:args[idx++]];
    String mainchainAddress = [self cstringWithString:args[idx++]];
    NSString *  amountString=args[idx++];
    String amount = [self cstringWithString: amountString];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    String pwd=[self cstringWithString:args[idx++]];
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    ISidechainSubWallet *sidechainSubWallet = dynamic_cast<ISidechainSubWallet *>(fromSubWallet);
    Json tx;
    try {
        tx=sidechainSubWallet->CreateWithdrawTransaction("", amount, mainchainAddress, memo);
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    Json signedTx;
    Json  result;
    Json retJson;
    try {
        retJson=  fromSubWallet->SignTransaction(tx, pwd);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    try {
        result = fromSubWallet->PublishTransaction(retJson);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    [self saveTradingWithhash:dic[@"TxHash"] withTradingType:7 withWalletID:[self stringWithCString:masterWalletID] withChainID:@"IDChain"];
    return [self successProcess:command msg:dic];
}
-(PluginResult *)mainChainWithdrawalFee:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String fromSubWalletID = [self cstringWithString:args[idx++]];
    
    String from = [self cstringWithString:args[idx++]];
    String mainchainAddress = [self cstringWithString:args[idx++]];
    String amount = [self cstringWithString:args[idx++]];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    ISidechainSubWallet *sidechainSubWallet = dynamic_cast<ISidechainSubWallet *>(fromSubWallet);
    Json tx;
    try {
        tx=sidechainSubWallet->CreateWithdrawTransaction("", amount, mainchainAddress, memo);
    } catch (const std:: exception & e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:tx.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:[NSString stringWithFormat:@"%@",dic[@"Fee"]]];
}
-(IMainchainSubWallet*)getWalletELASubWallet:(NSString*)masterWalletID{
    
    IMasterWallet *masterWallet = mMasterWalletManager->GetMasterWallet([masterWalletID UTF8String]);
    ISubWalletVector subWalletList = masterWallet->GetAllSubWallets();
    ISubWallet *subWallet = subWalletList[0];
    IMainchainSubWallet *mainchainSubWallet = dynamic_cast<IMainchainSubWallet *>(subWallet);
    return mainchainSubWallet;
}
//参加投票
-(NSInteger)RegisterCRWithMainchainSubWallet:(NSString*)ELA With:(FLJoinVoteInfoModel*)model{
    Json payload;
    Json tx;
    Json signedTx;
    Json result;
    std::string crPublicKey,did;
    String acount=[self cstringWithString:[NSString stringWithFormat:@"%ld",model.acount*unitNumber]];
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:ELA];
    try {
        IIdChainSubWallet *iidChainSubWallet=[self getIdChainSubWallet:[self cstringWithString:ELA]:"IDChain"];
        crPublicKey = iidChainSubWallet->GetAllPublicKeys(0, 1)["PublicKeys"][0];
        did = iidChainSubWallet->GetPublicKeyDID(crPublicKey);
        nlohmann::json payload = mainchainSubWallet->GenerateCRInfoPayload(crPublicKey,[model.DIDString UTF8String],[self cstringWithString:model.nickName],[self cstringWithString:model.url],[model.contryCode intValue]);
        std::string digest = payload["Digest"].get<std::string>();
        std::string signature = iidChainSubWallet->SignDigest(did, digest,[self cstringWithString:model.pwd]);
        payload["Signature"] = signature;
        nlohmann::json tx = mainchainSubWallet->CreateRegisterCRTransaction("", payload, acount,"");
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [model.pwd UTF8String]);
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *dic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:dic[@"TxHash"] withTradingType:33 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        return [dic[@"Fee"] integerValue];
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return -1;
    }
}

//参加投票
-(NSInteger)RegisterProducerWithMainchainSubWallet:(IMainchainSubWallet*)ELA With:(FLJoinVoteInfoModel*)model{
    Json payload;
    Json tx;
    uint64_t fee;
    Json signedTx;
    Json result;
    try {
        payload= ELA->GenerateProducerPayload([model.pubKey UTF8String], [model.nodePubKey UTF8String],[model.nickName UTF8String], [model.url UTF8String], [model.ipAddress UTF8String], [model.contryCode intValue] , [model.pwd UTF8String]);
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return -1;
    }
    String acount=[self cstringWithString:[NSString stringWithFormat:@"%ld",model.acount*unitNumber]];
    try {
        
        tx = ELA->CreateRegisterProducerTransaction("", payload, acount,[model.mark UTF8String]);
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return -1;
    }
    
    try {
        signedTx = ELA->SignTransaction(tx, [model.pwd UTF8String]);
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return -1;
    }
    try {
        result = ELA->PublishTransaction(signedTx);
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return -1;
    }
    NSString *resultString=[self stringWithCString:result.dump()];
    NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
    [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:9 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
    
    return [resultdic[@"Fee"] integerValue];
}
-(NSInteger)UpdateProducerWithMainchainSubWallet:(IMainchainSubWallet*)ELA With:(FLJoinVoteInfoModel*)model
{
    try {
        std::string pubKey = ELA->GetOwnerPublicKey();
        std::string nodePublicKey = [model.ownerPublickKey UTF8String];
        std::string nickName = [model.nickName UTF8String];
        std::string url = [model.url UTF8String];
        std::string ipAddress = [model.ipAddress UTF8String];
        uint64_t location =model.contryCode.intValue;
        
        nlohmann::json payload = ELA->GenerateProducerPayload(pubKey, nodePublicKey, nickName, url, ipAddress,
                                                              location, [model.pwd UTF8String]);
        
        nlohmann::json tx = ELA->CreateUpdateProducerTransaction("", payload,[model.mark UTF8String]);
        Json signedTx = ELA->SignTransaction(tx, [model.pwd UTF8String]);
        
        Json result = ELA->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:11 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        
        return YES;
        
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return NO;
    }
    return YES;
}

-(BOOL)UpdateCRProducerWithMainchainSubWallet:(NSString*)ELA With:(FLJoinVoteInfoModel*)model
{
    
    Json payload;
    Json tx;
    Json signedTx;
    Json result;
    std::string crPublicKey,cid;
    String acount=[self cstringWithString:[NSString stringWithFormat:@"%ld",model.acount*unitNumber]];
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:ELA];
    try {
        IIdChainSubWallet *iidChainSubWallet=[self getIdChainSubWallet:[self cstringWithString:ELA]:"IDChain"];
        crPublicKey = iidChainSubWallet->GetAllPublicKeys(0, 1)["PublicKeys"][0];
        cid= iidChainSubWallet->GetPublicKeyCID(crPublicKey);
        nlohmann::json payload =
        mainchainSubWallet->GenerateCRInfoPayload(crPublicKey,[model.DIDString UTF8String],[model.nickName UTF8String],[self cstringWithString:model.url],[model.contryCode intValue]);
        std::string digest = payload["Digest"].get<std::string>();
        std::string signature = iidChainSubWallet->SignDigest([model.DIDString UTF8String], digest,[self cstringWithString:model.pwd]);
        payload["Signature"] = signature;
        nlohmann::json tx = mainchainSubWallet->CreateUpdateCRTransaction("", payload,"");
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [model.pwd UTF8String]);
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:35 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        return YES;
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return 0;
    }
}
-(BOOL)CancelCRProducer:(NSString*)mainchainSubWalletId Pwd:(NSString*)pwd withDIDinfo:(NSString*)didInfo{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    try {
        IIdChainSubWallet *iidChainSubWallet=[self getIdChainSubWallet:[self cstringWithString:mainchainSubWalletId]:"IDChain"];
        Json info=  mainchainSubWallet->GetRegisteredCRInfo();
        NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
        NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        std::string did=[param[@"Info"][@"CID"] UTF8String];
        nlohmann::json payload = mainchainSubWallet->GenerateUnregisterCRPayload(did);
        std::string digest = payload["Digest"].get<std::string>();
        std::string signature = iidChainSubWallet->SignDigest(did, digest,[self cstringWithString:pwd]);
        payload["Signature"] = signature;
        nlohmann::json tx = mainchainSubWallet->CreateUnregisterCRTransaction("", payload, "");
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:34 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return NO;
    }
    return YES;
}
-(BOOL)CancelProducer:(NSString*)mainchainSubWalletId Pwd:(NSString*)pwd{
    
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    
    try {
        std::string pubKey = mainchainSubWallet->GetOwnerPublicKey();
        nlohmann::json payload = mainchainSubWallet->GenerateCancelProducerPayload(pubKey, [pwd UTF8String]);
        
        nlohmann::json tx = mainchainSubWallet->CreateCancelProducerTransaction("", payload, "");
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:10 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        return YES;
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return NO;
    }
    return YES;
    
    
}
-(NSDictionary*)RetrieveCRDepositTransactionFee:(NSString*)mainchainSubWalletId acount:(NSString*)acount Pwd:(NSString*)pwd{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    // 少一个备注的参数
    String acountS=[self cstringWithString:[[FLTools share]elsToSela:acount ]];
    Json payload;
    Json tx;
    Json signedTx;
    Json result;
    std::string crPublicKey,did;
    try {
        IIdChainSubWallet *iidChainSubWallet=[self getIdChainSubWallet:[self cstringWithString:mainchainSubWalletId]:"IDChain"];
        crPublicKey = iidChainSubWallet->GetAllPublicKeys(0, 1)["PublicKeys"][0];
        did = iidChainSubWallet->GetPublicKeyDID(crPublicKey);
        nlohmann::json payload = mainchainSubWallet->CreateRetrieveCRDepositTransaction(crPublicKey,acountS,"");
        NSString *txtring=[self stringWithCString:payload.dump()];
        NSDictionary *txdic=  [self dictionaryWithJsonString:txtring];
        return @{@"fee":txdic[@"Fee"],@"JSON":txtring};
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return @{@"fee":@"-1",@"JSON":@""};
    }
    
    
}
-(BOOL)RetrieveCRDepositTransaction:(NSString*)mainchainSubWalletId acount:(double)acount Pwd:(NSString*)pwd withJSONString:(NSString*)jsonstring{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    // 少一个备注的参数
    String acountS=[self cstringWithString:[NSString stringWithFormat:@"%.0f",acount*unitNumber]];
    Json payload;
    Json tx;
    Json signedTx;
    Json result;
    std::string crPublicKey,did;
    try {
        //                    IIdChainSubWallet *iidChainSubWallet=[self getIdChainSubWallet:[self cstringWithString:mainchainSubWalletId]:"IDChain"];
        //                    crPublicKey = iidChainSubWallet->GetAllPublicKeys(0, 1)["PublicKeys"][0];
        //                    did = iidChainSubWallet->GetPublicKeyDID(crPublicKey);
        nlohmann::json payload = [self jsonWithString:jsonstring];
        Json signedTx = mainchainSubWallet->SignTransaction(payload, [pwd UTF8String]);
        
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:36 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        return YES;
        
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return NO;
    }
}
-(NSDictionary*)RetrieveDepositFee:(NSString*)mainchainSubWalletId acount:(NSString*)acount Pwd:(NSString*)pwd{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    // 少一个备注的参数
    String acountS=[self cstringWithString:[[FLTools share]elsToSela:acount ]];
    try {
        nlohmann::json tx = mainchainSubWallet->CreateRetrieveDepositTransaction(acountS,"");
        NSString *txtring=[self stringWithCString:tx.dump()];
        NSDictionary *txdic=  [self dictionaryWithJsonString:txtring];
        return @{@"fee":txdic[@"Fee"],@"JSON":txtring};
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return @{@"fee":@"-1",@"JSON":@""};
    }
    
    
}
-(BOOL)RetrieveDeposit:(NSString*)mainchainSubWalletId acount:(double)acount Pwd:(NSString*)pwd withJSONString:(NSString*)jsonString{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    // 少一个备注的参数
    String acountS=[self cstringWithString:[NSString stringWithFormat:@"%.0f",acount*unitNumber]];
    try {
        
        Json tx=  [self jsonWithString:jsonString];
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:12 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        return YES;
        
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return NO;
    }
    return YES;
}
-(NSDictionary *)CRVoteFeeCRMainchainSubWallet:(NSString*)CRmainchainSubWalletId ToVote:(NSDictionary*)publicKeys tickets:(double)stake withInvalidIDArray:(NSArray*)InvalidArr{
    
    String keys = [[ self dicToJSONString:publicKeys] UTF8String];
    NSString *InvalidString=[self arrayToJSONString:InvalidArr];
    Json InvalidJson=  [self jsonWithString:InvalidString];
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:CRmainchainSubWalletId];
    String acount;
    try {
        Json tx = mainchainSubWallet->CreateVoteCRTransaction("",Json::parse(keys),"",InvalidJson);
        NSString *resultString=[self stringWithCString:tx.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        NSArray *DorpVotes=resultdic[@"DropVotes"];
        return @{@"fee":resultdic[@"Fee"],@"JSON":resultString,@"DorpVotes":DorpVotes};
    } catch (const std:: exception & e ) {
        
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return @{@"fee":@"-1",@"JSON":@""};
    }
    
}

-(BOOL)useCRMainchainSubWallet:(NSString*)CRmainchainSubWalletId WithJosnString:(NSString*)josnString withPWD:(NSString*)pwd{
    Json tx=[self jsonWithString:josnString];
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:CRmainchainSubWalletId];
    try {
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:1002 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        return YES;
        
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];;
        return NO;
    }
    return YES;
    
}
-(NSDictionary *)DopsVoteFeeCRMainchainSubWallet:(NSString*)CRmainchainSubWalletId ToVote:(NSArray*)publicKeys tickets:(double)stake withInvalidIDArray:(NSArray*)InvalidArr{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:CRmainchainSubWalletId];
    String keys = [[ self arrayToJSONString:publicKeys] UTF8String];
    NSString *InvalidString=[self arrayToJSONString:InvalidArr];
    Json InvalidJson=  [self jsonWithString:InvalidString];
    String acount;
    if (stake==-1) {
        acount="-1";
    }else{
        acount =[self cstringWithString:[NSString stringWithFormat:@"%.0f",stake*unitNumber]];
    }
    try {
        nlohmann::json tx = mainchainSubWallet->CreateVoteProducerTransaction("", acount,Json::parse(keys),"",InvalidJson);
        NSString *resultString=[self stringWithCString:tx.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        NSArray *DorpVotes=resultdic[@"DropVotes"];
        return @{@"fee":resultdic[@"Fee"],@"JSON":resultString,@"DorpVotes":DorpVotes};
        
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return @{@"fee":@"-1",@"JSON":@""};
    }
    
    
}
-(BOOL)useMainchainSubWallet:(NSString*)mainchainSubWalletId WithJsonString:(NSString*)jsonstring pwd:(NSString*)pwd{
    nlohmann::json tx=[self jsonWithString:jsonstring] ;
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    String acount;
    
    // 少一个备注
    try {
        
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *resultString=[self stringWithCString:result.dump()];
        NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:1001 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
        return YES;
        
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return NO;
    }
    return YES;
}
-(BOOL)useMainchainSubWallet:(NSString*)mainchainSubWalletId ToVote:(NSArray*)publicKeys tickets:(double)stake pwd:(NSString*)pwd isChangeVote:(BOOL)change withInvalidIDArray:(NSArray*)InvalidArr{
    NSString *InvalidString=[self arrayToJSONString:InvalidArr];
    Json InvalidJson=  [self jsonWithString:InvalidString];{
        String keys = [[ self arrayToJSONString:publicKeys] UTF8String];
        nlohmann::json tx ;
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
        String acount;
        if (stake==-1) {
            acount="-1";
        }else{
            acount =[self cstringWithString:[NSString stringWithFormat:@"%.0f",stake*unitNumber]];
        }
        // 少一个备注
        try {
            nlohmann::json tx = mainchainSubWallet->CreateVoteProducerTransaction("", acount,Json::parse(keys),"",InvalidJson);
            Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
            Json result = mainchainSubWallet->PublishTransaction(signedTx);
            NSString *resultString=[self stringWithCString:result.dump()];
            NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
            [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:1001 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
            return YES;
            
        } catch (const std:: exception & e ) {
            NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
            NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
            [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
            return NO;
        }
        return YES;
    }
    
}

//-(PluginResult *)SignReadOnlyToCR:(invokedUrlCommand *)command{
//
////    self.wallet.masterWalletID,stringArray,@(tic),pwd,@(1)
//    NSArray *args = command.arguments;
//    int idx = 0;
//    NSString * masterWalletID =args[idx++];
//    NSArray * publicKeys = args[idx++];
//    double stake = [ args[idx++] doubleValue] ;
//    NSString *pwd=args[idx++];
//    BOOL chenge=[args[idx++] boolValue];
//    String keys = [[ self arrayToJSONString:publicKeys] UTF8String];
//    nlohmann::json tx ;
//    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet: masterWalletID];
//    String acount=[self cstringWithString:[NSString stringWithFormat:@"%.0f",stake*unitNumber]];
//    Json result;
//    // 少一个备注
//    try {
//        result= mainchainSubWallet->CreateVoteCRTransaction("",Json::parse(keys),"");
//    } catch (const std:: exception & e ) {
//        NSString *errString=[self stringWithCString:e.what()];
//        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
//        [[FLTools share]showErrorInfo:dic[@"Message"]];
//        return [self errInfoToDic:e.what() with:command];
//    }
//    NSString *jsonString = [self stringWithCString:result.dump()];
//    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
//    return [self successProcess:command msg:dic];
//}
//-(PluginResult *)HowSignToCR:(invokedUrlCommand *)command{
//    NSArray *args = command.arguments;
//    int idx = 0;
//    NSString * masterWalletID =args[idx++];
//    NSArray * publicKeys = args[idx++];
//    double stake = [args[idx++] doubleValue];
//    NSString *pwd=args[idx++];
//    BOOL chenge=[args[idx++] boolValue];
//    String keys = [[ self arrayToJSONString:publicKeys] UTF8String];
//    nlohmann::json tx ;
//    Json signedTx;
//    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
//    String acount=[self cstringWithString:[NSString stringWithFormat:@"%.0f",stake*unitNumber]];
//    // 少一个备注
//    try {
//      tx= mainchainSubWallet->CreateVoteCRTransaction("",Json::parse(keys),"");
//    signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
//
//
//    } catch (const std:: exception & e ) {
//        NSString *errString=[self stringWithCString:e.what()];
//        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
//        [[FLTools share]showErrorInfo:dic[@"Message"]];
//       return [self errInfoToDic:e.what() with:command];
//
//    }
//
//    NSString *jsonString = [self stringWithCString:signedTx.dump()];
//    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
//     return [self successProcess:command msg:dic];
//}

//-(PluginResult *)SignReadOnlyToVote:(invokedUrlCommand *)command{
//
////    self.wallet.masterWalletID,stringArray,@(tic),pwd,@(1)
//    NSArray *args = command.arguments;
//    int idx = 0;
//    NSString * masterWalletID =args[idx++];
//    NSArray * publicKeys = args[idx++];
//    double stake = [ args[idx++] doubleValue] ;
//    NSString *pwd=args[idx++];
//    BOOL chenge=[args[idx++] boolValue];
//    String keys = [[ self arrayToJSONString:publicKeys] UTF8String];
//    nlohmann::json tx ;
//    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet: masterWalletID];
//    String acount=[self cstringWithString:[NSString stringWithFormat:@"%.0f",stake*unitNumber]];
//    Json result;
//    // 少一个备注
//    try {
//           result = mainchainSubWallet->CreateVoteProducerTransaction("", acount,Json::parse(keys),"");
//    } catch (const std:: exception & e ) {
//        NSString *errString=[self stringWithCString:e.what()];
//        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
//        [[FLTools share]showErrorInfo:dic[@"Message"]];
//        return [self errInfoToDic:e.what() with:command];
//    }
//    NSString *jsonString = [self stringWithCString:result.dump()];
//    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
//    return [self successProcess:command msg:dic];
//}
//-(PluginResult *)HowSignToVote:(invokedUrlCommand *)command{
//    NSArray *args = command.arguments;
//    int idx = 0;
//    NSString * masterWalletID =args[idx++];
//    NSArray * publicKeys = args[idx++];
//    double stake = [args[idx++] doubleValue];
//    NSString *pwd=args[idx++];
//    BOOL chenge=[args[idx++] boolValue];
//    String keys = [[ self arrayToJSONString:publicKeys] UTF8String];
//    nlohmann::json tx ;
//    Json signedTx;
//    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
//    String acount=[self cstringWithString:[NSString stringWithFormat:@"%.0f",stake*unitNumber]];
//    // 少一个备注
//    try {
//        tx = mainchainSubWallet->CreateVoteProducerTransaction("", acount,Json::parse(keys),"");
//    signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
//
//
//    } catch (const std:: exception & e ) {
//        NSString *errString=[self stringWithCString:e.what()];
//        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
//        [[FLTools share]showErrorInfo:dic[@"Message"]];
//       return [self errInfoToDic:e.what() with:command];
//
//    }
//
//    NSString *jsonString = [self stringWithCString:signedTx.dump()];
//    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
//     return [self successProcess:command msg:dic];
//}
-(PluginResult *)GetAssetDetails:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];
    String assetID = [self cstringWithString:args[idx++]];
    ISubWallet *subWallet=[self getSubWallet:masterWalletID  :chainID];
    Json result;
    try {
        result=subWallet->GetAssetInfo(assetID);
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
-(NSString *)GetOwnerAddressWithID:(NSString*)masterWalletID{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
    NSString * OwnerAddress;
    try {
        OwnerAddress=OwnerAddress=[self stringWithCString:  mainchainSubWallet->GetOwnerAddress()];
    } catch (const std:: exception &e) {
    }
    
    return OwnerAddress;
    
}
-(PluginResult *)GetAllCoinBaseTransaction:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    int    start          = [args[idx++] intValue];
    int    count          = [args[idx++] intValue];
    String addressOrTxId  = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID : chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidSubWallet msg:msg];
    }
    Json json;
    try {
        json = subWallet->GetAllCoinBaseTransaction(start, count, addressOrTxId);
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    NSString *jsonString = [self stringWithCString:json.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    
    
    return [self successProcess:command msg:dic];
    
}
-(PluginResult *)CreateCombineUTXOTransactionFeeAndJSONString:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID : chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidSubWallet msg:msg];
    }
    Json json;
    try {
        json = subWallet->CreateConsolidateTransaction("");
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    NSDictionary *feeAndJson=@{@"fee":dic[@"Fee"],@"jsonString":jsonString};
    
    return [self successProcess:command msg:feeAndJson];
}
-(PluginResult *)CreateCombineUTXOTransaction:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    Json json             = [self jsonWithString:args[idx++]];
    String PWD        = [self cstringWithString:args[idx++]];
    
    if (args.count != idx) {
        
        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
    }
    ISubWallet *subWallet = [self getSubWallet:masterWalletID : chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidSubWallet msg:msg];
    }
    
    
    Json signedTx;
    Json result;
    try {
        signedTx=  subWallet->SignTransaction(json, PWD);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    try {
        result = subWallet->PublishTransaction(signedTx);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    [self saveTradingWithhash:dic[@"TxHash"] withTradingType:1003 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
    return [self successProcess:command msg:dic];
}
-(PluginResult *)GetAllUTXOs:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];
    ISubWallet *subWallet=[self getSubWallet:masterWalletID  :chainID];
    Json result;
    try {
        result=subWallet->GetAllUTXOs(0,1,"");
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
    
}
-(PluginResult *)CreateMultiSignMasterWalletMnemonic:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String mnemonic = [self cstringWithString:args[idx++]];
    String phrasePassword = [self cstringWithString:args[idx++]];
    String payPassword = [self cstringWithString:args[idx++]];
    NSArray *publicKeys=[NSArray arrayWithArray:args[idx++]];
    Json publicKeysJson;
    String pkeyS;
    for (NSString * pkey in publicKeys ) {
        pkeyS=[self cstringWithString:pkey];
        publicKeysJson.push_back(pkeyS);
    }
    int   m=[args[idx++] intValue];
    bool SingleAddress=false;
    if ([args[idx++] intValue]==1) {
        SingleAddress=true;
    }
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeInvalidMasterWalletManager msg:msg];
    }
    IMasterWallet *masterWallet;
    try {
        
        masterWallet = mMasterWalletManager->CreateMultiSignMasterWallet(masterWalletID,mnemonic,phrasePassword,payPassword,publicKeysJson,m,SingleAddress);
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with mnemonic"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    NSString *jsonString = [self getBasicInfo:masterWallet];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return [self successProcess:command msg:jsonString];
}
-(PluginResult *)CreateMultiSignMasterWalletmasterReadonly:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    NSArray *publicKeys=[NSArray arrayWithArray:args[idx++]];
    Json publicKeysJson;
    String pkeyS;
    for (NSString * pkey in publicKeys ) {
        pkeyS=[self cstringWithString:pkey];
        publicKeysJson.push_back(pkeyS);
    }
    int   m=[args[idx++] intValue];
    bool SingleAddress=false;
    if ([args[idx++] intValue]==1) {
        SingleAddress=true;
    }
    
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeInvalidMasterWalletManager msg:msg];
    }
    IMasterWallet *masterWallet;
    try {
        
        masterWallet = mMasterWalletManager->CreateMultiSignMasterWallet(masterWalletID,publicKeysJson,m,SingleAddress);
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with mnemonic"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    NSString *jsonString = [self getBasicInfo:masterWallet];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return [self successProcess:command msg:jsonString];
}
-(PluginResult *)CreateMultiSignMasterWalletmasterMasterWalletId:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String xprv=[self cstringWithString:args[idx++]];
    String payPassword=[self cstringWithString:args[idx++]];
    NSArray *publicKeys=[NSArray arrayWithArray:args[idx++]];
    Json publicKeysJson;
    String pkeyS;
    for (NSString * pkey in publicKeys ) {
        pkeyS=[self cstringWithString:pkey];
        publicKeysJson.push_back(pkeyS);
    }
    int   m=[args[idx++] intValue];
    bool SingleAddress=false;
    if ([args[idx++] intValue]==1) {
        SingleAddress=true;
    }
    
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeInvalidMasterWalletManager msg:msg];
    }
    IMasterWallet *masterWallet;
    try {
        masterWallet = mMasterWalletManager->CreateMultiSignMasterWallet(masterWalletID,xprv,payPassword,publicKeysJson,m,SingleAddress);
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with WalletId"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    NSString *jsonString = [self getBasicInfo:masterWallet];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return [self successProcess:command msg:jsonString];
}
-(PluginResult *)CreateImportReadonlyWallet:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    Json walletJson=[self jsonWithString:args[idx++]];
    IMasterWallet * masterWallet;
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    try {
        masterWallet = mMasterWalletManager->ImportReadonlyWallet(masterWalletID,walletJson);
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with WalletId"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    NSString *jsonString = [self getBasicInfo:masterWallet];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return [self successProcess:command msg:jsonString];
}
-(PluginResult *)ExportReadonlyWallet:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with WalletId"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    Json reuslt;
    try {
        reuslt = masterWallet->ExportReadonlyWallet();
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    NSString *jsonString = [self stringWithCString:reuslt.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}

-(NSString *)ExportxPrivateKey:(invokedUrlCommand *)command{
    
    
    NSLog(@"xxl for ExportxPrivateKey");
    
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String payPassword=[self cstringWithString:args[idx++]];
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return nil;
    }
    IMasterWallet *masterWallet;
    try {
        masterWallet = mMasterWalletManager->GetMasterWallet(masterWalletID);
    } catch (const std:: exception &e) {
        
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with WalletId"];
        
    }
    String XPK;
    try {
        XPK = masterWallet->ExportPrivateKey(payPassword);
    } catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return [self stringWithCString:XPK];
}
-(void)EMWMFlushData{
    mMasterWalletManager->FlushData();
}
-(NSString*)EMWMGetVersion{
    String  Version=mMasterWalletManager->GetVersion();
    return [self stringWithCString:Version];
}
-(BOOL)IsAddressValid:(String)masID withAddres:(String)address{
    
    IMasterWallet *masterWallet = [self getIMasterWallet:masID];
    return  masterWallet->IsAddressValid(address);
    
}
-(void)SyncStart:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];;
    ISubWallet *subWallet=[self getSubWallet:masterWalletID  :chainID];
    
    
    try {
        if (subWallet) {
            subWallet->SyncStart();
        }
    } catch (const std:: exception &e) {
        
    }
    
}
-(PluginResult *)ExportMasterPublicKey:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with WalletId"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    std:: string jsonString;
    try {
        jsonString = masterWallet->ExportMasterPublicKey();
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    NSString *jsonNString = [self stringWithCString:jsonString];
    
    return [self successProcess:command msg:jsonNString];
}
-(PluginResult *)VerifyPassPhrase:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String passphrase = [self cstringWithString:args[idx++]];
    String payPasswd = [self cstringWithString:args[idx++]];
    if (mMasterWalletManager == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@", @"Master wallet manager has not initialize"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@ %@", @"Import", [self formatWalletName:masterWalletID], @"with WalletId"];
        return [self errorProcess:command code:errCodeImportFromMnemonic msg:msg];
    }
    bool isR;
    try {
        isR = masterWallet->VerifyPassPhrase(passphrase,payPasswd);
    } catch (const std:: exception &e) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *isRString=@"0";
    if (isR==true) {
        isRString=@"1";
    }
    
    
    return [self successProcess:command msg:isRString];
}

-(PluginResult *)getDIDlist:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    int    start          = [args[idx++] intValue];
    int    count          = [args[idx++] intValue];
    IIdChainSubWallet *idChainSubW=[self getIdChainSubWallet:masterWalletID:chainID];
    Json result;
    try {
        result =  idChainSubW->GetAllDID(start, count);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
//-(PluginResult *)GetRegisteredCRInfo:(invokedUrlCommand *)command{
//    NSArray *args = command.arguments;
//    int idx = 0;
// 
//      IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:args[idx++]];
//  
//    
//    std:: string jsonString;
//    try {
//        jsonString = mainchainSubWallet->GetRegisteredCRInfo();
//    } catch (const std:: exception &e) {
//        return  [self errInfoToDic:e.what() with:command];
//    }
//    
//    NSString *jsonNString = [self stringWithCString:jsonString];
//    
//    return [self successProcess:command msg:jsonNString];
//}
-(PluginResult *)publishtransaction:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    Json signedTx=[self jsonWithString:args[idx++]];
    
    ISubWallet * suWall;
    suWall = [self getSubWallet:masterWalletID :chainID];
    Json result;
    try {
        result = suWall->PublishTransaction(signedTx);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
-(PluginResult *)getAllPublicKeys:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    int    start          = [args[idx++] intValue];
    int    count          = [args[idx++] intValue];
    ISubWallet * suWall;
    suWall = [self getSubWallet:masterWalletID :chainID];
    Json result;
    try {
        result = suWall->GetAllPublicKeys(start ,count);
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
//-(PluginResult *)getDetailsDIDlist:(invokedUrlCommand *)command{
//    NSArray *args = command.arguments;
//       int idx = 0;
//       String masterWalletID = [self cstringWithString:args[idx++]];
//       String chainID        = [self cstringWithString:args[idx++]];
//       String did            = [self cstringWithString:args[idx++]];
//       int    start          = [args[idx++] intValue];
//       int    count          = [args[idx++] intValue];
//       IIdChainSubWallet *idChainSubW=[self getIdChainSubWallet:masterWalletID :chainID];
//        Json result;
//         try {
//             result =  idChainSubW->GetResolveDIDInfo(start, count, did);
//         } catch (const std:: exception & e ) {
//             return  [self errInfoToDic:e.what() with:command];
//         }
//       NSString *jsonString = [self stringWithCString:result.dump()];
//       NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
//       return [self successProcess:command msg:dic];
//}
-(NSDictionary*)GetCRFirstPublicKeysAndDID:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString * masterWalletID = args[idx++];
    String chainID        = [self cstringWithString:args[idx++]];
    //    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
    IIdChainSubWallet *iidChainSubWallet=[self getIdChainSubWallet:[self cstringWithString:masterWalletID]:chainID];
    std::string crPublicKey,did,cid;
    try {
        if(iidChainSubWallet == NULL)
        {
            return nil;
        }
        crPublicKey = iidChainSubWallet->GetAllPublicKeys(0, 1)["PublicKeys"][0];
        did = iidChainSubWallet->GetPublicKeyDID(crPublicKey);
        cid=iidChainSubWallet->GetPublicKeyCID(crPublicKey);
    } catch (const std:: exception & e ) {
        [self errInfoToDic:e.what() with:command];
    }
    
    return @{@"crPublicKey":[self stringWithCString:crPublicKey],@"did":[self stringWithCString:did],@"cid":[self stringWithCString:cid]};
}
-(BOOL)IsAddressValidWithMastID:(NSString*)masWalletID WithAddress:(NSString*)address{
    String maWID=[self cstringWithString:masWalletID];
    String add=[self cstringWithString:address];
    return [self IsAddressValid:maWID withAddres:add];
    
}
-(PluginResult *)SpvDidAdapter_CreateIdTransactionEXWith:(invokedUrlCommand *)command{
    
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];
    String password=[self cstringWithString:args[idx++]];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    IIdChainSubWallet *iidChainSubWallet=[self getIdChainSubWallet:masterWalletID:chainID];
    String playStrig=[self cstringWithString:args[idx++]];
    nlohmann::json payloadJson = nlohmann::json::parse(playStrig);
    nlohmann::json tx;
    try {
        tx= iidChainSubWallet->CreateIDTransaction(payloadJson, memo);
        tx= iidChainSubWallet->SignTransaction(tx, password);
        tx = iidChainSubWallet->PublishTransaction(tx);
    } catch (const std:: exception & e ) {
        
        return  [self errInfoToDic:e.what() with:command];
        
    }
    
    NSString *resultString=[self stringWithCString:tx.dump()];
    NSDictionary *resultdic=  [self dictionaryWithJsonString:resultString];
    [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:10 withWalletID:[self stringWithCString:masterWalletID] withChainID:[self stringWithCString:chainID]];
    NSDictionary *dic=[self dictionaryWithJsonString:resultdic[@"TxHash"]];
    return [self successProcess:command msg:dic];
    
}
-(void)RandomSwitchLink:(invokedUrlCommand *)command{
    [self SyncStop:command];
    [self SyncStart:command];
}
-(void)SyncStop:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];;
    ISubWallet *subWallet=[self getSubWallet:masterWalletID  :chainID];
    
    
    try {
        if (subWallet) {
            subWallet->SyncStop();
        }
    } catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
    }
    
}
-(BOOL)ManualInputIP:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];
    String  address=[self cstringWithString:args[idx++]];
    uint16_t port=[args[idx++] intValue];
    ISubWallet *subWallet=[self getSubWallet:masterWalletID  :chainID];
    try {
        if (subWallet) {
            BOOL isSucce = subWallet->SetFixedPeer(address, port);
            return isSucce;
        }
    } catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return NO;
    }
    return NO;
}
-(void)saveTradingWithhash:(NSString*)Tradinghash withTradingType:(NSInteger)type withWalletID:(NSString*)walletID withChainID:(NSString*)chainID{
    HWMMessageCenterModel *model=[[HWMMessageCenterModel
alloc]init];
    model.typeHash=Tradinghash;
    model.walletID=walletID;
    model.chainID=chainID;
    model.MessageType=[NSString stringWithFormat:@"%ld",(long)type];
    [[HMWFMDBManager sharedManagerType:transactionsType] addTransactionsWithModel:model];
    
}
void *ReverseByteOrder(void *p, unsigned int len)
{
    unsigned int i;
    unsigned char *bytes, temp;
    
    bytes = (unsigned char *)p;
    for (i = 0; i < len / 2; i++)
    {
        temp = bytes[i];
        bytes[i] = bytes[len - 1 - i];
        bytes[len - 1 - i] = temp;
    }
    return p;
}
-(NSString*)adviceTheSignature:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletID =args[idx++];
    String playStrig=[self cstringWithString:args[idx++]];
    NSString *pwdString=args[idx++];
    nlohmann::json payloadJson = nlohmann::json::parse(playStrig);
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
    try {
        if (mainchainSubWallet) {
            String jsonString= mainchainSubWallet->ProposalOwnerDigest(payloadJson);
            NSString *resultString=[self stringWithCString:jsonString];
            NSData *testData =[NSData dataWithHexString:resultString];

            Byte *testByte = (Byte *)[testData bytes];
            NSLog(@"转换前----%s",testByte);
            for(int i=0;i<[testData length];i++){
                
                printf("testByte = %02x\n",testByte[i]);
                
            };
            
            //
            char ReverseChar[DIGEST_LEN];
            ReverseByteOrder(testByte, (int)[testData length]);
            for(int i=0;i<[testData length];i++){
                printf("ReverseByteOrdertestByte = %02x\n",testByte[i]);
                ReverseChar[i] = testByte[i];
                
            };
            NSLog(@"转换后----%s",testByte);
           return [[HWMDIDManager shareDIDManager]adviceTheSignatureWithPWD:pwdString withDigestChar:ReverseChar];
            
        }
    } catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return @"-1";
    }
    return @"-1";
}
#pragma mark - 提案 step

- (NSString *)signDigest:(NSString *)passwd payLoad:(String)payLoad walletID:(NSString *)masterWalletID
{
    try {
        NSString *signDigest = nil;
        Json payloadJson = nlohmann::json::parse(payLoad);
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            String jsonString = mainchainSubWallet->ProposalOwnerDigest(payloadJson);
            NSString *resultString = [self stringWithCString:jsonString];
            NSData *resultData = [NSData dataWithHexString:resultString];
            Byte *resultByte = (Byte *)[resultData bytes];
            char ReverseChar[DIGEST_LEN];
            ReverseByteOrder(resultByte, (int)[resultData length]);
            for(int i = 0; i < [resultData length]; i++)
            {
                ReverseChar[i] = resultByte[i];
            };
            signDigest = [[HWMDIDManager shareDIDManager] proposalTheSignatureWithPWD:passwd withDigestChar:ReverseChar];
            return signDigest;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
    }
    return nil;
}
- (NSString *)proposalCRCouncilMemberDigest:(NSString *)passwd payLoad:(String)payLoad walletID:(NSString *)masterWalletID
{
    try {
        NSString *signDigest = nil;
        
        Json payloadJson = nlohmann::json::parse(payLoad);
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            String jsonString = mainchainSubWallet->ProposalCRCouncilMemberDigest(payloadJson);
            NSString *resultString = [self stringWithCString:jsonString];
            NSData *resultData = [NSData dataWithHexString:resultString];
            Byte *resultByte = (Byte *)[resultData bytes];
            
            char ReverseChar[DIGEST_LEN];
            
            ReverseByteOrder(resultByte, (int)[resultData length]);
            
            for(int i = 0; i < [resultData length]; i++)
            {
                ReverseChar[i] = resultByte[i];
                
            };
            signDigest = [[HWMDIDManager shareDIDManager] proposalTheSignatureWithPWD:passwd withDigestChar:ReverseChar];
            return signDigest;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    return nil;
}

- (NSString *)createProposalTransaction:(NSDictionary *)dic walletID:(NSString *)masterWalletID
{

    try {
        NSString *payLoadStrig = [dic jsonStringEncoded];
        String std = [self cstringWithString:payLoadStrig];
        Json payloadJson = nlohmann::json::parse(std);
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            Json json = mainchainSubWallet->CreateProposalTransaction(payloadJson, "");
            NSString *resultString = [self stringWithJson:json];
          //  NSString *resultString=[self stringWithCString:json.dump()];
            return resultString;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
    
}

- (NSString *)calculateProposalHash:(NSDictionary *)dic walletID:(NSString *)masterWalletID
{
    try {
         NSString *payLoadStrig = [dic jsonStringEncoded];
        String std = [self cstringWithString:payLoadStrig];
        Json payloadJson = nlohmann::json::parse(std);
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            Json json = mainchainSubWallet->CalculateProposalHash(payloadJson);
            NSString *resultString = [self stringWithJson:json];
            return resultString;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
}

//xxl 943 createProposal
- (PluginResult *)proposaSignTransaction:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletID = args[idx++];
    NSDictionary *payLoadDic = args[idx++];
    NSString *pwdString = args[idx++];
 
    NSString *playloadDicString = [payLoadDic jsonStringEncoded];
    String paySLoadtrig = [self cstringWithString:playloadDicString];
    String PWD = [self cstringWithString:pwdString];
    
    String walletID = [self cstringWithString:masterWalletID];
    String chainID = "ELA";//暂时不知道

    NSString *calculateProposalHash = @"";
    ISubWallet *suWall = [self getSubWallet:walletID :chainID];
    Json  josn;
    try {
        NSString *proposalCRCouncilMemberDigest = [self proposalCRCouncilMemberDigest:pwdString payLoad:paySLoadtrig walletID:masterWalletID];
        
        if(!proposalCRCouncilMemberDigest)
        {
            return nil;
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:payLoadDic];
        [dic setValue:proposalCRCouncilMemberDigest forKey:@"CRCouncilMemberSignature"];
    
        NSDictionary *dataDic = [[NSDictionary alloc] initWithDictionary:dic];
        NSString *payload  = [self createProposalTransaction:dataDic walletID:masterWalletID];
        if(!payload)
        {
            return nil;
        }
        calculateProposalHash  = [self calculateProposalHash:dataDic walletID:masterWalletID];
        
        josn = [self jsonWithString:payload];
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
       Json signedTx;
       Json result;
       NSString *resultString = @"";
       NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
       try {
           signedTx =  suWall->SignTransaction(josn, PWD);
           
           resultString = [self stringWithJson:signedTx];
           
           [resultDic setValue:resultString forKey:@"SignTransaction"];
           [resultDic setValue:calculateProposalHash forKey:@"calculateProposalHash"];
           [resultDic setValue:pwdString forKey:@"pwd"];
           
           
       } catch (const std:: exception & e ) {
           return  [self errInfoToDic:e.what() with:command];
       }
       try {
           result = suWall->PublishTransaction(signedTx);
           
           return [self successProcess:command msg:resultDic];
       } catch (const std:: exception & e ) {
           return  [self errInfoToDic:e.what() with:command];
       }
 
    
    return NULL;
}

///-----
//xxl 2.3
- (PluginResult *)proposalVoteForTransaction:(invokedUrlCommand *)command
{
 
       NSArray *args = command.arguments;
       int idx = 0;
       NSString *masterWalletID = args[idx++];
       NSDictionary *payLoadDic = args[idx++];
       NSString *pwdString = args[idx++];
    
       NSString *playloadDicString = [payLoadDic jsonStringEncoded];
       String paySLoadtrig = [self cstringWithString:playloadDicString];
       String PWD = [self cstringWithString:pwdString];
       
       String walletID = [self cstringWithString:masterWalletID];
       String chainID = "ELA";//暂时不知道

       ISubWallet *suWall = [self getSubWallet:walletID :chainID];
       Json  josn;
       try {

           NSString *payload  = [self createProposalForVoteTransaction:payLoadDic walletID:masterWalletID];
           if(!payload)
           {
               return nil;
           }
           josn = [self jsonWithString:payload];
       } catch (const std:: exception & e) {
           return  [self errInfoToDic:e.what() with:command];
       }
          Json signedTx;
          Json result;
          NSString *resultString = @"";
          NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
          try {
              signedTx =  suWall->SignTransaction(josn, PWD);
              resultString = [self stringWithJson:signedTx];
              
              [resultDic setValue:resultString forKey:@"SignTransaction"];
              
          } catch (const std:: exception & e ) {
              return  [self errInfoToDic:e.what() with:command];
          }
          try {
              result = suWall->PublishTransaction(signedTx);
              NSString *jsonString = [self stringWithCString:result.dump()];
              NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
              [resultDic setValue:dic[@"TxHash"] forKey:@"txid"];
              
              return [self successProcess:command msg:resultDic];
          } catch (const std:: exception & e ) {
              return  [self errInfoToDic:e.what() with:command];
          }
    
       return NULL;
    
}



//xxl 2.3 pro
- (NSString *)createProposalForVoteTransaction:(NSDictionary *)dicPlayload walletID:(NSString *)masterWalletID
{
    try {
        NSString *payLoadStrig = [dicPlayload jsonStringEncoded];
        String std = [self cstringWithString:payLoadStrig];
        Json payloadJson = nlohmann::json::parse(std);
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            //Vote info
            Json json = mainchainSubWallet->GetVoteInfo("");
            //logic of create the invalidJson
            NSString *resultString = [self stringWithJson:json];
            NSDictionary *dic;
            if([resultString isEqualToString: @"null"]){
                dic = @{};
            }else{
                dic=[self dictionaryWithJsonString:resultString];
                NSLog(@"createProposalForVoteTransaction dis is %@",dic);
            }

            Json invalidJson;
            Json votesJson;
            
            //vote
            NSDictionary * votesDic = @{
                 dicPlayload[@"ProposalHash"]: dicPlayload[@"Amount"]
            };
        
            if([dic count] > 0){ //TODO
                
                //invalid
                NSMutableArray *InvalidJson = [NSMutableArray array];
                
                for (id item in dic){
                  //do something
                  NSLog(@"item is %@",item);
                   
                  NSDictionary * votes = item[@"Votes"];
                  NSLog(@"votes is %@",votes);
                  
                  
                  NSMutableArray *InvalidateHashArray = [NSMutableArray array];
                  for(id vote in votes){
                        
                      NSLog(@"11 vote is %@",vote);
                      
                      NSMutableArray *VotingProporal = dicPlayload[@"VotingProposal"];
                      BOOL isVote = NO ;
                      for (id proporalItem in VotingProporal){
                          
                          
                          NSLog(@"11 proposalHash is %@",proporalItem[@"proposalHash"]);
                          if([proporalItem[@"proposalHash"] isEqualToString: vote]){
                              isVote = YES;
                          }
                      }
        
                      if(isVote == NO){
                          [InvalidateHashArray addObject: vote];
                      }
                      
//                      if([vote isEqualToString: dicPlayload[@"ProposalHash"]]){
//                          [InvalidateHashArray addObject: vote];
//                      }
    
                  }
                  
                  //Add by Invalid
                  if([InvalidateHashArray count] > 0){
                       
                       NSDictionary* invalidateDic = @{
                           @"Type": item[@"Type"],
                           @"Candidates": InvalidateHashArray
                       };
                       [InvalidJson addObject: invalidateDic];
                       
                  }
                    
                  
                    
                }

                NSString *invalidJsonStrig = [self arrayToJSONString:InvalidJson];
                //NSString *invalidJsonStrig = [dic jsonStringEncoded];
                String std = [self cstringWithString:invalidJsonStrig];
                invalidJson = nlohmann::json::parse(std);
                
            }else{
                
                //invalid
                NSArray *InvalidArr = @[];
                NSString *invalidJsonStrig = [self arrayToJSONString:InvalidArr];
                //NSString *invalidJsonStrig = [dic jsonStringEncoded];
                String std = [self cstringWithString:invalidJsonStrig];
                invalidJson = nlohmann::json::parse(std);
                                
            }
            
            NSString *voteLoadStrig = [votesDic jsonStringEncoded];
            String strVote = [self cstringWithString:voteLoadStrig];
            votesJson = nlohmann::json::parse(strVote);
            
            //Json jsonCreateTx ;
            Json jsonCreateTx = mainchainSubWallet->CreateVoteCRCProposalTransaction("", votesJson,"",invalidJson);
            
            NSString *retString = [self stringWithJson:jsonCreateTx];
            return retString;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
}

//xxl 2.2 pro
- (PluginResult *)proposalReviewTransaction:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletID = args[idx++];
    NSDictionary *payLoadDic = args[idx++];
    NSString *pwdString = args[idx++];
 
    NSString *playloadDicString = [payLoadDic jsonStringEncoded];
    String paySLoadtrig = [self cstringWithString:playloadDicString];
    String PWD = [self cstringWithString:pwdString];
    
    String walletID = [self cstringWithString:masterWalletID];
    String chainID = "ELA";//暂时不知道

    NSString *calculateProposalHash = @"";
    ISubWallet *suWall = [self getSubWallet:walletID :chainID];
    Json  josn;
    try {
        NSString *proposalReviewDigest =
            [self ProposalReviewDigest:pwdString payLoad:paySLoadtrig walletID:masterWalletID];
        
        if(!proposalReviewDigest)
        {
            return nil;
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:payLoadDic];
        [dic setValue:proposalReviewDigest forKey:@"Signature"];
    
        NSDictionary *dataDic = [[NSDictionary alloc] initWithDictionary:dic];
        NSString *payload  = [self createProposalReviewTransaction:dataDic walletID:masterWalletID];
    
        NSLog(@"xxl Payload is %@",payload);
        if(!payload)
        {
            return nil;
        }
        
        //xxl fix the bug for #943
        //calculateProposalHash  = [self calculateProposalHash:dataDic walletID:masterWalletID];
        josn = [self jsonWithString:payload];
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
       Json signedTx;
       Json result;
       NSString *resultString = @"";
       NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
       try {
           signedTx =  suWall->SignTransaction(josn, PWD);
           
           resultString = [self stringWithJson:signedTx];
           
           [resultDic setValue:resultString forKey:@"SignTransaction"];
           [resultDic setValue:pwdString forKey:@"pwd"];
           
           
       } catch (const std:: exception & e ) {
           return  [self errInfoToDic:e.what() with:command];
       }
       try {
           result = suWall->PublishTransaction(signedTx);
           NSString *jsonString = [self stringWithCString:result.dump()];
           
           //xxl #943
           NSLog(@"xxl 943 0 proposalReviewTransaction %@",jsonString);
           
           
           NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
           
           NSLog(@"xxl 943 1 txid %@",dic[@"TxHash"]);
           
           
           [resultDic setValue:dic[@"TxHash"] forKey:@"txid"];
           
           return [self successProcess:command msg:resultDic];
       } catch (const std:: exception & e ) {
           return  [self errInfoToDic:e.what() with:command];
       }
 
    
    return NULL;
}



//xxl 2.2
- (NSString *)ProposalReviewDigest:(NSString *)passwd payLoad:(String)payLoad walletID:(NSString *)masterWalletID
{
    try {
        NSString *signDigest = nil;
        
        Json payloadJson = nlohmann::json::parse(payLoad);
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            String jsonString = mainchainSubWallet->ProposalReviewDigest(payloadJson);
            NSString *resultString = [self stringWithCString:jsonString];
            NSData *resultData = [NSData dataWithHexString:resultString];
            Byte *resultByte = (Byte *)[resultData bytes];
            
            char ReverseChar[DIGEST_LEN];
            
            ReverseByteOrder(resultByte, (int)[resultData length]);
            
            for(int i = 0; i < [resultData length]; i++)
            {
                ReverseChar[i] = resultByte[i];
                
            };
            signDigest = [[HWMDIDManager shareDIDManager] proposalTheSignatureWithPWD:passwd withDigestChar:ReverseChar];
            return signDigest;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    return nil;
}


//xxl 2.2 pro
- (NSString *)createProposalReviewTransaction:(NSDictionary *)dic walletID:(NSString *)masterWalletID
{
    try {
        NSString *payLoadStrig = [dic jsonStringEncoded];
        String std = [self cstringWithString:payLoadStrig];
        Json payloadJson = nlohmann::json::parse(std);
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
                        
            Json json = mainchainSubWallet->CreateProposalReviewTransaction(payloadJson, "");
            NSString *resultString = [self stringWithJson:json];
          //  NSString *resultString=[self stringWithCString:json.dump()];
            return resultString;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
}

#pragma mark -Utils

- (NSDictionary *)addValue:(NSDictionary *)dic key:(NSString *)key value:(NSString *)value
{
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [resultDic setValue:value forKey:key];
    return resultDic;
    
}

// 翻转 返回hexstring
- (NSString *)reverseChar:(NSString *)resultString passwd:(NSString *)passwd
{
    
    NSData *resultData = [NSData dataWithHexString:resultString];
    Byte *resultByte = (Byte *)[resultData bytes];
    
    char ReverseChar[DIGEST_LEN];
    
    ReverseByteOrder(resultByte, (int)[resultData length]);
    
    for(int i = 0; i < [resultData length]; i++)
    {
        ReverseChar[i] = resultByte[i];
        
    };
    NSString  *signDigest = [[HWMDIDManager shareDIDManager] proposalTheSignatureWithPWD:passwd withDigestChar:ReverseChar];
    return signDigest;
}
#pragma mark -  提取提案资金

//1. 从二维码获取数据：ProposalHash OwnerPublicKey
//2. 调用ProposalWithdrawDigest 得到Digest
//3. 对Digest签名，得到Signature
//4. 组成整个Payload
//5. 生成交易
//6. 广播

- (PluginResult *)createProposalWithdrawTransaction:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletID = args[idx++];
    NSDictionary *payLoadDic = args[idx++];
    NSString *pwdString = args[idx++];
    NSString *recipientStr = args[idx++];
    NSString *amountStr = args[idx++];
    NSArray *utxoDic = args[idx++];
    
    NSString *playloadDicString = [payLoadDic jsonStringEncoded];
    String payLoadString = [self cstringWithString:playloadDicString];
    String PWD = [self cstringWithString:pwdString];
    String recipient = [self cstringWithString:recipientStr];
    String amount = [self cstringWithString:amountStr];
    
    
    String walletID = [self cstringWithString:masterWalletID];
    String chainID = "ELA";//暂时不知道
    ISubWallet *suWall = [self getSubWallet:walletID :chainID];
    
    NSString *calculateProposalHash = @"";
    Json json;
    try {
        
        IMainchainSubWallet *mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        
        NSString *signature = [self proposalWithdrawDigest:payLoadDic :mainchainSubWallet];
        if(signature == nil)
        {
            return nil;
        }
        signature = [self reverseChar:signature passwd:pwdString];
        payLoadDic = [self addValue:payLoadDic key:@"Signature" value:signature];
        playloadDicString = [payLoadDic jsonStringEncoded];
        String pay = [self cstringWithString:playloadDicString];
        Json payloadJson = nlohmann::json::parse(pay);
        
        Json utxo = [self jsonWithString:[utxoDic jsonStringEncoded]];
        
        Json resultJson = mainchainSubWallet->CreateProposalWithdrawTransaction(recipient, amount, utxo, payloadJson);
        json = resultJson;
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    NSDictionary *resultDic = [self publishTransactionWithdraw:json pwd:PWD suWall:suWall hash:calculateProposalHash];
    if(resultDic)
    {
        return [self successProcess:command msg:resultDic];
    }
    return nil;

}
- (NSString *)proposalWithdrawDigest:(NSDictionary *)payloadJson :(IMainchainSubWallet *)mainchainSubWallet
{
    try {
        NSString *playloadDicString = [payloadJson jsonStringEncoded];
        String paySLoadtrig = [self cstringWithString:playloadDicString];
        Json payloadJson = nlohmann::json::parse(paySLoadtrig);
        String resultString = mainchainSubWallet->ProposalWithdrawDigest(payloadJson);
        return [self stringWithCString:resultString];
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }

    return nil;
}
- (NSDictionary *)publishTransactionWithdraw:(Json)json pwd:(String)pwd suWall:(ISubWallet *)suWall hash:(NSString *)hash
{
    Json signedTx;
    Json result;
    NSString *resultString = @"";
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
    try {
        signedTx = json;//suWall->SignTransaction(json, pwd);
        //signedTx = suWall->SignTransaction(json, pwd);
        
        resultString = [self stringWithJson:signedTx];
        
        [resultDic setValue:resultString forKey:@"SignTransaction"];
        if(hash && ![hash isEqualToString:@""])
        {
            [resultDic setValue:hash forKey:@"calculateProposalHash"];
        }
        
        result = suWall->PublishTransaction(signedTx);
        NSString *pubResult = [self stringWithJson:result];
        return resultDic;
        
    } catch (const std:: exception & e ) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
    }
    return nil;

}


#pragma mark -  提案追踪

//updatemilestone流程：
//1. 提案负责人申请 + 扫码 + callback 签名
//目前只需要ProposalTrackingOwnerDigest，
//不需要ProposalTrackingNewOwnerDigest
//及ProposalTrackingSecretaryDigest
//2. 秘书长审核 + 扫码 + ProposalTrackingSecretaryDigest，
// 广播交易并callback txid


- (NSString *)proposalTrackingNewOwnerDigest:(NSDictionary *)payloadJson :(IMainchainSubWallet *)mainchainSubWallet
{
    
    try {
        NSString *playloadDicString = [payloadJson jsonStringEncoded];
        String paySLoadtrig = [self cstringWithString:playloadDicString];
        Json payloadJson = nlohmann::json::parse(paySLoadtrig);
        String resultString = mainchainSubWallet->ProposalTrackingNewOwnerDigest(payloadJson);
        return [self stringWithCString:resultString];
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
}


#pragma mark - 提案负责人扫码
// 提案负责人扫码
- (PluginResult *)proposalTrackingTransaction:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletID = args[idx++];
    NSDictionary *payLoadDic = args[idx++];
    NSString *pwdString = args[idx++];
    
    NSString *playloadDicString = [payLoadDic jsonStringEncoded];
    String paySLoadtrig = [self cstringWithString:playloadDicString];
    String PWD = [self cstringWithString:pwdString];
    
    String walletID = [self cstringWithString:masterWalletID];
    String chainID = "ELA";//暂时不知道
    
    Json json;
    try {
    
        IMainchainSubWallet *mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            //step 1
            NSString *ownerSignature = [self proposalTrackingOwnerDigest:payLoadDic :mainchainSubWallet];
            if(ownerSignature == nil)
            {
                return nil;
            }
            ownerSignature = [self reverseChar:ownerSignature passwd:pwdString];
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
        
            //NSDictionary *resultDic = @{@"Signature" : ownerSignature};
            [resultDic setValue:ownerSignature forKey:@"Signature"];
            [resultDic setValue:pwdString forKey:@"pwd"];
            
            if(resultDic)
            {
                return [self successProcess:command msg:resultDic];
            }
        
        }
    }
    catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
   return nil;
}

- (NSString *)proposalTrackingOwnerDigest:(NSDictionary *)payloadJson :(IMainchainSubWallet *)mainchainSubWallet
{

    try {
        NSString *playloadDicString = [payloadJson jsonStringEncoded];
        String paySLoadtrig = [self cstringWithString:playloadDicString];
        Json payloadJson = nlohmann::json::parse(paySLoadtrig);
        String resultString = mainchainSubWallet->ProposalTrackingOwnerDigest(payloadJson);
        return [self stringWithCString:resultString];
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    return nil;
}

#pragma mark - 提案追踪-秘书长扫码
// 提案追踪-秘书长扫码
- (PluginResult *)proposalTrackingTransactionWithSecretary:(invokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletID = args[idx++];
    NSDictionary *payLoadDic = args[idx++];
    NSString *pwdString = args[idx++];
    
    NSString *playloadDicString = [payLoadDic jsonStringEncoded];
    String paySLoadtrig = [self cstringWithString:playloadDicString];
    String PWD = [self cstringWithString:pwdString];
    
    String walletID = [self cstringWithString:masterWalletID];
    String chainID = "ELA";//暂时不知道
    
    ISubWallet *suWall = [self getSubWallet:walletID :chainID];
    Json json;
    try {
    
        IMainchainSubWallet *mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            NSString *secretaryGeneralSignature = [self proposalTrackingSecretaryDigest:payLoadDic :mainchainSubWallet];
            if(secretaryGeneralSignature == nil)
            {
                return nil;
            }
            secretaryGeneralSignature = [self reverseChar:secretaryGeneralSignature passwd:pwdString];
            payLoadDic = [self addValue:payLoadDic key:@"SecretaryGeneralSignature" value:secretaryGeneralSignature];
            
            Json resJson = [self createProposalTrackingTransaction:payLoadDic :mainchainSubWallet];
            if(resJson == nil)
            {
                return nil;
            }
            NSString *payload = [self stringWithJson:resJson];
            if(!payload)
            {
                return nil;
            }

            json = [self jsonWithString:payload];
        }
    }
    catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    Json signedTx;
    Json result;
    NSString *resultString = @"";
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
    try {
        signedTx =  suWall->SignTransaction(json, PWD);
        resultString = [self stringWithJson:signedTx];
        
        [resultDic setValue:resultString forKey:@"SignTransaction"];
        
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    try {
        result = suWall->PublishTransaction(signedTx);
        NSString *jsonString = [self stringWithCString:result.dump()];
        NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
        [resultDic setValue:dic[@"TxHash"] forKey:@"txid"];
        
        return [self successProcess:command msg:resultDic];
    } catch (const std:: exception & e ) {
        return  [self errInfoToDic:e.what() with:command];
    }
    
    return nil;
}


- (NSString *)proposalTrackingSecretaryDigest:(NSDictionary *)payloadJson :(IMainchainSubWallet *)mainchainSubWallet
{
    try {
        NSString *playloadDicString = [payloadJson jsonStringEncoded];
        String paySLoadtrig = [self cstringWithString:playloadDicString];
        Json payloadJson = nlohmann::json::parse(paySLoadtrig);
        String resultString = mainchainSubWallet->ProposalTrackingSecretaryDigest(payloadJson);
        return [self stringWithCString:resultString];
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
}


- (Json)createProposalTrackingTransaction:(NSDictionary *)payloadJson :(IMainchainSubWallet *)mainchainSubWallet
{

    try {
        NSString *playloadDicString = [payloadJson jsonStringEncoded];
        String paySLoadtrig = [self cstringWithString:playloadDicString];
        Json payloadJson = nlohmann::json::parse(paySLoadtrig);
        Json json = mainchainSubWallet->CreateProposalTrackingTransaction(payloadJson);
        return json;
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
    
    return nil;
}

#pragma mark - 委员弹劾

//用于显示余额
- (id)getVoteBalance:(NSString *)masterWalletID
{
    String walletID = [self cstringWithString:masterWalletID];
    String chainID = "ELA";//暂时不知道
    
    ISubWallet *subWallet = [self getSubWallet:walletID :chainID];
    try {
        Json balance = subWallet->GetBalanceInfo();
        NSString *resultString = [self stringWithJson:balance];
        NSArray *array = [resultString jsonValueDecoded];
        if(array && array.count > 0)
        {
            NSDictionary *dic = array[0];
            NSDictionary *balanceDic = dic[@"Summary"];
            NSString *value = balanceDic[@"Balance"];
            if(value && ![value isEqualToString:@""])
            {
                return value;
            }
        }
        
    } catch (const std:: exception &e) {
        NSDictionary *errDic = [self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
    }
   return nil;
    
}

- (PluginResult *)CreateImpeachmentCRCTransaction:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    NSString *masterWalletID = args[idx++];
    NSString *pwdString = args[idx++];
    NSDictionary *votesDic = args[idx++];
    NSArray *InvalidArr = args[idx++];
    
    
//    NSString *playloadDicString = [payLoadDic jsonStringEncoded];
//    String paySLoadtrig = [self cstringWithString:playloadDicString];
    String PWD = [self cstringWithString:pwdString];
    
    String walletID = [self cstringWithString:masterWalletID];
    String chainID = "ELA";//暂时不知道
    
    ISubWallet *suWall = [self getSubWallet:walletID :chainID];
    Json  josn;
    
    try {
       
        IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:masterWalletID];
        if (mainchainSubWallet)
        {
            
            NSString *voteLoadStrig = [votesDic jsonStringEncoded];
            String strVote = [self cstringWithString:voteLoadStrig];
            Json votesJson = nlohmann::json::parse(strVote);
            
            NSString *invalidJsonStrig = [self arrayToJSONString:InvalidArr];
            //NSString *invalidJsonStrig = [dic jsonStringEncoded];
            String std = [self cstringWithString:invalidJsonStrig];
            Json invalidJson = nlohmann::json::parse(std);
            
            //Json jsonCreateTx ;
            Json jsonCreateTx = mainchainSubWallet->CreateImpeachmentCRCTransaction("", votesJson,"",invalidJson);
            
            NSDictionary *resultDic = [self publishTransactionWithdraw:jsonCreateTx pwd:PWD suWall:suWall hash:nil];
            if(resultDic)
            {
                return [self successProcess:command msg:resultDic];
            }
            
//            NSString *retString = [self stringWithJson:jsonCreateTx];
//            return retString;
        }
    }
    catch (const std:: exception &e) {
        NSDictionary *errDic=[self dictionaryWithJsonString:[self stringWithCString:e.what()]];
        NSString *errCode=[NSString stringWithFormat:@"err%@",errDic[@"Code"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return nil;
    }
     
     return nil;
}

- (NSArray *)getVoteInfoList:(NSString *)masterWalletID :(NSString *)typeStr
{
    try {
            String wallId = [self cstringWithString:masterWalletID];
            IMainchainSubWallet *mainchainSubWallet = [self getWalletELASubWallet:masterWalletID];
            if (mainchainSubWallet)
            {
                String type = [self cstringWithString:typeStr];
                //Vote info
                Json json = mainchainSubWallet->GetVoteInfo(type);
                //logic of create the invalidJson
                NSString *resultString = [self stringWithJson:json];
                NSArray *array = [[NSArray alloc] initWithArray: [resultString jsonValueDecoded]];
                if(array && array.count > 0)
                {
                   return array;
                }
            }
        }
        catch (const std:: exception &e) {
            NSDictionary *errDic = [self dictionaryWithJsonString:[self stringWithCString:e.what()]];
            NSString *errCode = [NSString stringWithFormat:@"err%@",errDic[@"Code"]];
            [[FLTools share] showErrorInfo:NSLocalizedString(errCode, nil)];
            return nil;
        }
        return nil;
}

@end
