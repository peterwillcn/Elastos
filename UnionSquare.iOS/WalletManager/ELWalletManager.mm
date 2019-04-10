//
//  WalletManager.m
//  WalletManager
//
//  Created by xuhejun on 2018/12/10.
//  Copyright © 2018年 64. All rights reserved.
//

#import "ELWalletManager.h"

#import <Cordova/CDVCommandDelegate.h>
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

- (CDVPluginResult *)errCodeInvalidArg:(CDVInvokedUrlCommand *)command code:(int)code idx:(int)idx
{
    NSString *msg = [NSString stringWithFormat:@"%d %@", idx, @" parameters are expected"];
    return [self errorProcess:command code:code msg:msg];
}

- (CDVPluginResult *)successProcess:(CDVInvokedUrlCommand *)command  msg:(id) msg
{
    
    
    
    
    NSDictionary *dic = [self mkJson:keySuccess value:msg];
    
    //    NSString *json = [self dicToJSONString:dic];
    CDVPluginResult* pluginResult = nil;
    //    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:json];
    
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
    return pluginResult;
    
}
- (CDVPluginResult *)errorProcess:(CDVInvokedUrlCommand *)command  code : (int) code msg:(id) msg
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[NSNumber numberWithInteger:code] forKey:keyCode];
    [dic setValue:msg forKey:keyMessage];
    
    NSDictionary *jsonDic = [self mkJson:keyError value:dic];
    CDVPluginResult* pluginResult = nil;
    
    [[FLTools share]showErrorInfo:msg];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:jsonDic];
   
    return pluginResult;
}

-(CDVPluginResult *)errInfoToDic:(String)errInfo with:(CDVInvokedUrlCommand *)command{

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
//        NSLog(@"json解析失败：%@",err);
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
//    str = [str stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
//    if (str.length==0) {
//        return @"";
//    }
//    NSString *beginStr = [str substringWithRange:NSMakeRange(0, 1)];
//
//    NSString *result = str;
//    if([beginStr isEqualToString:@"\""])
//    {
//        result = [str substringWithRange:NSMakeRange(1, str.length - 1)];
//        //        result = [str stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
//    }
//    NSString *endStr = [result substringWithRange:NSMakeRange(result.length - 1, 1)];
//    if([endStr isEqualToString:@"\""])
//    {
//        //        [str stringByReplacingCharactersInRange:NSMakeRange(str.length - 1, 1) withString:@""];
//        result = [result substringWithRange:NSMakeRange(0, result.length - 1)];
//    }
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
- (CDVPluginResult *)coolMethod:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    return pluginResult;
}
- (CDVPluginResult *)print:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = nil;
    NSString *text = [command.arguments objectAtIndex:0];
    
    if(!text || ![text isEqualToString:@""])
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self parseOneParam:@"text" value:text]];
        
    }
    else
    {
        NSString *error = @"Text not can be null";
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error];
    }
    return pluginResult;
}

- (CDVPluginResult *)getAllMasterWallets:(CDVInvokedUrlCommand *)command
{
    
    try{
        
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
- (CDVPluginResult *)createMasterWallet:(CDVInvokedUrlCommand *)command
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

- (CDVPluginResult *)generateMnemonic:(CDVInvokedUrlCommand *)command
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
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
    return pluginResult;
    
}
- (CDVPluginResult *)createSubWallet:(CDVInvokedUrlCommand *)command
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
       json = subWallet->GetBasicInfo();
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    
    return [self successProcess:command msg:jsonString];
    
}
- (CDVPluginResult *)getAllSubWallets:(CDVInvokedUrlCommand *)command
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

