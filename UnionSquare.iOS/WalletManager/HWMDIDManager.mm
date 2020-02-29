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
-(void)resolve{
    DID * did = NULL;
    DIDDocument * doc;
//    DIDStore_ListDID(store, DID_FILTER_ALL, DIDStore_GetDIDCallback *callback, void *context);
//     DIDURL *DIDURL_FromString(const char *idstring, DID *ref);

  
//    new DIDURL(did,"primary");
    DIDURL * didurl =DIDURL_FromString("primary", did);
    
    if (DIDStore_ContainsPrivateKey(store,did, didurl)) {
        doc=DID_Resolve(did);
    }else{
        //异步加载
        DIDStore_Synchronize(store, "密码");
        doc=DIDStore_LoadDID(store, did);
    }
    doc=DID_Resolve(did);
// ui 加载圈
    if (doc==NULL) {// 创建did
//        did=DID_New(<#const char *method_specific_string#>);
    }else{//展示did
        
    }
    
}
-(void)initDID{
    DIDAdapter*didAdapter = NULL;
    store=DIDStore_Initialize([self.mRootPath UTF8String], didAdapter);
    DID *did=NULL;
    DIDURL *didURL=NULL;
    if (DIDStore_ContainsPrivateKey(store, did, didURL)) {
        [self resolve];
    }else{
        
    }

    
}
//DIDAdapter *TestDIDAdapter_Create(const char *walletDir, const char *walletId,
//        const char *network, const char *resolver, GetPasswordCallback *callback)
//{
//    DIDAdaptor *adapter;
//    const char *password;
//
//    if (!walletDir || !walletId || !callback)
//        return NULL;
//
//    adapter = (DIDAdaptor*)calloc(1, sizeof(TestDIDAdaptor));
//    if (!adapter)
//        return NULL;
//
//    adapter->base.createIdTransaction = TestDIDAdaptor_CreateIdTransaction;
//    adapter->base.resolve = TestDIDAdapter_Resolver;
//
//    adapter->impl = SpvDidAdapter_Create(walletDir, walletId, network, resolver);
//    if (!adapter->impl) {
//        free(adapter);
//        return NULL;
//    }
//
//    adapter->passwordCallback = callback;
//    adapter->walletDir = strdup(walletDir);
//    adapter->walletId = strdup(walletId);

//    return (DIDAdapter*)adapter;
////}
-(void)creatDID:(id)data withPayPassWord:(NSString *)pwd{
//          0: English; 1: French; 2: Spanish;
//    *                             3: Japanese; 4: Chinese_simplified;
//    *                             5: Chinese_traditional;
    if (DIDStore_InitPrivateIdentity(store, [pwd UTF8String], "助记词", "私钥", 0, true) ==0) {//成功， 失败
        [self resolve];
    }else{//， 失败
        
    }
   
  doc=  DIDStore_ResolveDID(store, did, true);
    
    DIDURL * url  =DIDDocument_GetDefaultPublicKey(doc);
    PublicKey *pukey=DIDDocument_GetPublicKey(doc, url);
    
   const char *base58pubk=PublicKey_GetPublicKeyBase58(pukey);//公钥
     
         
  time_t periodValiditytime =DIDDocument_GetExpires(doc);//获得有效期
            
            //获得alia
//            doc.getExpires();
//            doc.setExpires(new Date());//guoqo
            //  doc.setAlias("");
//            VerifiableCredential cre = doc.getCredential("name");
//            cre.getSubject().getPropertyAsString("name");
    
    
    
    
}
-(void)restDID:(id)data withPayPassWord:(NSString *)pwd withName:(NSString*)name{
    
    doc=DIDStore_LoadDID(store, did);
    time_t endDate=NULL;
    DIDDocumentBuilder * build= DIDDocument_Modify(doc);
    DIDDocumentBuilder_SetExpires(build, endDate);
    DIDURL *url=DIDDocument_GetDefaultPublicKey(doc);
//                        build.setExpires(endDate);
    
//    Issuer * issuer = Issuer_Create(did,url );
//
//
//    NSDictionary *SelfProclaimedCredential=@{@"SelfProclaimedCredential"};
////
////                        String[] SelfProclaimedCredential = {"SelfProclaimedCredential"};
//    NSArray *props=@[@{@"name":name}];
//
//                        VerifiableCredential * vc = verifia(did)
//                                .id("name")//唯一标识一个VerifiableCredential 相同会覆盖
//                                .type(SelfProclaimedCredential)
//                                .expirationDate(endDate)
//                                .properties(props)
//                                .seal("");
//
//                        build.addCredential(vc);
//                        DIDDocument newDoc = build.seal("");
//                        didStore.storeDid(newDoc);//存储本地
//                        document.sign("aa111", "aa".getBytes());
//                        boolean flag = document.verify("aa", "aa".getBytes());
//                        // did.resolve();
//                        //did.setAlias("");
//                        didStore.publishDid(did, 1, "aa111111");//todo 直接publis  执行的是adpter的publish?
    
}
@end
