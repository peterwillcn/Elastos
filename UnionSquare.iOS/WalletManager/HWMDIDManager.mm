//
//  HWMDIDManager.m
//  elastos wallet
//
//  Created by  on 2020/2/18.
//


#import "HWMDIDManager.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <stdio.h>
#import "ELWalletManager.h"
#import "JWT.h"
#import "MF_Base64Additions.h"
#import "NSObject+YYModel.h"

//#import "ELAWallet-Swift.h"
#define SIGNATURE_BYTES         64
static HWMDIDManager *_instance;
DIDStore *store;
DID *did;
const char *tmp;
@interface HWMDIDManager ()
@property(copy,nonatomic)NSString *mRootPath;
@end
@implementation HWMDIDManager
+(instancetype)allocWithZone:(struct _NSZone *)zone
{

    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}
// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+(instancetype)shareDIDManager
{
    //return _instance;
    // 最好用self 用DIDManager他的子类调用时会出现错误
  
    return [[self alloc]init];
}
// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}
typedef struct TestDIDAdaptor {
    DIDAdapter base;

    char *pwd;
    char *walletId;
} TestDIDAdaptor;

static const char *TestDIDAdaptor_CreateIdTransaction(DIDAdapter *_adapter, const char *payload, const char *memo)
{
    TestDIDAdaptor *adapter = (TestDIDAdaptor*)_adapter;
    
    NSString *password=[NSString stringWithFormat:@"%s",adapter->pwd];
    NSString * walletID=[NSString stringWithFormat:@"%s",adapter->walletId];
    NSString *payloadJsonString=[NSString stringWithFormat:@"%s",payload];
    NSString *memoString=[NSString stringWithFormat:@"%s",memo];
//    NSLog(@"password===%@---%@",password,payloadJsonString);
    

    if (!adapter || !payload)
        return NULL;
        invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[walletID,@"IDChain",password,memoString,@"",payloadJsonString] callbackId:walletID className:@"wallet" methodName:@"SpvDidAdapter_CreateIdTransactionEXWith"];
          PluginResult * resultBase =[[ELWalletManager share]SpvDidAdapter_CreateIdTransactionEXWith:cmommand];
            NSString *statusBase=[NSString stringWithFormat:@"%@",resultBase.status];

        if ([statusBase isEqualToString:@"1"] ) {
      
            return "0";
           
        }else{
            return "-1";
        }

}

