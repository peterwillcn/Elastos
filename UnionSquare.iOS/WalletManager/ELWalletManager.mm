//
//  WalletManager.m
//  WalletManager
//
//  Created by  on 2018/12/10.
//  Copyright © 2018年 64. All rights reserved.
//

#import "ELWalletManager.h"
#include <dispatch/dispatch.h>
static ELWalletManager *tool;
static uint64_t feePerKB = 10000;
#pragma mark - ELWalletManager
@interface ELWalletManager ()


{
    
}

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
#pragma mark -
- (IMasterWallet *)getIMasterWallet:(String)masterWalletID
{
    if (mMasterWalletManager == nil) {
        
        return nil;
    }
    try {
          NSLog(@"GetWallet--%@",[self stringWithCString:masterWalletID]);
       return  mMasterWalletManager->GetWallet(masterWalletID);
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
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
        NSLog(@"GetAllSubWallets");
         subWalletList = masterWallet->GetAllSubWallets();
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
    }
//   subWalletList = masterWallet->GetAllSubWallets();
    for (int i = 0; i < subWalletList.size(); i++)
    {
        ISubWallet *iSubWallet = subWalletList[i];
        String  getChainID;
        
        try {
             NSLog(@"GetChainId");
            getChainID =iSubWallet->GetChainId();
        } catch (const std:: exception & e ) {
            
            NSString *errString=[self stringWithCString:e.what()];
            NSDictionary *dic=  [self dictionaryWithJsonString:errString];
            [[FLTools share]showErrorInfo:dic[@"Message"]];
            return 0;
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
- (void)createDIDManager:(IMasterWallet *)masterWallet
{
    
}



#pragma mark -

- (NSString *)getBasicInfo:(IMasterWallet *)masterWallet
{
    Json json;
    try {
        NSLog(@"GetBasicInfo");
        masterWallet->GetBasicInfo();
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
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
    
    [[FLTools share]showErrorInfo:msg];
    
    pluginResult = [PluginResult resultWithStatus:CommandStatus_ERROR messageAsDictionary:jsonDic];
   
    return pluginResult;
}

-(PluginResult *)errInfoToDic:(String)errInfo with:(invokedUrlCommand *)command{

    NSString *errString=[self stringWithCString:errInfo];
  NSDictionary *dic=  [self dictionaryWithJsonString:errString];


    return [self  errorProcess:command code:[dic[@"Code"] intValue] msg:dic[@"Message"]];

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
    Json json = Json::parse(std);
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
    mRootPath = [MyUtil getRootPath];
    const char  *rootPath = [mRootPath UTF8String];
    try {
      mMasterWalletManager = new MasterWalletManager(rootPath);
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
    mMasterWalletManager = new MasterWalletManager(rootPath);
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
    
    try{
         NSLog(@"GetAllMasterWallets");
        IMasterWalletVector vector = mMasterWalletManager->GetAllMasterWallets();
        NSMutableArray *masterWalletListJson = [[NSMutableArray alloc] init];
        for (int i = 0; i < vector.size(); i++) {
            IMasterWallet *iMasterWallet = vector[i];
            String idStr = iMasterWallet->GetId();
            NSString *str = [self stringWithCString:idStr];
            [masterWalletListJson addObject:str];
        }
        NSString *msg = [self arrayToJSONString:masterWalletListJson];
        
        return [self successProcess:command msg:msg];
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
    }
    
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
        NSLog(@"CreateMasterWallet--%@--%@--%@--%@",[self stringWithCString:masterWalletID], [self stringWithCString:mnemonic], [self stringWithCString:phrasePassword], [self stringWithCString:payPassword]);
        masterWallet = mMasterWalletManager->CreateMasterWallet(
                                                                masterWalletID, mnemonic, phrasePassword, payPassword, singleAddress);
     } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
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
        NSLog(@"GenerateMnemonic--%@",[self stringWithCString:language]);
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
    long feePerKb         = [args[idx++] boolValue];;
    
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
        NSLog(@"createSubWallet--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
        subWallet = masterWallet->CreateSubWallet(chainID, feePerKb);
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }

    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Create", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeCreateSubWallet msg:msg];
    }
    Json json;
    try {
        NSLog(@"GetBasicInfo");
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
        NSLog(@"GetAllSubWallets");
        subWalletList= masterWallet->GetAllSubWallets();
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
   
    for (int i = 0; i < subWalletList.size(); i++)
    {
        ISubWallet *iSubWallet = subWalletList[i];
        String chainId;
        try {
            NSLog(@"GetChainId");
          chainId = iSubWallet->GetChainId();
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
//    NSLog(@"getBalance--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
    
    
  
    NSLog(@"getBalance--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
    long type    = [ args[idx++] intValue];
    Elastos::ElaWallet::BalanceType Btype;
    switch (type) {
        case 0:
            Btype= Elastos::ElaWallet::Default;
            break;
        case 1:
            Btype= Elastos::ElaWallet::Voted;
            break;
        case 2:
            Btype= Elastos::ElaWallet::Total;
            break;
        default:
            break;
    }
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
        balance = subWallet->GetBalance(Btype);
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
    
    String masterWalletID = [self cstringWithString:args[idx++]];;
    NSLog(@"getSupportedChains--%@",[self stringWithCString:masterWalletID]);
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
    NSLog(@"getAllTransaction--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
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
    
    String masterWalletID = [self cstringWithString:args[idx++]];;
    String chainID        = [self cstringWithString:args[idx++]];;
    NSLog(@"createAddress--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
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
    NSLog(@"getAllSubWalletAddress--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
    
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
    NSLog(@"getGenesisAddress--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
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
    
    String masterWalletID = [self cstringWithString:args[idx++]];;
    NSLog(@"getMasterWalletPublicKey--%@",[self stringWithCString:masterWalletID]);
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
        json = masterWallet->GetPublicKey();
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
    NSLog(@"exportWalletWithKeystore--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:backupPassword],[self stringWithCString:payPassword]);
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
        json = mMasterWalletManager->ExportWalletWithKeystore(masterWallet, backupPassword, payPassword);
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
    NSLog(@"exportWalletWithMnemonic--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:backupPassword]);
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
        json = mMasterWalletManager->ExportWalletWithMnemonic(masterWallet, backupPassword);
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return [self successProcess:command msg:jsonString];
    
}
- (PluginResult *)changePassword:(invokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String oldPassword = [self cstringWithString:args[idx++]];
    String newPassword = [self cstringWithString:args[idx++]];
    NSLog(@"exportWalletWithMnemonic--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:oldPassword],[self stringWithCString:newPassword]);
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
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    Json keystoreContent = [self jsonWithString:args[idx++]];
    String backupPassword = [self cstringWithString:args[idx++]];
    String payPassword = [self cstringWithString:args[idx++]];
    NSLog(@"importWalletWithKeystore--%@--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:keystoreContent],[self stringWithCString:backupPassword],[self stringWithCString:payPassword]);
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
    NSLog(@"importWalletWithMnemonic--%@--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:mnemonic],[self stringWithCString:phrasePassword],[self stringWithCString:payPassword]);
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
    
    String chainID= [self cstringWithString:chainIDString];
    NSLog(@"registerWalletListener--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
    ISubWallet *subWallet = [self getSubWallet:masterWalletID : chainID];
    
    
    
    //    mCallback ->OnBlockSyncStarted();
    //
    
    NSString *callIDString=[NSString stringWithFormat:@"%@,%@,%@",masterWalletIDString,chainIDString,command.methodName];
    String callBackID=[self cstringWithString:callIDString];
    try {
         subWallet->AddCallback(new ElaSubWalletCallback(callBackID));
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
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    NSLog(@"DestroySubWallet--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID]);
    //    long feePerKb         = [args[idx++] boolValue];;
    
//    if (args.count != idx) {
//
//        return [self errCodeInvalidArg:command code:errCodeInvalidArg idx:idx];
//    }
    IMasterWallet *masterWallet = [self getIMasterWallet:masterWalletID];
    if (masterWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    
    ISubWallet *subWallet =[self getSubWallet:masterWalletID :chainID];
    if (subWallet == nil) {
        NSString *msg = [NSString stringWithFormat:@"%@ %@", @"Get", [self formatWalletNameWithString:masterWalletID other:chainID]];
        return [self errorProcess:command code:errCodeInvalidMasterWallet msg:msg];
    }
    
    try {
       masterWallet->DestroyWallet(subWallet);
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
        NSLog(@"DestroyMasterWallet--%@",[self stringWithCString:masterWalletID]);
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
    
    
    
    //    mCallback ->OnBlockSyncStarted();
    //
    
    NSString *callIDString=[NSString stringWithFormat:@"%@,%@,%@",masterWalletIDString,chainIDString,command.methodName];
    String callBackID=[self cstringWithString:callIDString];
    try {
       subWallet->RemoveCallback(new ElaSubWalletCallback(callBackID));
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
    long amount = [args[idx++] integerValue];
    String memo = [self cstringWithString:args[idx++]];
    String remark = [self cstringWithString:args[idx++]];
    String PWD = [self cstringWithString:args[idx++]];
    Boolean useVotedUTXO =  [args[idx++] boolValue];
    NSLog(@"CreateTransaction--%@--%@--%@--%@--%@--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID],[self stringWithCString:fromAddress],[self stringWithCString:toAddress],[NSString stringWithFormat:@"%ld",amount],[self stringWithCString:memo],[self stringWithCString:remark],[self stringWithCString:PWD]);
    ISubWallet * suWall;
    Json josn;
        suWall = [self getSubWallet:masterWalletID :chainID];
    try {
        josn=suWall->CreateTransaction(fromAddress, toAddress, amount, memo, remark,useVotedUTXO);
    } catch (const std:: exception & e) {
       return  [self errInfoToDic:e.what() with:command];
    }
    Json result;
//    try {
//    result= [self PublishTransaction:suWall :josn withPWD:PWD withFromAddress:fromAddress];
//    } catch (const std:: exception e) {
//       return  [self errInfoToDic:e.what() with:command];
//    }
    
    Json signedTx;
   
    try {
        
//        signedTx=[self CalculateFeeAndSign:subWallet :json withPWD:payPasswd withFromAddress:address];
        
        uint64_t fee;
        Json tmpTx;
//        Json retJson;
        try {
            
            fee = suWall->CalculateTransactionFee(josn, feePerKB);
            try {
                
                tmpTx = suWall->UpdateTransactionFee(josn, fee, fromAddress);
                try {
                    signedTx=  suWall->SignTransaction(tmpTx, PWD);
                } catch (const std:: exception & e ) {
                    
                return  [self errInfoToDic:e.what() with:command];
                }
                
            } catch (const std:: exception & e ) {
                
              return  [self errInfoToDic:e.what() with:command];
            }
        } catch (const std:: exception & e ) {
          return  [self errInfoToDic:e.what() with:command];
        }
        
        
        
        
        try {
            
            result = suWall->PublishTransaction(signedTx);
            
            
        } catch (const std:: exception & e ) {
          return  [self errInfoToDic:e.what() with:command];
        }
        
    } catch (const std:: exception & e ) {
       return  [self errInfoToDic:e.what() with:command];
    }
   
    
    
    
    
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
//- (Json)PublishTransaction:(ISubWallet*)subWallet :(Json)json withPWD:(String)payPasswd withFromAddress:(String)address
//{
//    Json signedTx;
//    Json  result;
//    try {
//
//        signedTx=[self CalculateFeeAndSign:subWallet :json withPWD:payPasswd withFromAddress:address];
//        try {
//
//            result = subWallet->PublishTransaction(signedTx);
//
//
//        } catch (const std:: exception & e ) {
//
//            NSString *errString=[self stringWithCString:e.what()];
//            NSDictionary *dic=  [self dictionaryWithJsonString:errString];
//            [[FLTools share]showErrorInfo:dic[@"Message"]];
//            throw e;
//            return 0;
//        }
//
//     } catch (const std:: exception & e ) {
//
////        NSString *errString=[self stringWithCString:e.what()];
////        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
////        [[FLTools share]showErrorInfo:dic[@"Message"]];
//          throw e;
//        return 0;
//    }
//    return result;
//
//
//}
//- (Json)CalculateFeeAndSign:(ISubWallet*)subWallet :(Json)json withPWD:(String)payPasswd withFromAddress:(String)address
//{
//    uint64_t fee;
//       Json tmpTx;
//    Json retJson;
//    try {
//
//        fee = subWallet->CalculateTransactionFee(json, feePerKB);
//        try {
//
//            tmpTx = subWallet->UpdateTransactionFee(json, fee, address);
//            try {
//                retJson=  subWallet->SignTransaction(tmpTx, payPasswd);
//            } catch (const std:: exception & e ) {
//
//                NSString *errString=[self stringWithCString:e.what()];
//                NSDictionary *dic=  [self dictionaryWithJsonString:errString];
////                [[FLTools share]showErrorInfo:dic[@"Message"]];
//                 throw e;
//
//                return 0;
//            }
//
//        } catch (const std:: exception & e ) {
//
////            NSString *errString=[self stringWithCString:e.what()];
////            NSDictionary *dic=  [self dictionaryWithJsonString:errString];
////            [[FLTools share]showErrorInfo:dic[@"Message"]];
//             throw e;
//            return 0;
//        }
//    } catch (const std:: exception & e ) {
//
////        NSString *errString=[self stringWithCString:e.what()];
////        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
////        [[FLTools share]showErrorInfo:dic[@"Message"]];
//         throw e;
//        return 0;
//    }
//
//
//
//
//
//    return retJson;
//}
-(PluginResult *)accessFees:(invokedUrlCommand *)command{
    
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    String fromAddress = [self cstringWithString:args[idx++]];
   fromAddress=[self cstringWithString:@""];
    String toAddress = [self cstringWithString:args[idx++]];
    long amount = [args[idx++] integerValue];
    NSString *memoString=args[idx++];
    if (memoString.length==0) {
        memoString=@"11";
    }
    
    String memo =[self cstringWithString:memoString];
    
    String remark = [self cstringWithString:args[idx++]];
    Boolean useVotedUTXO =  [args[idx++] boolValue];
    //    String PWD = [self cstringWithString:args[idx++]];
    ISubWallet * suWall = [self getSubWallet:masterWalletID :chainID];
    Json josn;
    
    uint64_t fee;
    try {
        josn=suWall->CreateTransaction(fromAddress, toAddress, amount, memo, remark,useVotedUTXO);
    } catch (const std:: exception & err) {
       return [self errInfoToDic:err.what() with:command];
    }

    try {
         fee = suWall->CalculateTransactionFee(josn, feePerKB);
    } catch (const std:: exception & err) {
        return [self errInfoToDic:err.what() with:command];
    }
   
    
    return [self successProcess:command msg:[NSString stringWithFormat:@"%llu",fee]];
}
-(PluginResult *)sideChainTop_Up:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String fromSubWalletID        = [self cstringWithString:args[idx++]];
    String toSubWalletID = [self cstringWithString:args[idx++]];
    String from = [self cstringWithString:args[idx++]];
    String sidechainAddress = [self cstringWithString:args[idx++]];
    long amount = [args[idx++] integerValue];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    String pwd=[self cstringWithString:args[idx++]];
//    Boolean singleAddress =  [args[idx++] boolValue];
    Boolean singleAddress =  true;
    NSLog(@"sideChainTop_Up--%@--%@--%@--%@--%@--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:fromSubWalletID],[self stringWithCString:toSubWalletID],[self stringWithCString:from],[self stringWithCString:sidechainAddress],[NSString stringWithFormat:@"%ld",amount],[self stringWithCString:memo],[self stringWithCString:remark],[self stringWithCString:pwd]);
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    IMainchainSubWallet *mainchainSubWallet = dynamic_cast<IMainchainSubWallet *>(fromSubWallet);
    ISubWallet * toSubWallet=[self getSubWallet:masterWalletID :toSubWalletID];
    ISidechainSubWallet *sidechainSubWallet = dynamic_cast<ISidechainSubWallet *>(toSubWallet);
    String  lockedAddress = sidechainSubWallet->GetGenesisAddress();
 
    Json  sidechainAccounts;
    sidechainAccounts.push_back(sidechainAddress);
    
    Json sidechainAmounts;
    sidechainAmounts.push_back(amount);
    Json sidechainIndices;
    sidechainIndices.push_back(0);
    
//    Json tx = mainchainSubWallet->CreateDepositTransaction(
//                                                           from, lockedAddress, amount, sidechainAccounts, sidechainAmounts,
//                                                           sidechainIndices, memo,remark);
    
    Json tx;
   
    
    try {
        tx  =mainchainSubWallet->CreateDepositTransaction("", lockedAddress, amount, sidechainAddress,memo,remark,singleAddress);

    } catch (const std:: exception & e) {
        return [self errInfoToDic:e.what() with:command];
    }
    Json result;
//    try {
//       result = [self PublishTransaction:fromSubWallet :tx withPWD:pwd withFromAddress:from];
//
//    } catch (const std:: exception & e) {
//        return [self errInfoToDic:e.what() with:command];
//    }
    
    Json signedTx;
    try {
        
//        signedTx=[self CalculateFeeAndSign:fromSubWallet :json withPWD:payPasswd withFromAddress:address];
        
        uint64_t fee;
        Json tmpTx;
//        Json retJson;
        try {
            
            fee = fromSubWallet->CalculateTransactionFee(tx, feePerKB);
            try {
                
                tmpTx = fromSubWallet->UpdateTransactionFee(tx, fee, from);
                try {
                   signedTx=  fromSubWallet->SignTransaction(tmpTx, pwd);
                } catch (const std:: exception & e ) {
                    
                 return [self errInfoToDic:e.what() with:command];
                }
                
            } catch (const std:: exception & e ) {
                return [self errInfoToDic:e.what() with:command];
            }
        } catch (const std:: exception & e ) {
           return [self errInfoToDic:e.what() with:command];
        }
        
        
        
        
        

        
        
        
        
        try {
            
            result = fromSubWallet->PublishTransaction(signedTx);
            
            
        } catch (const std:: exception & e ) {
            return [self errInfoToDic:e.what() with:command];
        }
        
    } catch (const std:: exception & e ) {
        return [self errInfoToDic:e.what() with:command];
   
    }
  
    
    
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
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
    long amount = [args[idx++] integerValue];
     BOOL singleAddress =  [args[idx++] boolValue];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    //    String pwd=[self cstringWithString:args[idx++]];
    
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    IMainchainSubWallet *mainchainSubWallet = dynamic_cast<IMainchainSubWallet *>(fromSubWallet);
    ISubWallet * toSubWallet=[self getSubWallet:masterWalletID :toSubWalletID];
    ISidechainSubWallet *sidechainSubWallet = dynamic_cast<ISidechainSubWallet *>(toSubWallet);
    String  lockedAddress = sidechainSubWallet->GetGenesisAddress();
    
    Json  sidechainAccounts;
    sidechainAccounts.push_back(sidechainAddress);
    
    Json sidechainAmounts;
    sidechainAmounts.push_back(amount);
    Json sidechainIndices;
    sidechainIndices.push_back(0);
    Json tx;
    try {
        tx=mainchainSubWallet ->CreateDepositTransaction("", lockedAddress, amount, sidechainAddress, memo,remark,singleAddress);

    } catch (const std:: exception & e) {
    return   [self errInfoToDic:e.what() with:command];
        
    }
    uint64_t fee;
    try {
        fee = fromSubWallet->CalculateTransactionFee(tx, feePerKB);
    } catch (const std:: exception & e) {
         return   [self errInfoToDic:e.what() with:command];
    }
    return  [self successProcess:command msg:[NSString stringWithFormat:@"%llu",fee]];
   
   
}
-(PluginResult *)mainChainWithdrawal:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String fromSubWalletID = [self cstringWithString:args[idx++]];
    
    String from = [self cstringWithString:args[idx++]];
    String mainchainAddress = [self cstringWithString:args[idx++]];
    long amount = [args[idx++] integerValue];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    String pwd=[self cstringWithString:args[idx++]];
    NSLog(@"mainChainWithdrawal--%@--%@--%@--%@--%@--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:fromSubWalletID],[self stringWithCString:from],[self stringWithCString:mainchainAddress],[NSString stringWithFormat:@"ld", amount],[self stringWithCString:memo],[self stringWithCString:remark],[self stringWithCString:pwd]);
    
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    ISidechainSubWallet *sidechainSubWallet = dynamic_cast<ISidechainSubWallet *>(fromSubWallet);
    
//    Json mainchainAccounts;
//    mainchainAccounts.push_back(mainchainAddress);
//
//    Json mainchainAmounts;
//    mainchainAmounts.push_back(amount);
//    Json mainchainIndexs;
//    mainchainIndexs.push_back(0);
    Json tx;
    
    try {

        tx=sidechainSubWallet->CreateWithdrawTransaction("", amount, mainchainAddress, memo,remark);
    } catch (const std:: exception & e) {
        return  [self errInfoToDic:e.what() with:command];
    }
//     Json result;
//    try {
//         result = [self PublishTransaction:fromSubWallet :tx withPWD:pwd withFromAddress:from];
//
//    } catch (const std:: exception & e) {
//        return  [self errInfoToDic:e.what() with:command];
//    }
    
    Json signedTx;
//     Json tmpTx;
    Json  result;
//    try {
    
//        signedTx=[self CalculateFeeAndSign:fromSubWallet :tx withPWD:pwd withFromAddress:from];
        
        uint64_t fee;
       
        Json retJson;
        try {
            
            fee = fromSubWallet->CalculateTransactionFee(tx, feePerKB);
           
        } catch (const std:: exception & e ) {
            
         return  [self errInfoToDic:e.what() with:command];
        }
        try {
            
            signedTx = fromSubWallet->UpdateTransactionFee(tx, fee, from);
            
            
        } catch (const std:: exception & e ) {
            
            return  [self errInfoToDic:e.what() with:command];
        }
        
        try {
            retJson=  fromSubWallet->SignTransaction(signedTx, pwd);
        } catch (const std:: exception & e ) {
            
            return  [self errInfoToDic:e.what() with:command];
            
            
        }
        
        try {
            
            result = fromSubWallet->PublishTransaction(retJson);
            
            
        } catch (const std:: exception & e ) {
          return  [self errInfoToDic:e.what() with:command];
        }
        
//    } catch (const std:: exception & e ) {
//
//      return  [self errInfoToDic:e.what() with:command];
//    }
    
    
   
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
-(PluginResult *)mainChainWithdrawalFee:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String fromSubWalletID = [self cstringWithString:args[idx++]];
    
    String from = [self cstringWithString:args[idx++]];
    String mainchainAddress = [self cstringWithString:args[idx++]];
    long amount = [args[idx++] integerValue];
    String memo=[self cstringWithString:args[idx++]];
    String remark=[self cstringWithString:args[idx++]];
    ISubWallet * fromSubWallet=[self getSubWallet:masterWalletID :fromSubWalletID];
    ISidechainSubWallet *sidechainSubWallet = dynamic_cast<ISidechainSubWallet *>(fromSubWallet);
    
//    Json mainchainAccounts;
//    mainchainAccounts.push_back(mainchainAddress);
//
//    Json mainchainAmounts;
//    mainchainAmounts.push_back(amount);
//    Json mainchainIndexs;
//    mainchainIndexs.push_back(0);
    Json tx;
    try {
        

        tx=sidechainSubWallet->CreateWithdrawTransaction("", amount, mainchainAddress, memo,remark);

    } catch (const std:: exception & e) {
        return [self errInfoToDic:e.what() with:command];
    }
    uint64_t fee;
    try {
        fee = fromSubWallet->CalculateTransactionFee(tx, feePerKB);
    } catch (const std:: exception & e ) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    return [self successProcess:command msg:[NSString stringWithFormat:@"%llu",fee]];
}

-(IMainchainSubWallet*)getWalletELASubWallet:(NSString*)masterWalletID{
    
    IMasterWallet *masterWallet = mMasterWalletManager->GetWallet([masterWalletID UTF8String]);
    ISubWalletVector subWalletList = masterWallet->GetAllSubWallets();
    ISubWallet *subWallet = subWalletList[0];
    IMainchainSubWallet *mainchainSubWallet = dynamic_cast<IMainchainSubWallet *>(subWallet);
    return mainchainSubWallet;
}


//参加投票
-(NSInteger)RegisterProducerWithMainchainSubWallet:(IMainchainSubWallet*)ELA With:(FLJoinVoteInfoModel*)model{
    Json payload;
    Json tx;
    uint64_t fee;
    Json signedTx;
    Json result;
NSLog(@"RegisterProducerWithMainchainSubWallet--%@--%@--%@--%@--%@--%@--%@--%@",model.pubKey,model.nodePubKey,model.nickName,model.url,model.ipAddress,model.contryCode,model.pwd,model.acount);
    try {
       payload= ELA->GenerateProducerPayload([model.pubKey UTF8String], [model.nodePubKey UTF8String],[model.nickName UTF8String], [model.url UTF8String], [model.ipAddress UTF8String], model.contryCode.integerValue, [model.pwd UTF8String]);
        
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
    }
        
    try {
        
        tx = ELA->CreateRegisterProducerTransaction("", payload, model.acount*unitNumber,
                                                         "",[model.mark UTF8String],false);
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
    }
    try {
 
         fee = ELA->CalculateTransactionFee(tx, 10000);
} catch (const std:: exception & e ) {
    
    NSString *errString=[self stringWithCString:e.what()];
    NSDictionary *dic=  [self dictionaryWithJsonString:errString];
    [[FLTools share]showErrorInfo:dic[@"Message"]];
    return 0;
}
    try {
        
    tx = ELA->UpdateTransactionFee(tx, fee, "");
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
    }
    try {
        signedTx = ELA->SignTransaction(tx, [model.pwd UTF8String]);
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
    }
    try {
         result = ELA->PublishTransaction(signedTx);
    } catch (const std:: exception & e ) {
        
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return 0;
    }

        return fee;
 
    
}
-(NSInteger)UpdateProducerWithMainchainSubWallet:(IMainchainSubWallet*)ELA With:(FLJoinVoteInfoModel*)model
{
    NSLog(@"UpdateProducerWithMainchainSubWallet--%@--%@--%@--%@--%@--%@--%@--%@",model.pubKey,model.nodePubKey,model.nickName,model.url,model.ipAddress,model.contryCode,model.pwd,model.acount);
    try {
        std::string pubKey = ELA->GetPublicKeyForVote();
        std::string nodePubKey = ELA->GetPublicKey();
        std::string nickName = [model.nickName UTF8String];
        std::string url = [model.url UTF8String];
        std::string ipAddress = [model.ipAddress UTF8String];
        uint64_t location =model.contryCode.integerValue;
        
        nlohmann::json payload = ELA->GenerateProducerPayload(pubKey, nodePubKey, nickName, url, ipAddress,
                                                                             location, [model.pwd UTF8String]);
        
        nlohmann::json tx = ELA->CreateUpdateProducerTransaction("", payload, "", [model.mark UTF8String]);
        
        uint64_t fee = ELA->CalculateTransactionFee(tx, feePerKB);
        tx = ELA->UpdateTransactionFee(tx, fee, "");
        
        Json signedTx = ELA->SignTransaction(tx, [model.pwd UTF8String]);
        
        Json result = ELA->PublishTransaction(signedTx);
        return YES;

    } catch (const std:: exception & e ) {
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        //        NSLog(@"dddddd:%@",dic);
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return NO;
    }
    return YES;
}

-(BOOL)CancelProducer:(NSString*)mainchainSubWalletId Pwd:(NSString*)pwd{
 
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    
    try {
        std::string pubKey = mainchainSubWallet->GetPublicKeyForVote();
        
        nlohmann::json payload = mainchainSubWallet->GenerateCancelProducerPayload(pubKey, [pwd UTF8String]);
        
        nlohmann::json tx = mainchainSubWallet->CreateCancelProducerTransaction("", payload, "", "");
        
        uint64_t fee = mainchainSubWallet->CalculateTransactionFee(tx, feePerKB);
        
        tx = mainchainSubWallet->UpdateTransactionFee(tx, fee, "");
        
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        return YES;
        
    } catch (const std:: exception & e ) {
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        //        NSLog(@"dddddd:%@",dic);
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return NO;
    }
    return YES;
    
    
}

-(BOOL)RetrieveDeposit:(NSString*)mainchainSubWalletId acount:(double)acount Pwd:(NSString*)pwd{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    
    try {
        nlohmann::json tx = mainchainSubWallet->CreateRetrieveDepositTransaction(acount*unitNumber, "", "");
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        return YES;
        
    } catch (const std:: exception & e ) {
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return NO;
    }
    return YES;
}

-(BOOL)useMainchainSubWallet:(NSString*)mainchainSubWalletId ToVote:(NSArray*)publicKeys tickets:(NSInteger)stake pwd:(NSString*)pwd isChangeVote:(BOOL)change{

    String keys = [[ self arrayToJSONString:publicKeys] UTF8String];
    //nlohmann::json keys = [publicKeys modelToJSONObject];
    nlohmann::json tx ;
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    
    try {
        nlohmann::json tx = mainchainSubWallet->CreateVoteProducerTransaction("", stake*unitNumber,Json::parse(keys), "","", change);
        
        uint64_t fee = mainchainSubWallet->CalculateTransactionFee(tx, 10000);
        tx = mainchainSubWallet->UpdateTransactionFee(tx, fee, "");
        
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        NSString *ssss = [self stringWithJson:result];
        NSLog(@"投票结束:%@",ssss);
        return YES;
        
    } catch (const std:: exception & e ) {
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return NO;
    }
    return YES;
}
-(PluginResult *)GetAssetDetails:(invokedUrlCommand *)command{
    NSArray *args = command.arguments;
    NSLog(@"%@",args);
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];
    String assetID = [self cstringWithString:args[idx++]];
    ISubWallet *subWallet=[self getSubWallet:masterWalletID  :chainID];
    NSLog(@"GetAssetDetails--%@--%@--%@",[self stringWithCString:masterWalletID],[self stringWithCString:chainID],[self stringWithCString:assetID]);
    Json result;
    try {
      result=subWallet->GetAssetDetails(assetID);
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }

    
    NSString *jsonString = [self stringWithCString:result.dump()];
    NSDictionary *dic=[self dictionaryWithJsonString:jsonString];
    return [self successProcess:command msg:dic];
}
-(void)EMWMSaveConfigs{
    
    mMasterWalletManager->SaveConfigs();
    
}


@end



