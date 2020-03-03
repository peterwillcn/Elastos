//
//  DIDAdapter.c
//  elastos wallet
//
//  Created by 韩铭文 on 2020/2/27.
//

#include <stdlib.h>
#include <string.h>
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

#include "ela_did.h"
#include "DIDAdapter.h"
#include "spvadapter.h"

typedef struct DIDAdaptor {
    DIDAdapter base;
    SpvDidAdapter *impl;
    GetPasswordCallback *passwordCallback;
    char *walletDir;
    char *walletId;
} TestDIDAdaptor;

static const char *TestDIDAdaptor_CreateIdTransaction(DIDAdapter *_adapter, const char *payload, const char *memo)
{
    TestDIDAdaptor *adapter = (TestDIDAdaptor*)_adapter;
    const char *password;

    if (!adapter || !payload)
        return NULL;

    password = adapter->passwordCallback((const char *)adapter->walletDir,
            (const char *)adapter->walletId);

    printf("Waiting for wallet available");
    while (true) {
        if (SpvDidAdapter_IsAvailable(adapter->impl)) {
            printf(" OK");
            break;
        } else {
            printf(".");
        
//            sleep(30);
        }
    }

    return SpvDidAdapter_CreateIdTransaction(adapter->impl, payload, memo, password);
}

static const char *DIDAdapter_Resolver(DIDAdapter *_adapter, const char *did)
{
    TestDIDAdaptor *adapter = (TestDIDAdaptor*)_adapter;

    if (!adapter || !did)
        return NULL;

    return SpvDidAdapter_Resolve(adapter->impl, did, 0);
}

DIDAdapter *DIDAdapter_Create(const char *walletDir, const char *walletId,
        const char *network, const char *resolver, GetPasswordCallback *callback)
{
    TestDIDAdaptor *adapter;
    const char *password;

    if (!walletDir || !walletId || !callback)
        return NULL;

    adapter = (TestDIDAdaptor*)calloc(1, sizeof(TestDIDAdaptor));
    if (!adapter)
        return NULL;

    adapter->base.createIdTransaction = TestDIDAdaptor_CreateIdTransaction;
//    adapter->base.resolve = DIDAdapter_Resolver;// 需要构造方法

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

void DIDAdapter_Destroy(DIDAdapter *_adapter)
{
    TestDIDAdaptor *adapter = (TestDIDAdaptor*)_adapter;

    if (!adapter)
        return;

    if (adapter->impl)
        SpvDidAdapter_Destroy(adapter->impl);

    free(adapter->walletDir);
    free(adapter->walletId);

    free(adapter);
    adapter = NULL;
}
