/*
 * Copyright (c) 2019 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include <string>
#include <vector>

// Copied and modified from "SDK/Common/typedefs.h" and "SDK/Common/uchar_vector.h"
class uchar_vector : public std::vector<unsigned char>
{
public:
    uchar_vector(const std::string& hex) { this->setHex(hex); }

    void setHex(std::string hex)
    {
        this->clear();

        // pad on the left if hex contains an odd number of digits.
        if (hex.size() % 2 == 1)
            hex = "0" + hex;

        this->reserve(hex.size() / 2);

        for (uint i = 0; i < hex.size(); i+=2) {
            uint byte;
            sscanf(hex.substr(i, 2).c_str(), "%x", &byte);
            this->push_back(byte);
        }
    }
};
typedef uchar_vector bytes_t;

// Copied and modified from "SDK/WalletCore/BIPs/Key.h"
namespace Elastos {
    namespace ElaWallet {
        class Key {
        public:
            Key() : _secp256k1_key(nullptr) {}
            bool SetPubKey(const bytes_t &pub);
            bool Verify(const bytes_t &message, const bytes_t &signature) const;
        private:
            void *_secp256k1_key;
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