- (CDVPluginResult *)getBalance:(CDVInvokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
    long type        = [ args[idx++] intValue];
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
- (CDVPluginResult *)getSupportedChains:(CDVInvokedUrlCommand *)command
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

- (CDVPluginResult *)getMasterWalletBasicInfo:(CDVInvokedUrlCommand *)command
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

- (CDVPluginResult *)getAllTransaction:(CDVInvokedUrlCommand *)command
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
- (CDVPluginResult *)createAddress:(CDVInvokedUrlCommand *)command
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
    String address;
    
    try {
        address = subWallet->CreateAddress();
    } catch (const std:: exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    
    
    NSString *jsonString = [self stringWithCString:address];
    return [self successProcess:command msg:jsonString];
    
}

- (CDVPluginResult *)getAllSubWalletAddress:(CDVInvokedUrlCommand *)command
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



- (CDVPluginResult *)getGenesisAddress:(CDVInvokedUrlCommand *)command
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

- (CDVPluginResult *)getMasterWalletPublicKey:(CDVInvokedUrlCommand *)command
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
    Json json ;
    try {
        json = masterWallet->GetPublicKey();
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    return [self successProcess:command msg:jsonString];
    
}

- (CDVPluginResult *)exportWalletWithKeystore:(CDVInvokedUrlCommand *)command
{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String backupPassword = [self cstringWithString:args[idx++]];
    String payPassword = [self cstringWithString:args[idx++]];
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

- (CDVPluginResult *)exportWalletWithMnemonic:(CDVInvokedUrlCommand *)command
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
        json = mMasterWalletManager->ExportWalletWithMnemonic(masterWallet, backupPassword);
    } catch (const std::exception &e) {
        return [self errInfoToDic:e.what() with:command];
    }
    NSString *jsonString = [self stringWithCString:json.dump()];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"”" withString:@""];
    return [self successProcess:command msg:jsonString];
    
}
- (CDVPluginResult *)changePassword:(CDVInvokedUrlCommand *)command
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

- (CDVPluginResult *)importWalletWithKeystore:(CDVInvokedUrlCommand *)command
{
    
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    Json keystoreContent = [self jsonWithString:args[idx++]];
    String backupPassword = [self cstringWithString:args[idx++]];
    String payPassword = [self cstringWithString:args[idx++]];
    
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

- (CDVPluginResult *)importWalletWithMnemonic:(CDVInvokedUrlCommand *)command
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
-(CDVPluginResult *)registerWalletListener:(CDVInvokedUrlCommand *)command{
    
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
- (CDVPluginResult *)DestroySubWallet:(CDVInvokedUrlCommand *)command{
    NSArray *args = command.arguments;
    int idx = 0;
    
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID        = [self cstringWithString:args[idx++]];
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
-(CDVPluginResult *)DestroyMasterWallet:(CDVInvokedUrlCommand *)command{
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
-(CDVPluginResult *)RemoveCallback:(CDVInvokedUrlCommand *)command{
    
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
-(CDVPluginResult *)CreateTransaction:(CDVInvokedUrlCommand *)command{
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
-(CDVPluginResult *)accessFees:(CDVInvokedUrlCommand *)command{
    
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
-(CDVPluginResult *)sideChainTop_Up:(CDVInvokedUrlCommand *)command{
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
-(CDVPluginResult *)sideChainTop_UpFee:(CDVInvokedUrlCommand *)command{
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
-(CDVPluginResult *)mainChainWithdrawal:(CDVInvokedUrlCommand *)command{
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
-(CDVPluginResult *)mainChainWithdrawalFee:(CDVInvokedUrlCommand *)command{
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
        //        DLog(@"dddddd:%@",dic);
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
        //        DLog(@"dddddd:%@",dic);
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return NO;
    }
    return YES;
    
    
}

-(BOOL)RetrieveDeposit:(NSString*)mainchainSubWalletId acount:(double)acount Pwd:(NSString*)pwd{
    IMainchainSubWallet* mainchainSubWallet  = [self getWalletELASubWallet:mainchainSubWalletId];
    
    try {
        nlohmann::json tx = mainchainSubWallet->CreateRetrieveDepositTransaction(acount*unitNumber, "", "");

//        uint64_t fee = mainchainSubWallet->CalculateTransactionFee(tx, feePerKB);
//        tx = mainchainSubWallet->UpdateTransactionFee(tx, fee, "");
        
        Json signedTx = mainchainSubWallet->SignTransaction(tx, [pwd UTF8String]);
        
        Json result = mainchainSubWallet->PublishTransaction(signedTx);
        return YES;
        
    } catch (const std:: exception & e ) {
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        //        DLog(@"dddddd:%@",dic);
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
        DLog(@"投票结束:%@",ssss);
        return YES;
        
    } catch (const std:: exception & e ) {
        NSString *errString=[self stringWithCString:e.what()];
        NSDictionary *dic=  [self dictionaryWithJsonString:errString];
        //        DLog(@"dddddd:%@",dic);
        [[FLTools share]showErrorInfo:dic[@"Message"]];
        return NO;
    }
    return YES;
   
}


-(CDVPluginResult *)GetAssetDetails:(CDVInvokedUrlCommand *)command{
   
    NSArray *args = command.arguments;
    int idx = 0;
    String masterWalletID = [self cstringWithString:args[idx++]];
    String chainID = [self cstringWithString:args[idx++]];
    String assetID = [self cstringWithString:args[idx++]];
    ISubWallet *subWallet=[self getSubWallet:masterWalletID  :chainID];
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

@end



