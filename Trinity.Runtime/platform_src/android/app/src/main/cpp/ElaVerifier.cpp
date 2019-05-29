// Copyright (c) 2012-2018 The Elastos Open Source Project
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

// Copied and modified from "SDK/Common/typedefs.h"
// To avoid include boost headers
#define __ELASTOS_SDK_TYPEDEFS_H__
#include <SDK/Common/uchar_vector.h>
typedef uchar_vector bytes_t;

// Copied and modified from "SDK/WalletCore/BIPs/Key.h"
namespace Elastos {
    namespace ElaWallet {
        class Key {
        public:
            Key();
            bool SetPubKey(const bytes_t &pub);
            bool Verify(const bytes_t &message, const bytes_t &signature) const;
        };
    }
}

#include "ElaVerifier.h"

using namespace Elastos::ElaWallet;
bool ela_verify_message(const char* public_key, const char* message, const char* signature) {
    try {
        Key verifyKey;
        verifyKey.SetPubKey(bytes_t(public_key));

        return verifyKey.Verify(bytes_t(message), bytes_t(signature));
    }
    catch (...) {
        return false;
    }
}

