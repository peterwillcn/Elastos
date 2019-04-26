// Copyright (c) 2012-2018 The Elastos Open Source Project
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <SDK/Common/typedefs.h>
#include <nlohmann/json.hpp>
#include <SDK/WalletCore/Crypto/AES.h>
#include <SDK/Common/Log.h>
#include <SDK/WalletCore/BIPs/Base58.h>
#include <SDK/WalletCore/BIPs/HDKeychain.h>
#include <SDK/WalletCore/BIPs/Key.h>

#include <iostream>
#include "WalletCoreLib.h"

using namespace Elastos::ElaWallet;

const char* ela_sign_message(const char* message, const char* keystore, const char* password) {
    int success;

    try {
        nlohmann::json encryptedKeystore = nlohmann::json::parse(keystore);

        // Decrypt
        std::string iv   = encryptedKeystore["iv"];
        std::string ct   = encryptedKeystore["ct"];
        std::string salt = encryptedKeystore["salt"];
        std::string mode = encryptedKeystore["mode"];
        std::string aad  = encryptedKeystore["adata"];
        int ks = encryptedKeystore["ks"];

        bytes_t plain;
        plain = AES::DecryptCCM(ct, password, salt, iv, aad, ks);

        nlohmann::json plaintext = nlohmann::json::parse(std::string((char *)plain.data(), plain.size()));

        // Get root private key
        if (plaintext.find("xPrivKey") == plaintext.end() || plaintext["xPrivKey"] == "") {
            Log::error("Unsupport keystore");
        }

        std::string xPrivKey = plaintext["xPrivKey"];

        bytes_t extkey;
        success = Base58::CheckDecode(xPrivKey, extkey);
        if (!success) return nullptr;

        HDKeychain rootKey(extkey);

        // Sign
#if 1
        HDKeychain requestKey = rootKey.getChild("1'/0");
        Key key = requestKey;
#else
    //        Key key;
    //        bytes_t prvKey = rootKey.getChild("1'/0").privkey();
    //        key.SetPrvKey(prvKey);
#endif
        bytes_t signature = key.Sign(message);

        return strdup(signature.getHex().c_str());
    }
    catch (...) {
        return nullptr;
    }
}

const char* ela_get_pubkey(const char* keystore, const char* password) {
    int success;

    try {
        nlohmann::json encryptedKeystore = nlohmann::json::parse(keystore);

        // Decrypt
        std::string iv   = encryptedKeystore["iv"];
        std::string ct   = encryptedKeystore["ct"];
        std::string salt = encryptedKeystore["salt"];
        std::string mode = encryptedKeystore["mode"];
        std::string aad  = encryptedKeystore["adata"];
        int ks = encryptedKeystore["ks"];

        bytes_t plain;
        plain = AES::DecryptCCM(ct, password, salt, iv, aad, ks);

        nlohmann::json plaintext = nlohmann::json::parse(std::string((char *)plain.data(), plain.size()));

        // Get root private key
        if (plaintext.find("xPrivKey") == plaintext.end() || plaintext["xPrivKey"] == "") {
            Log::error("Unsupport keystore");
        }

        std::string xPrivKey = plaintext["xPrivKey"];

        bytes_t extkey;
        success = Base58::CheckDecode(xPrivKey, extkey);
        if (!success) return nullptr;

        HDKeychain rootKey(extkey);

        // Sign
#if 1
        HDKeychain requestKey = rootKey.getChild("1'/0");
        Key key = requestKey;
#else
    //        Key key;
    //        bytes_t prvKey = rootKey.getChild("1'/0").privkey();
    //        key.SetPrvKey(prvKey);
#endif

        return strdup(requestKey.pubkey().getHex().c_str());
    }
    catch (...) {
        return nullptr;
    }
}


bool ela_verify_message(const char* public_key, const char* message, const char* signature) {
    try {
        Key verifyKey;
        verifyKey.SetPubKey(bytes_t(public_key));

        return verifyKey.Verify(message, bytes_t(signature));
    }
    catch (...) {
        return false;
    }
}