DIDAdapter *TestDIDAdapter_Create(const char *pwd, const char *walletId)
{
    TestDIDAdaptor *adapter;
    
    adapter = (TestDIDAdaptor*)calloc(1, sizeof(TestDIDAdaptor));
    if (!adapter)
        return NULL;
    adapter->base.createIdTransaction = TestDIDAdaptor_CreateIdTransaction;
    NSString *pwdString=[NSString stringWithFormat:@"%s",pwd];
    if (![pwdString isEqualToString:@"1"]) {
        adapter->pwd=strdup(pwd);
        adapter->walletId = strdup(walletId);
    }
    return (DIDAdapter*)adapter;
}
-(instancetype)init{
    if (self==nil) {
        self=[super init];
         
    }
   _mRootPath=[MyUtil DIDRootPath];
    return self;
    
}
-(NSString*)hasDIDWithPWD:(NSString *)passWord withDIDString:(NSString*)DIDString
WithPrivatekeyString:(NSString*)privatekeyString
     WithmastWalletID:(NSString*)mastWalletID{
    NSInteger re;
    self.passWord=passWord;
    self.privatekeyString=privatekeyString;
    if (mastWalletID.length>0) {
    self.mastWalletID=mastWalletID;
    }
   
    if (DIDString.length>0) {
        self.DIDString=DIDString;
    }
    if (self.passWord.length>0) {
          invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.mastWalletID,self.passWord] callbackId:self.mastWalletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
           self.privatekeyString=[[ELWalletManager share]ExportxPrivateKey:mommand];
        if (self.privatekeyString.length==0) {
            return @"";
        }
    }
    // 添加null逻辑判断
    tmp =[[NSString stringWithFormat:@"%@%@",_mRootPath,self.mastWalletID] UTF8String];
    DIDAdapter * didAdapter = TestDIDAdapter_Create([self.passWord UTF8String],[self.mastWalletID UTF8String]);
    store=DIDStore_Open(tmp, didAdapter);
    if (store==NULL) {//
        return @"";
    }
   re= DIDBackend_InitializeDefault([didSDKNet UTF8String],tmp);// 变量
    if (self.privatekeyString.length!=0){
       if (!DIDStore_ContainsPrivateIdentity(store)) {//检测
        re = DIDStore_InitPrivateIdentityFromRootKey(store, [self.passWord UTF8String], [self.privatekeyString UTF8String], NO);//no 待定// 有失败的可能
           if (re==-1) {// 失败 是否在create的时候 补救
               return @"";
           }
       }
    }

    if (self.DIDString.length==0){
     did=DIDStore_GetDIDByIndex(store, 0);//
     char _didstring[ELA_MAX_DID_LEN];
     const char *didstring;
     didstring = DID_ToString(did, _didstring, sizeof(_didstring));
     self.DIDString=[self charToString:didstring];
    }else{
     did=DID_FromString([self.DIDString UTF8String]);// 获取DID
     char _didstring[ELA_MAX_DID_LEN];
        const char *didstring;
        didstring = DID_ToString(did, _didstring, sizeof(_didstring));
         self.DIDString=[self charToString:didstring];
    }
  DIDDocument *  doc=DID_Resolve(did,NO);
    if (doc) {//先看一下链上有没有
        DIDURL *url=DIDURL_NewByDid(did, "primary");
        if (DIDStore_ContainsPrivateKey(store,did, url)) {
            DIDStore_StoreDID(store, doc, "name");// 保存到本地
            DIDDocument *  nedoc=DIDStore_LoadDID(store, did);//绑定
            DID * newdid= DIDDocument_GetSubject(nedoc);
            DID_Copy(did, newdid);
            DIDURL_Destroy(url);
            DIDDocument_Destroy(doc);
            DIDDocument_Destroy(nedoc);
            return self.DIDString;
        }else{
            DIDDocument *reDoc=DIDStore_NewDIDByIndex(store, [self.passWord UTF8String], 0, "name");//
            if (reDoc) {
                DIDStore_StoreDID(store, reDoc, "name");// 保存到本地
                DID * newdid= DIDDocument_GetSubject(reDoc);
                DID_Copy(did, newdid);
                DIDDocument_Destroy(reDoc);
                return self.DIDString;
            }else{
                return @"";// 失败返回
            }
        }
    }else{//没有
       
        doc=DIDStore_LoadDID(store, did);
        if (doc==NULL) {
        doc=DIDStore_NewDIDByIndex(store, [self.passWord UTF8String], 0, "name");//
        DIDDocument_Destroy(doc);
        }
       return self.DIDString;
        
    }
}
-(NSDictionary*)getDIDInfo{
    if (did==nil||store==nil) {
        [[FLTools share]showErrorInfo:@"本地没有"];
        return nil;
    }
    DIDDocument *doc=DIDStore_LoadDID(store, did);
    DIDURL *url=DIDURL_NewByDid(did, "name");
    time_t endTime= DIDDocument_GetExpires(doc);
    Credential * cre= DIDDocument_GetCredential(doc,url);
    const char * suInfo = Credential_GetProperty(cre, "name");
    NSDictionary *reDic=@{@"nickName":[self charToString:suInfo],@"endTime":[NSString stringWithFormat:@"%@",@(endTime)],@"DIDString":self.DIDString};
    
    DIDURL_Destroy(url);
    DIDDocument_Destroy(doc);

    
    return reDic;
}
-(BOOL)updateInfoWithInfo:(HWMDIDInfoModel*)model{
    int RT;
    DIDURL *url=DIDURL_NewByDid(did, "name");
    DIDDocument *  doc=DIDStore_LoadDID(store, did);
    DIDDocumentBuilder *build=DIDDocument_Edit(doc);
    Credential *cr  =DIDDocument_GetCredential(doc, url);
    DIDDocument_Destroy(doc);
    time_t endTime=[model.endString intValue];
    if (cr) {
        DIDDocumentBuilder_RemoveCredential(build, url);
    }
    const char * types[1] = {"SelfProclaimedCredential"};//
    Property props[1];
    char * nickName =(char*)[model.didName UTF8String];
    props[0].key = "name";
    props[0].value = nickName;
    RT= DIDDocumentBuilder_AddSelfClaimedCredential(build, url, types,1,  props, 1, endTime, [self.passWord UTF8String]);
    
    DIDDocument * newDoc=  DIDDocumentBuilder_Seal(build, [self.passWord UTF8String]);
    RT=  DIDStore_StoreDID(store,newDoc, "name");// 已经签名
    const char *R = DIDStore_PublishDID(store, [self.passWord UTF8String], did, NULL,YES);
    NSString *reString=[self charToString:R];
    DIDURL_Destroy(url);
    DIDDocument_Destroy(newDoc);
    if ([reString isEqualToString:@"0"]) {
        return YES;
    }else{
        return NO;
    }
}
-(void)setPassWord:(NSString *)passWord{
    _passWord=passWord;
}
-(void)setDIDString:(NSString *)DIDString{
    _DIDString=DIDString;
}
-(void)setPrivatekeyString:(NSString *)privatekeyString{
    _privatekeyString=privatekeyString;
}
-(void)setMastWalletID:(NSString *)mastWalletID{
    _mastWalletID=mastWalletID;
}

