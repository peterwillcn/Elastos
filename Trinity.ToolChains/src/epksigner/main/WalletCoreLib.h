// Copyright (c) 2012-2018 The Elastos Open Source Project
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifdef __cplusplus
extern "C" {
#endif

void ela_init_verifier();
const char* ela_sign_message(const char* message, const char* keystore, const char* password);
const char* ela_get_pubkey(const char* keystore, const char* password);
bool ela_verify_message(const char* public_key, const char* message, const char* signature);

#ifdef __cplusplus
}
#endif
