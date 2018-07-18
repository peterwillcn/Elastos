// Copyright (c) 2012-2018 The Elastos Open Source Project
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#define CATCH_CONFIG_MAIN

#include <iostream>
#include <catch.hpp>
#include <boost/scoped_ptr.hpp>

#include "BRTransaction.h"

#include "Utils.h"
#include "BRBIP39Mnemonic.h"
#include "SingleAddressWallet.h"

using namespace Elastos::ElaWallet;

class TestListener : public Wallet::Listener {
public:
	virtual void balanceChanged(uint64_t balance) {
		std::cout << balance << std::endl;
	}

	virtual void onTxAdded(const TransactionPtr &transaction) {
		std::cout << "Added: " << Utils::UInt256ToString(transaction->getHash()) << std::endl;
	}

	virtual void onTxUpdated(const std::string &hash, uint32_t blockHeight, uint32_t timeStamp) {
		std::cout << "Updated: " << hash << std::endl;
	}

	virtual void onTxDeleted(const std::string &hash, bool notifyUser, bool recommendRescan) {
		std::cout << "Deleted: " << hash << std::endl;
	}
};

MasterPubKeyPtr createDummyPublicKey() {
	UInt512 seed;
	std::string phrase = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
	BRBIP39DeriveKey(seed.u8, phrase.c_str(), "");

	UInt256 chainCode = UINT256_ZERO;
	Key key;
	key.deriveKeyAndChain(chainCode, &seed, sizeof(seed), 3, 44, 0, 0);

	MasterPubKeyPtr masterPubKey(new MasterPubKey(*key.getRaw(), chainCode));
	return masterPubKey;
}

MasterPrivKey createDummyPrivateKey(const std::string &password) {
	UInt512 seed;
	std::string phrase = "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about";
	BRBIP39DeriveKey(seed.u8, phrase.c_str(), "");

	UInt256 chainCode = UINT256_ZERO;
	Key key;
	key.deriveKeyAndChain(chainCode, &seed, sizeof(seed), 3, 44, 0, 0);

	char rawKey[BRKeyPrivKey(key.getRaw(), nullptr, 0)];
	BRKeyPrivKey(key.getRaw(), rawKey, sizeof(rawKey));

	CMBlock ret(sizeof(rawKey));
	memcpy(ret, &rawKey, sizeof(rawKey));

	MasterPrivKey masterPrivKey;
	masterPrivKey.SetEncryptedKey(Utils::encrypt(ret, password));
	masterPrivKey.SetChainCode(chainCode);
	return masterPrivKey;
}

boost::filesystem::path tryInitDatabasePath() {
	boost::filesystem::path databasePath = "Data";
	databasePath /= "SingleAddressWallet";
	if (boost::filesystem::exists(databasePath))
		boost::filesystem::create_directory(databasePath);
	return databasePath;
}

