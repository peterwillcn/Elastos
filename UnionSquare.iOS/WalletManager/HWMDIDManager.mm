//
//  HWMDIDManager.m
//  elastos wallet
//
//  Created by  on 2020/2/18.
//


#import "HWMDIDManager.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define SIGNATURE_BYTES         64
static HWMDIDManager *_instance;
struct DIDStore *store;
struct  DIDDocument * doc;
struct DID *did;
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
static const char *DIDAdaptor_CreateIdTransaction(DIDAdapter *_adapter, const char *payload, const char *memo)
{


    return "1111111";
    
}
DIDAdapter *DIDAdapter_Create()
{
    DIDAdapter *adapter;
    const char *password;
    adapter = (DIDAdapter*) calloc(1, sizeof(DIDAdapter));
    if (!adapter)
        return NULL;
    adapter->createIdTransaction =DIDAdaptor_CreateIdTransaction;
    return (DIDAdapter*)adapter;
}

-(instancetype)init{
    if (self==nil) {
        self=[super init];
    }
//    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory
//    , NSUserDomainMask
//    , YES);
//    NSFileManager *fm=[NSFileManager alloc]
//    cachePaths.firstObject
    _mRootPath=[MyUtil DIDRootPath];
    return self;
    
}
-(BOOL)initDIDWithPWD:(NSString *)passWord withDIDString:(NSString*)DIDString
WithPrivatekeyString:(NSString*)privatekeyString
     WithmastWalletID:(NSString*)mastWalletID{
    NSDictionary *retul;
    self.passWord=passWord;
    self.DIDString=DIDString;
    self.privatekeyString=privatekeyString;
    self.mastWalletID=mastWalletID;
    DIDBackend_InitializeDefault("http://api.elastos.io:20606");
    DIDAdapter * didAdapter =DIDAdapter_Create();
const char *tmp =[_mRootPath UTF8String];
    store=DIDStore_Open(tmp, didAdapter);
    DID *did=DID_FromString([self.mastWalletID UTF8String]);// 获取DID
    if (DIDSotre_ContainsPrivateKeys(store, did)) {//拉取
        if ([self resolve]) {
               return YES;
        }else{
            return NO;
        }
    }else{//创建
        
//        DIDStore_InitPrivateIdentityFromRootKey(store,
//          [self.passWord UTF8String],[self.privatekeyString UTF8String], NO);
//        DID *did=DID_New([self.mastWalletID UTF8String]);
//        DIDURL *url=DIDURL_NewByDid(did, "default");
//
//        const uint8_t * Uprivatekey=(uint8_t*)[self.privatekeyString UTF8String];
//        DIDStore_StorePrivateKey(store,[self.passWord UTF8String],did,url,Uprivatekey);
//        DID_Destroy(did);
//        DIDURL_Destroy(url);
        return NO;
    }
    
}
//从链上拉去信息
-(BOOL)resolve{
    DID * did = DIDStore_GetDIDByIndex(store, [self.passWord UTF8String], 0);
    DIDURL *didURL=DIDURL_NewByDid(did, "primary");
    
    
    if (!DIDStore_ContainsPrivateKey(store,did, didURL)||!DIDStore_ContainsDID(store,did)) {
        doc=DIDStore_NewDID(store, [self.passWord UTF8String], "IDalias");
    }
    doc=DID_Resolve(did);
// ui 加载圈
    if (doc==NULL) {// 创建did
//        did=DID_New(<#const char *method_specific_string#>);

//        }
        DID_Destroy(did);
           DIDURL_Destroy(didURL);
        return NO;
    }else{//展示did
        DID_Destroy(did);
           DIDURL_Destroy(didURL);
       return YES;
    }
   
    
}


