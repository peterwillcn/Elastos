//
//  HWMDIDManager.m
//  elastos wallet
//
//  Created by  on 2020/2/18.
//

#import "HWMDIDManager.h"
#import "MyUtil.h"
#include "ela_did.h"
#include "HDkey.h"
#include "crypto.h"
#include "didtest_adapter.h"
#import "HWMDIDAdapter.h"

HWMDIDAdapter

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
-(instancetype)init{
    if (self==nil) {
        self=[super init];
    }
     rootPath=[MyUtil getRootPath];
    return self;
}
-(void)initDID{
    DIDBackend_InitializeDefault("http://api.elastos.io:20606");
    HWMDIDAdapter *didAdapter=[[HWMDIDAdapter alloc]init];
//    DIDAdapter * didAdapter =;
    store=DIDStore_Open([[self mRootPath] UTF8String], didAdapter);
    DID *did=DID_FromString([self.mastWalletID UTF8String]);// 获取DID
    if (DIDSotre_ContainsPrivateKeys(store, did)) {//拉取
        [self resolve];
    }else{//创建
        DID *did=DID_New([self.mastWalletID UTF8String]);
        DIDURL *url=DIDURL_NewByDid(did, "default");
        const char uint8_t *privatekey=[self.privatekeyString UTF8String];
        DIDStore_StorePrivateKey(store,[self.passWord UTF8String],did,url, privatekey);
        DID_Destroy(did);
        DIDURL_Destroy(url);
    }

    
}
//从链上拉去信息
-(void)resolve{
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
    }else{//展示did
        
    }
    DID_Destroy(did);
    DIDURL_Destroy(didURL);
    
}
DIDAdapter *DIDAdapter_Create(const char *walletDir, const char *walletId,
        const char *network, const char *resolver, GetPasswordCallback *callback)
{
    DIDAdapter *adapter;
    const char *password;

    if (!walletDir || !walletId || !callback)
        return NULL;

    adapter = (DIDAdapter*) calloc(1, sizeof(10266));
    if (!adapter)
        return NULL;
    
    adapter->base.createIdTransaction =DIDAdaptor_CreateIdTransaction();
    adapter->base.resolve =DIDAdapter_Resolver;

    adapter->impl = SpvDidAdapter_Create(walletDir, walletId, network, resolver);
    if (!adapter->impl) {
        free(adapter);
        return NULL;
    }

    adapter->passwordCallback = callback;
    adapter->walletDir = strdup(walletDir);
    adapter->walletId = strdup(walletId);

    return (DIDAdapter*)adapter;
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
}
-(void)updateInfo{
    DID* did =DID_FromString([self.mastWalletID UTF8String]);
    DIDURL *url=DIDDocument_GetDefaultPublicKey(doc);
    doc=DIDStore_LoadDID(store, did);
    DIDDocumentBuilder *build=DIDDocument_Edit(doc);
    
    time_t endTime=0;
    DIDDocumentBuilder_SetExpires(build, endTime);
    Issuer *issuer=Issuer_Create(did, url, store);
    char * SelfProclaimedCredential []={"SelfProclaimedCredential"};

//                        Map<String, String> props = new HashMap<String, String>();
//                        props.put("name", name);
    Credential * cre=NULL;
//       Credential * cre= Issuer_CreateCredential(issuer, did, url, <#const char **types#>, <#size_t typesize#>, <#Property *properties#>, <#int size#>, <#time_t expires#>, <#const char *storepass#>)
//                        VerifiableCredential vc = issuer.issueFor(did)
//                                .id("name")//唯一标识一个VerifiableCredential 相同会覆盖
//                                .type(SelfProclaimedCredential)
//                                .expirationDate(endDate)
//                                .properties(props)
//                                .seal("");
    DIDDocumentBuilder_AddCredential(build, cre);
 DIDDocument * newDoc=  DIDDocumentBuilder_Seal(build, [self.passWord UTF8String]);
//    * @param
//    *      document                [in] The handle to DID Document.
//    * @param
//    *      keyid                    [in] Public key to sign.
//    *                                   If key = NULL, sdk will get default key from
//    *                                   DID Document.
//    * @param
//    *      storepass               [in] Pass word to sign.
//    * @param
//    *      sig                     [out] The buffer will receive signature data.
//    * @param
//    *      count                   [in] The size of data list.
//    * @return
//    *      0 on success, -1 if an error occurred.
    DIDStore_StoreDID(store, doc, "name");
//    DIDDocument_Sign(doc, url, [], <#char *sig#>, <#int count, ...#>)
    

//                        didStore.storeDid(newDoc);//存储本地
//                        document.sign("aa111", "aa".getBytes());
//                        boolean flag = document.verify("aa", "aa".getBytes());
//                        // did.resolve();
//                        //did.setAlias("");
//                        didStore.publishDid(did, 1, "aa111111");//todo 直接publis  执行的是adpter的publish?
    DID_Destroy(did);
         DIDURL_Destroy(URL);
    
}
-(void)creatDIDInfoWith:(id)data{
    const char *newmnemonic = Mnemonic_Generate(0);
     DIDStore_InitPrivateIdentity(store, [self.passWord UTF8String], [self.TheMnemonicWordString UTF8String], "", 0, false);
       Mnemonic_Free((void*)newmnemonic);

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