TEST_CASE("Single address wallet Constructor method", "[Constructor]") {

	boost::filesystem::path	dbRoot = tryInitDatabasePath();

	boost::shared_ptr<Wallet::Listener> listener(new TestListener);
	std::string payPassword = "payPassword";

	SECTION("Normal procedure") {
		SharedWrapperList<Transaction, BRTransaction *> transactions;

		SingleAddressWallet singleAddressWallet(transactions, createDummyPublicKey(), listener);

		std::vector<std::string> addresses = singleAddressWallet.getAllAddresses();
		REQUIRE(addresses.size() == 1);
		REQUIRE(addresses[0] == "EdTnJ92D6quqRKTJULzXAu3Tgk3zbv12pQ");

		REQUIRE(singleAddressWallet.getBalance() == 0);
	}
	SECTION("Initialize with transactions") {
		SharedWrapperList<Transaction, BRTransaction *> transactions;

		ELATransaction *transaction = new ELATransaction;
		TransactionOutput *output = new TransactionOutput();
		output->setAmount(100000000);
		output->setAddress("EdTnJ92D6quqRKTJULzXAu3Tgk3zbv12pQ");
		transaction->outputs.push_back(output);
		transaction->raw.txHash = UINT256_ZERO;
		// FIXME cheat TransactionIsSign(), fix this after signTransaction works fine
		CMBlock code(10);
		CMBlock parameter(10);
		Program *program = new Program(code, parameter);
		transaction->programs.push_back(program);
		transactions.push_back(TransactionPtr(new Transaction(transaction, false)));

		ELATransaction *transaction2 = new ELATransaction;
		TransactionOutput *output2 = new TransactionOutput();
		output2->setAmount(200000000);
		output2->setAddress("EdTnJ92D6quqRKTJULzXAu3Tgk3zbv12pQ");
		transaction2->outputs.push_back(output2);
		transaction2->raw.txHash = Utils::UInt256FromString(
				"000000000000000002df2dd9d4fe0578392e519610e341dd09025469f101cfa1");
		// FIXME cheat TransactionIsSign(), fix this after signTransaction works fine
		CMBlock code2(10);
		CMBlock parameter2(10);
		Program *program2 = new Program(code2, parameter2);
		transaction2->programs.push_back(program2);
		transactions.push_back(TransactionPtr(new Transaction(transaction2, false)));

		SingleAddressWallet singleAddressWallet(transactions, createDummyPublicKey(), listener);

		std::vector<std::string> addresses = singleAddressWallet.getAllAddresses();
		REQUIRE(addresses.size() == 1);
		REQUIRE(addresses[0] == "EdTnJ92D6quqRKTJULzXAu3Tgk3zbv12pQ");

		REQUIRE(singleAddressWallet.getBalance() == 300000000);
	}
}

TEST_CASE("Single address wallet transaction related method", "[register,]") {
	boost::filesystem::path	dbRoot = tryInitDatabasePath();

	boost::shared_ptr<Wallet::Listener> listener(new TestListener);
	SharedWrapperList<Transaction, BRTransaction *> transactions;
	SingleAddressWallet singleAddressWallet(transactions, createDummyPublicKey(), listener);

	ELATransaction *transaction = new ELATransaction;
	TransactionOutput *output = new TransactionOutput();
	output->setAmount(100000000);
	output->setAddress("EdTnJ92D6quqRKTJULzXAu3Tgk3zbv12pQ");
	transaction->outputs.push_back(output);
	// FIXME cheat TransactionIsSign(), fix this after signTransaction works fine
	CMBlock code(10);
	CMBlock parameter(10);
	Program *program = new Program(code, parameter);
	transaction->programs.push_back(program);
	TransactionPtr txPtr(new Transaction(transaction, false));
	txPtr->getHash();
	REQUIRE(singleAddressWallet.registerTransaction(txPtr));

	REQUIRE(singleAddressWallet.getAllAddresses().size() == 1);
	REQUIRE(singleAddressWallet.getBalance() == 100000000);

	REQUIRE(singleAddressWallet.registerTransaction(
			TransactionPtr(new Transaction(transaction, false)))); //register the same transaction again
	REQUIRE(singleAddressWallet.getAllAddresses().size() == 1);

	//register the second transaction
	ELATransaction *transaction2 = new ELATransaction;
	TransactionOutput *output2 = new TransactionOutput();
	output2->setAmount(200000000);
	output2->setAddress("EdTnJ92D6quqRKTJULzXAu3Tgk3zbv12pQ");
	transaction2->outputs.push_back(output2);
	// FIXME cheat TransactionIsSign(), fix this after signTransaction works fine
	CMBlock code2(10);
	CMBlock parameter2(10);
	Program *program2 = new Program(code2, parameter2);
	transaction2->programs.push_back(program2);
	TransactionPtr tx2Ptr(new Transaction(transaction2, false));
	tx2Ptr->getHash();
	REQUIRE(singleAddressWallet.registerTransaction(tx2Ptr));

	REQUIRE(singleAddressWallet.getBalance() == 300000000);
}