-(void)getDIDInfo{
   DID *did=DID_FromString([self.mastWalletID UTF8String]);// 获取DID
    doc=DIDStore_LoadDID(store, did);
    DIDURL *URL=DIDDocument_GetDefaultPublicKey(doc);
   PublicKey *pk= DIDDocument_GetPublicKey(doc, URL);
   const char * pkChar =  PublicKey_GetPublicKeyBase58(pk);
   time_t endTime= DIDDocument_GetExpires(doc);

//          VerifiableCredential cre = doc.getCredential("name");
    Credential * cre= DIDDocument_GetCredential(doc, URL);
    
//          cre.getSubject().getPropertyAsString("name");
    
    const char *suInfo  =  Credential_GetProperty(cre, "name");
    DID_Destroy(did);
       DIDURL_Destroy(URL);

    
//    reture suInfo;
}
-(BOOL)creatDIDWithInfo:(HWMDIDInfoModel*)model{
    int rt;
    DIDStore_InitPrivateIdentityFromRootKey(store,
             [self.passWord UTF8String],[self.privatekeyString UTF8String], NO);
           DID *did=DID_New([self.mastWalletID UTF8String]);
           DIDURL *url=DIDURL_NewByDid(did, "default");

           const uint8_t * Uprivatekey=(uint8_t*)[self.privatekeyString UTF8String];
         rt= DIDStore_StorePrivateKey(store,[self.passWord UTF8String],did,url,Uprivatekey);
    doc=DIDStore_NewDID(store,[self.passWord UTF8String],"name");
    
    DIDDocumentBuilder *build=DIDDocument_Edit(doc);
    time_t endTime=1678032512;
     rt= DIDDocumentBuilder_SetExpires(build, endTime);
      Issuer *issuer=Issuer_Create(did, url, store);
      char * SelfProclaimedCredential []={"SelfProclaimedCredential"};
      time_t   expires = DIDDocument_GetExpires(doc);
         const char *types[] = {"BasicProfileCredential", "PhoneCredential"};
         Property props[7];
         props[0].key = "name";
         props[0].value = "John";
         props[1].key = "gender";
         props[1].value = "Male";
         props[2].key = "nation";
         props[2].value = "Singapore";
         props[3].key = "language";
         props[3].value = "English";
         props[4].key = "email";
         props[4].value = "john@example.com";
         props[5].key = "twitter";
         props[5].value = "@john";
         props[6].key = "phone";
         props[6].value = "132780456";

        Credential * cre = Issuer_CreateCredential(issuer, did,url, types, 2, props, 7,
                 expires, [self.passWord UTF8String]);
      DIDDocumentBuilder_AddCredential(build, cre);
      DIDDocument * newDoc=  DIDDocumentBuilder_Seal(build, [self.passWord UTF8String]);
        rt=  DIDStore_StoreDID(store,newDoc, "name");
       char signature[SIGNATURE_BYTES * 2 + 16];
       uint8_t data[124];
  rt=  DIDDocument_Sign(newDoc,url,[self.passWord UTF8String], signature, 1, data, sizeof(data));
    rt= DIDDocument_Verify(newDoc, url, signature, 1, data, sizeof(data));
     const char *R= DIDStore_PublishDID(store, [self.passWord UTF8String], did, url);
          DID_Destroy(did);
           DIDURL_Destroy(url);
    return YES;
}
-(BOOL)updateInfoWithInfo:(HWMDIDInfoModel*)model{
    [self creatDIDWithInfo:model];
    int RT;
    DID* did =DID_FromString([self.mastWalletID UTF8String]);
    DIDURL *url=DIDDocument_GetDefaultPublicKey(doc);
    doc=DIDStore_LoadDID(store, did);
    DIDDocumentBuilder *build=DIDDocument_Edit(doc);
    
    time_t endTime=[model.editTimeString intValue];
   RT= DIDDocumentBuilder_SetExpires(build, endTime);
    Issuer *issuer=Issuer_Create(did, url, store);
    char * SelfProclaimedCredential []={"SelfProclaimedCredential"};
    time_t   expires = DIDDocument_GetExpires(doc);
       const char *types[] = {"BasicProfileCredential", "PhoneCredential"};
       Property props[7];
       props[0].key = "name";
       props[0].value = "John";
       props[1].key = "gender";
       props[1].value = "Male";
       props[2].key = "nation";
       props[2].value = "Singapore";
       props[3].key = "language";
       props[3].value = "English";
       props[4].key = "email";
       props[4].value = "john@example.com";
       props[5].key = "twitter";
       props[5].value = "@john";
       props[6].key = "phone";
       props[6].value = "132780456";

      Credential * cre = Issuer_CreateCredential(issuer, did,url, types, 2, props, 7,
               expires, [self.passWord UTF8String]);
    DIDDocumentBuilder_AddCredential(build, cre);
    DIDDocument * newDoc=  DIDDocumentBuilder_Seal(build, [self.passWord UTF8String]);
      RT=  DIDStore_StoreDID(store,newDoc, "name");
     char signature[SIGNATURE_BYTES * 2 + 16];
     uint8_t data[124];
  RT=  DIDDocument_Sign(newDoc,url,[self.passWord UTF8String], signature, 1, data, sizeof(data));
   RT= DIDDocument_Verify(newDoc, url, signature, 1, data, sizeof(data));
   const char *R= DIDStore_PublishDID(store, [self.passWord UTF8String], did, url);
        DID_Destroy(did);
         DIDURL_Destroy(url);
    
}
-(void)creatDIDInfoWith:(id)data{
 DIDStore_InitPrivateIdentityFromRootKey(store,
   [self.passWord UTF8String],"", NO);
    

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
@end
