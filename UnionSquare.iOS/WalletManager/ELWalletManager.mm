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
            String configString("{\"ELA\":{\"ChainParameters\":{\"StandardPort\":40086,\"DNSSeeds\":[\"139.198.0.59\"]}},\"IDChain\":{\"ChainParameters\":{\"StandardPort\":40087,\"DNSSeeds\":[\"139.198.0.59\"]}}}");
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
        String configString("{\"ELA\":{\"ChainParameters\":{\"StandardPort\":40086,\"DNSSeeds\":[\"139.198.0.59\"]}},\"IDChain\":{\"ChainParameters\":{\"StandardPort\":40087,\"DNSSeeds\":[\"139.198.0.59\"]}}}");
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
        
        //               const std::string &crPublicKey,
        //               const std::string &did,
        //               const std::string &nickName,
        //               const std::string &url,
        //               uint64_t location) const = 0;
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
        [self saveTradingWithhash:resultdic[@"TxHash"] withTradingType:1001 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
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
    [self saveTradingWithhash:dic[@"TxHash"] withTradingType:1002 withWalletID:self.currentWallet.walletID withChainID:@"ELA"];
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
@end
