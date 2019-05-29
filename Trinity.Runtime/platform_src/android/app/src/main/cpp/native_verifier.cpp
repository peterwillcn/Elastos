// Copyright (c) 2012-2018 The Elastos Open Source Project
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <jni.h>
#include "ElaVerifier.h"

extern "C"
JNIEXPORT jboolean JNICALL
Java_org_elastos_trinity_runtime_NativeVerifier_verify(JNIEnv *env, jclass type,
                                                       jstring public_key_, jstring payload_,
                                                       jstring signed_payload_) {
    const char *public_key = env->GetStringUTFChars(public_key_, 0);
    const char *payload = env->GetStringUTFChars(payload_, 0);
    const char *signed_payload = env->GetStringUTFChars(signed_payload_, 0);

    bool success = ela_verify_message(public_key, payload, signed_payload);

    env->ReleaseStringUTFChars(public_key_, public_key);
    env->ReleaseStringUTFChars(payload_, payload);
    env->ReleaseStringUTFChars(signed_payload_, signed_payload);

    return success ? JNI_TRUE : JNI_FALSE;
}
