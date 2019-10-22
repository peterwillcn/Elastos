import os
import sys
import ctypes

def loadElaDIDLibrary():
    script_path = os.path.dirname(os.path.abspath(__file__))
    try:
        if sys.platform.startswith("darwin"):
            dll_name = "libeladid.1.dylib"
        else:
            dll_name = "libeladid.1.so"
        dll_path = os.path.abspath(os.path.join(script_path, '../lib', dll_name))
        dll_handle = ctypes.CDLL(dll_path, ctypes.RTLD_GLOBAL)
        assert dll_handle
    except:
        print('Failed to load "' + dll_name + '" library at ' + os.path.dirname(dll_path))
        exit(1)
    return dll_handle

def getElaDIDAPI():
    eladid = loadElaDIDLibrary()

    eladid.MAX_DID    = 128
    eladid.MAX_DIDURL = 256

    eladid.DIDStore_Open.restype = ctypes.c_int
    eladid.DIDStore_Open.argtypes = [
        ctypes.c_char_p     # root
    ]

    eladid.DIDStore_InitPrivateIdentity.restype = ctypes.c_int
    eladid.DIDStore_InitPrivateIdentity.argtypes = [
        ctypes.c_char_p,    # mnemonic
        ctypes.c_char_p,    # passphrase
        ctypes.c_char_p,    # storepass
        ctypes.c_int        # language
    ]

    eladid.DIDStore_NewDID.restype = ctypes.c_void_p # DIDDocument*
    eladid.DIDStore_NewDID.argtypes = [
        ctypes.c_char_p,    # storepass
        ctypes.c_char_p     # hint
    ]

    eladid.DIDDocument_GetSubject.restype = ctypes.c_void_p # DID*
    eladid.DIDDocument_GetSubject.argtypes = [
        ctypes.c_void_p,    # DIDDocument*
    ]

    eladid.DIDDocument_GetDefaultPublicKey.restype = ctypes.c_void_p # DIDURL*
    eladid.DIDDocument_GetDefaultPublicKey.argtypes = [
        ctypes.c_void_p,    # DIDDocument*
    ]

    eladid.DIDDocument_GetPublicKey.restype = ctypes.c_void_p # PublicKey*
    eladid.DIDDocument_GetPublicKey.argtypes = [
        ctypes.c_void_p,    # DIDDocument*
        ctypes.c_void_p,    # DIDURL*
    ]

    eladid.PublicKey_GetPublicKeyBase58.restype = ctypes.c_char_p # Base58 string
    eladid.PublicKey_GetPublicKeyBase58.argtypes = [
        ctypes.c_void_p,    # PublicKey**
    ]

    eladid.DIDURL_ToString.restype = ctypes.c_char_p
    eladid.DIDURL_ToString.argtypes = [
        ctypes.c_void_p,    # DIDURL*
        ctypes.c_char_p,    # idstring
        ctypes.c_size_t,    # len
        ctypes.c_bool,      # compact
    ]

    eladid.DID_ToString.restype = ctypes.c_char_p
    eladid.DID_ToString.argtypes = [
        ctypes.c_void_p,    # DID*
        ctypes.c_char_p,    # idstring
        ctypes.c_size_t,    # len
    ]
    return eladid

