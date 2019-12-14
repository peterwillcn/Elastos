import json
import time
import logging
import threading

from grpc_adenine import settings

from requests import Session
from decouple import config
from web3 import Web3, HTTPProvider
from web3.middleware import geth_poa_middleware

# Set up logging
logging.basicConfig(
    format='%(asctime)s %(levelname)-8s %(message)s',
    level=logging.DEBUG,
    datefmt='%Y-%m-%d %H:%M:%S'
)

global WalletAddresses, WalletAddressesETH

WalletAddresses = set()
WalletAddressesETH = set()

def create_wallet_mainchain(session):
    create_wallet_url = config('PRIVATE_NET_IP_ADDRESS') + config('WALLET_SERVICE_URL') + settings.WALLET_API_CREATE_WALLET
    response = session.get(create_wallet_url)
    data = json.loads(response.text)['result']
    return data['address'], data['privateKey']

def cronjob_send_ela():
    logging.debug("Running cron job to send ELA, ELA/DIDSC and ELA/DIDTOKEN")
    threading.Timer(300, cronjob_send_ela).start()
    if len(WalletAddresses) == 0:
        return
    headers = {
        'Accepts': 'application/json',
        'Content-Type': 'application/json'
    }
    session = Session()
    session.headers.update(headers)

    addrs_for_did, addrs_for_token = {}, {}
    req_data_mainchain = {
        "sender": [{
            "address": config('MAINCHAIN_WALLET_ADDRESS'),
            "privateKey": config('MAINCHAIN_WALLET_PRIVATE_KEY')
        }],
        "receiver": []
    }
    for chain, address in WalletAddresses:
        if chain == "mainchain":
            req_data_mainchain["receiver"].append({
                "address": address,
                "amount": "10"
            })
        else:
            new_address, new_private_key = create_wallet_mainchain(session)
            req_data_mainchain["receiver"].append({
                "address": new_address,
                "amount": "5.5"
            })
            if chain == "did":
                addrs_for_did[address] = (new_address, new_private_key)
            elif chain == "token":
                addrs_for_token[address] = (new_address, new_private_key)

    # Transfer from mainchain to mainchain
    transfer_ela_url = config('PRIVATE_NET_IP_ADDRESS') + config(
        'WALLET_SERVICE_URL') + settings.WALLET_API_TRANSFER
    response = session.post(transfer_ela_url, data=json.dumps(req_data_mainchain))
    tx_hash = json.loads(response.text)['result']
    logging.debug("Transferred 10 ELA. Tx Hash: {0}".format(tx_hash))

    # Wait for transaction to have one confirmation
    done = False
    while done != True:
        tx_url = config('PRIVATE_NET_IP_ADDRESS') + config('WALLET_SERVICE_URL') + settings.WALLET_API_GET_TRANSACTION + tx_hash
        response = session.get(tx_url)
        confirmation_times = json.loads(response.text)['result']['confirmations']
        if confirmation_times >= 1:
            done = True
        time.sleep(30)
    logging.debug("Finished transferring 10 ELA. Tx Hash: {0}".format(tx_hash))

    # Transfer from mainchain to did sidechain
    for address, wallet in addrs_for_did.items():
        req_data = {
            "sender": [{
                "address": wallet[0],
                "privateKey": wallet[1],
            }],
            "receiver": [{
                "address": address,
                "amount": "5"
            }]
        }
        transfer_ela_url = config('PRIVATE_NET_IP_ADDRESS') + config(
            'WALLET_SERVICE_URL') + settings.WALLET_API_CROSSCHAIN_TRANSFER
        response = session.post(transfer_ela_url, data=json.dumps(req_data))
        tx_hash = json.loads(response.text)['result']
        logging.debug("Transferred ELA/DIDSC. Tx Hash: {0}".format(tx_hash))

    # Transfer from mainchain to token sidechain
    for address, wallet in addrs_for_token.items():
        req_data = {
            "sender": [{
                "address": wallet[0],
                "privateKey": wallet[1],
            }],
            "receiver": [{
                "address": address,
                "amount": "5"
            }]
        }
        transfer_ela_url = config('PRIVATE_NET_IP_ADDRESS') + config(
            'WALLET_SERVICE_TOKENSIDECHAIN_URL') + settings.WALLET_API_CROSSCHAIN_TRANSFER_TOKENSIDECHAIN
        response = session.post(transfer_ela_url, data=json.dumps(req_data))
        tx_hash = json.loads(response.text)['result']
        logging.debug("Transferred ELA/TOKENSC. Tx Hash: {0}".format(tx_hash))

    WalletAddresses.clear()

def cronjob_send_ela_ethsc():
    logging.debug("Running cron job to send ELA/ETHSC")
    threading.Timer(30, cronjob_send_ela_ethsc).start()
    if len(WalletAddressesETH) == 0:
        return

    web3 = Web3(
        HTTPProvider("{0}{1}".format(config('PRIVATE_NET_IP_ADDRESS'), config('SIDECHAIN_ETH_RPC_PORT')),
                     request_kwargs={'timeout': 60}))
    web3.middleware_onion.inject(geth_poa_middleware, layer=0)
    amount = web3.toWei(5, 'ether')
    starting_nonce = web3.eth.getTransactionCount(web3.toChecksumAddress(config('SIDECHAIN_ETH_WALLET_ADDRESS')))
    for index, address in enumerate(WalletAddressesETH):
        transaction = {
            'to': web3.toChecksumAddress(address),
            'value': amount,
            'gas': 100000,
            'gasPrice': web3.eth.gasPrice,
            'nonce': starting_nonce + index
        }
        signed_tx = web3.eth.account.signTransaction(transaction, config('SIDECHAIN_ETH_WALLET_PRIVATE_KEY'))
        tx_hash = web3.eth.sendRawTransaction(signed_tx.rawTransaction)
        logging.debug("Transferred ELA/ETHSC to: {0} Tx Hash: {1}".format(address, web3.toHex(tx_hash)))
    WalletAddressesETH.clear()


cronjob_send_ela()
cronjob_send_ela_ethsc()