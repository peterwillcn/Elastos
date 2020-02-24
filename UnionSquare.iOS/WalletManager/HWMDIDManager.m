//
//  HWMDIDManager.m
//  elastos wallet
//
//  Created by 韩铭文 on 2020/2/18.
//

#import "HWMDIDManager.h"
#include "ela_did.h"
#include "HDkey.h"
#include"crypto.h"

#include "spvadapter.h"

static HWMDIDManager *_instance;
struct DIDStore store;
@interface HWMDIDManager ()

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
//-(DIDBackend *)didBackend{
//    if (!_didBackend) {
//        _didBackend=[DIDBackend initialize];
//    }
//    return _didBackend;
//}
-(void)resolve{

 DIDStore_ListDID(store, DID_FILTER_ALL, <#DIDStore_GetDIDCallback *callback#>, <#void *context#>)
    
//NSArray *dids =store
    
}

@end
