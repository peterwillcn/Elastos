//
//  DIDAdapter.h
//  elastos wallet
//
//  Created by 韩铭文 on 2020/2/27.
//

#ifndef DIDAdapter_h
#define DIDAdapter_h

#include <stdio.h>
#ifdef __cplusplus
extern "C" {
#endif

#include "ela_did.h"

typedef const char* (GetPasswordCallback)(const char *walletDir, const char *walletId);

DIDAdapter *DIDAdapter_Create(const char *walletDir, const char *walletId,
        const char *network, const char *resolver, GetPasswordCallback *callback);

void DIDAdapter_Destroy(DIDAdapter *adapter);

#ifdef __cplusplus
}
#endif
#endif /* DIDAdapter_h */