-(NSString*)charToString:(const char*)needChar{
 return   [NSString stringWithFormat:@"%s",needChar];
    
}
-(BOOL)saveDIDCredentialWithDIDModel:(HWMDIDInfoModel*)model{// 保存本地凭证
    if (did==NULL||store==NULL) {
        return NO;
    }
    Issuer *isser=Issuer_Create(did, NULL, store);
    const char *types[1] = {"BasicProfileCredential"};//类型名称
    DIDURL *creatCredentialID=DIDURL_NewByDid(did, "outPut");// 相当于文件  不同的需求 需要创建不同的名字  只能通过这个别名 拿去 Credential
    Property props[1];// 根据需要传字段
    model.editTime=[[FLTools share]getNowTimeTimestampS];
    NSString *CredentialSubjectBean=[model modelToJSONString];
    
    char * nickName =(char *)[CredentialSubjectBean UTF8String];
    props[0].key = "BasicProfileCredential";
    props[0].value = nickName;
    time_t endTime=[model.endString integerValue];//
    Credential *c=  Issuer_CreateCredential(isser, did, creatCredentialID, types, 1, props, 1, endTime, [self.passWord UTF8String]);
    int r=DIDStore_StoreCredential(store, c, "outPut");
    Issuer_Destroy(isser);
    DIDURL_Destroy(creatCredentialID);
    Credential_Destroy(c);
    if (r==0) {
        return YES;
    }else{
        return NO;
    }
   
    
}
-(HWMDIDInfoModel*)readDIDCredential{// 获取did本地凭证
    DIDURL *url=DIDURL_NewByDid(did, "outPut");
    Credential * cre=DIDStore_LoadCredential(store, did, url);
    const char *suInfo  =  Credential_GetProperty(cre, "BasicProfileCredential");
    NSString *modelString=[self charToString:suInfo];
    HWMDIDInfoModel *model=[HWMDIDInfoModel modelWithJSON:modelString];
    if (model==nil) {
        model=[[HWMDIDInfoModel alloc]init];
    }
    model.nickname=@"ni";
    model.homePage=@"2222";
    model.did=@"did:elastos:ijGzfSU8TTy1B3uZq68dutJqdJv6o4YmUq"; model.avatar=@"https://image.so.com/view?ie=utf-8&src=hao_360so&q=a&correct=a&ancestor=list&cmsid=aeae7080d7553362fb896c1be8125034&cmras=1&cn=0&gn=0&kn=0&fsn=60&adstar=0&clw=236#id=36f045ee8adb193d1050cbf24be817e6&currsn=0&ps=60&pc=60";
    DIDURL_Destroy(url);
    return model;
    
}
//二维码验签名
-(BOOL)jwtSignatureWithDIDString:(NSString*)didString withSignature:(NSString*)signatureStr withUnSignature:(NSString*)UnSignature{
    int r;
    r= DIDBackend_InitializeDefault([didSDKNet UTF8String],tmp);// 变量
   char * signature= (char*)[signatureStr UTF8String];// 已经签名数据
  char * usignature= (char*)[UnSignature UTF8String];//未签名数据
    DID *jwtDID=DID_FromString([didString UTF8String]);
    DIDDocument * jwtDoc=DID_Resolve(jwtDID,NO);
    DIDURL *url=DIDURL_NewByDid(jwtDID, "primary");
//    PublicKey *pk= DIDDocument_GetPublicKey(jwtDoc, url);
    if (jwtDoc==NULL) {
        [[FLTools share]showErrorInfo:@"DID无效"];
        return NO;
    }
   r= DIDDocument_Verify(jwtDoc,url,signature, 1,usignature,strlen(usignature));
    DIDURL_Destroy(url);
    DID_Destroy(jwtDID);
    DIDDocument_Destroy(jwtDoc);
    if (r==0) {
        return YES;
    }else{
        [[FLTools share]showErrorInfo:@"验签失败!"];
        return NO;
    }

}

