// Copyright (c) 2012-2018 The Elastos Open Source Project
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include "Utils.h"
#include "ParamChecker.h"
#include "SubAccountGenerator.h"
#include "HDSubAccount.h"
#include "SingleSubAccount.h"
#include "MultiSignAccount.h"
#include "MultiSignSubAccount.h"

namespace Elastos {
	namespace ElaWallet {

		SubAccountGenerator::SubAccountGenerator() :
				_resultChainCode(UINT256_ZERO) {

		}

		SubAccountGenerator::~SubAccountGenerator() {
			Clean();
		}

		ISubAccount *SubAccountGenerator::Generate() {
			MultiSignAccount *multiSignAccount = dynamic_cast<MultiSignAccount *>(_parentAccount);

			if (multiSignAccount != nullptr) {
				return new MultiSignSubAccount(_parentAccount);
			} else {
				if (_coinInfo.getSingleAddress()) {
					return new SingleSubAccount(_parentAccount);
				} else {
					if (_payPassword.empty()) {
						return GenerateFromCoinInfo(_parentAccount, _coinInfo);
					} else {
						return GenerateFromHDPath(_parentAccount, _coinInfo.getIndex(), _payPassword);
					}
				}
			}
		}

		void SubAccountGenerator::SetCoinInfo(const CoinInfo &coinInfo) {
			_coinInfo = coinInfo;
		}

		void SubAccountGenerator::SetParentAccount(IAccount *account) {
			_parentAccount = account;
		}

		void SubAccountGenerator::SetPayPassword(const std::string &password) {
			_payPassword = password;
		}

		void SubAccountGenerator::Clean() {
			_payPassword.clear();
		}

		const CMBlock &SubAccountGenerator::GetResultPublicKey() const {
			return _resultPubKey;
		}

		const UInt256 &SubAccountGenerator::GetResultChainCode() const {
			return _resultChainCode;
		}

		ISubAccount *SubAccountGenerator::GenerateFromCoinInfo(IAccount *account, const CoinInfo &coinInfo) {
			ParamChecker::checkNotEmpty(coinInfo.getPublicKey(), false);
			ParamChecker::checkNotEmpty(coinInfo.getChainCode(), false);

			CMBlock pubKey = Utils::decodeHex(coinInfo.getPublicKey());
			MasterPubKey masterPubKey = MasterPubKey(pubKey, Utils::UInt256FromString(coinInfo.getChainCode()));

			_resultChainCode = Utils::UInt256FromString(coinInfo.getChainCode());
			_resultPubKey = Utils::decodeHex(coinInfo.getPublicKey());

			return new HDSubAccount(masterPubKey, account, _coinInfo.getIndex());
		}

		ISubAccount *
		SubAccountGenerator::GenerateFromHDPath(IAccount *account, uint32_t coinIndex, const std::string &payPassword) {
			UInt512 seed = account->DeriveSeed(payPassword);
			BRKey key;
			BRBIP32PrivKeyPath(&key, &_resultChainCode, &seed, sizeof(seed), 3, 44 | BIP32_HARD,
							   coinIndex | BIP32_HARD, 0 | BIP32_HARD);
			var_clean(&seed);

			char rawKey[BRKeyPrivKey(&key, nullptr, 0)];
			BRKeyPrivKey(&key, rawKey, sizeof(rawKey));

			Key wrapperKey(key.secret, key.compressed);
			_resultPubKey = wrapperKey.getPubkey();

			MasterPubKey masterPubKey = MasterPubKey(key, _resultChainCode);

			return new HDSubAccount(masterPubKey, account, _coinInfo.getIndex());
		}
	}
}