-(id)jwtDecodeWithJwtStringInfo:(NSString *)jwtStr {
  jwtStr=[jwtStr stringByReplacingOccurrencesOfString:@"elastos://credaccess/" withString:@""];
    
    NSArray * manySecrets = [jwtStr componentsSeparatedByString:@"."];
    NSString *base=[NSString stringFromBase64UrlEncodedString:manySecrets[1]];
      NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:[base dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
   NSString* UnSignature=[NSString stringWithFormat:@"%@.%@",[self removeSpaceAndNewline:manySecrets.firstObject],manySecrets[1]];

       UnSignature=[UnSignature stringByReplacingOccurrencesOfString:@"//n" withString:@""];
    if ([jsonDict[@"exp"] intValue]<[[[FLTools share]getNowTimeTimestampS] intValue])  {
    
       [[FLTools share]showErrorInfo:NSLocalizedString(@"二维码已过期", nil)];
        return nil;
    }
    
    if ([self jwtSignatureWithDIDString:jsonDict[@"iss"] withSignature:manySecrets.lastObject withUnSignature:UnSignature]) {
        return jsonDict;
    }
   

        return nil;
}
-(id)CRInfoDecodeWithJwtStringInfo:(NSString *)jwtStr {

    NSArray * manySecrets = [jwtStr componentsSeparatedByString:@"."];
    NSString *base=[NSString stringFromBase64UrlEncodedString:manySecrets[1]];
      NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:[base dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
//
//   NSString* UnSignature=[NSString stringWithFormat:@"%@.%@",[self removeSpaceAndNewline:manySecrets.firstObject],manySecrets[1]];
//
//       UnSignature=[UnSignature stringByReplacingOccurrencesOfString:@"//n" withString:@""];
//    if ([self jwtSignatureWithDIDString:jsonDict[@"id"] withSignature:manySecrets.lastObject withUnSignature:UnSignature]) {
        return jsonDict;
//    }
   

//        return nil;
}

- (NSString *)removeSpaceAndNewline:(NSString *)str

{

    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];

return text;

}
-(id)jwtInfo:(NSString*)jtwStr{
      NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:[jtwStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
      return jsonDict;
}


-(NSString*)DIDSignatureWithString:(NSString*)sigString{
    int r;
    if (store==NULL) {//
        return @"-1";
    }
    DIDDocument *doc=DIDStore_LoadDID(store, did);
    if (doc==NULL) {
        [[FLTools share]showErrorInfo:@"DID不存在"];
        return @"-1";
    }
    char signature[SIGNATURE_BYTES * 2 + 16];
    char *sig =(char *)[sigString UTF8String];
   r=DIDDocument_Sign(doc, NULL, [self.passWord UTF8String],
                     signature,1,sig,strlen(sig));
    if (r==0) {
        return [self charToString:signature];
    }
    return @"-1";
}
-(BOOL)ImportLocalCredentialsWithModel:(HWMDIDInfoModel*)model{
    
    return YES;
}

-(bool)CheckDIDwhetherExpiredWithDIDString:(NSString*)didString WithmastWalletID:(NSString*)walletID{
    
    [self hasDIDWithPWD:@"" withDIDString:didString WithPrivatekeyString:@"" WithmastWalletID:walletID];
    NSDictionary *dic=[self getDIDInfo];
    if ([dic[@"endTime"] intValue]<[[[FLTools share]getNowTimeTimestampS] intValue]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"DID已过期", nil)];
        return NO;
    }
    return YES;
}
@end
