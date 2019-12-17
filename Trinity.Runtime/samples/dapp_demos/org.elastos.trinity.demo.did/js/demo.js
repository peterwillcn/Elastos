//
// Copyright (c) 2019 Elastos Foundation
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

function set_msg(side, avatar, content) {
    var data = new Date();
    var msg = '<li class="' + side + '">' +
        '<a class="user" href="#">' +
        '<img class="img-responsive avatar_" src="./img/' + avatar + '.png" alt=""></a>' +
        '<div class="reply-content-box">' +
        '<span class="reply-time">' + data.toLocaleTimeString() + '</span>' +
        '<div class="reply-content pr"><span class="arrow">&nbsp;</span>' +
        content + '</div></div></li>';
    $("#msg_content").append(msg);
    $("html, body").animate({ scrollTop: $(document).height()}, "slow");
}

function display_me_msg(content) {
    set_msg("me", "avatar", content);
}

function display_others_msg(content) {
    set_msg("other", "avatar_rob", content);
}

var commands = [
// plugin commands
    { cmd: "openjson",  fn: openjson,               help: "openjson"    },
    { cmd: "help",      fn: help,                   help: "help [cmd]"  },
    { cmd: "version",   fn: get_version,            help: "version"     },
    { cmd: "createdoc", fn: createDocument,         help: "createdoc json"     },
    { cmd: "gm",        fn: generateMnemonic,       help: "gm "         },
    { cmd: "ismvalid",  fn: isMnemonicValid,        help: "ismvalid "   },

// DidStore
    { cmd: "init",      fn: initDIDStore,           help: "init"         },
    { cmd: "hasp",      fn: hasPrivateID,           help: "hasp"         },
    { cmd: "initp",     fn: initPrivateID,          help: "initp"        },
    { cmd: "sync",      fn: synchronize,            help: "sync"        },
    { cmd: "listdid",   fn: listDids,               help: "listdid type" },
    { cmd: "newdid",    fn: newDid,                 help: "newdid"       },
    { cmd: "ddid",      fn: deleteDid,              help: "ddid"         },
    { cmd: "ld",        fn: loadDid,                help: "ld"         },
    { cmd: "storedid",  fn: storeDid,               help: "storedid"     },
    { cmd: "pd",        fn: publishDid,             help: "pd"           },
    { cmd: "ud",        fn: updateDid,              help: "ud"           },
    { cmd: 'rd',        fn: resolvedid,             help: "rd"           },

// DidDocment
    { cmd: "getsub",    fn: getSubject,             help: "getsub"      },
    { cmd: "getpkc",    fn: getPublicKeyCount,      help: "getpkc"      },
    { cmd: "getdpk",    fn: getDefaultPublicKey,    help: "getdpk"      },
    { cmd: "getpk",     fn: getPublicKey,           help: "getpk"       },
    { cmd: "getpks",    fn: getPublicKeys,          help: "getpks"       },
    { cmd: "addc",      fn: addCredential,          help: "addvc"       },
    { cmd: "sign",      fn: sign,                   help: "sign"        },
    { cmd: "verify",    fn: verify,                 help: "sign"        },
// Did
    { cmd: "getm",      fn: getMethod,              help: "getm"        },
    { cmd: "getms",     fn: getMethodSpecificId,    help: "getms"       },
    { cmd: "tostr",     fn: didToString,            help: "tostr"       },
    { cmd: "ccred",     fn: createCredential,       help: "ccred "      },
    { cmd: "listc",     fn: listCredentials,        help: "listdid type" },
    { cmd: "storec",    fn: storeCredential,        help: "storec"       },
    { cmd: "dc",        fn: deleteCredential,       help: "dc"           },
    { cmd: "lc",        fn: loadCredential,         help: "lc"           },
//PublicKey
    { cmd: "getpkb",    fn: getPublicKeyBase58,     help: "getpkb"      },
    { cmd: "getc",      fn: getController,          help: "getc"        },
//Credential
    { cmd: "geti",      fn: getInfo,                help: "geti"        },
]

function do_command(input) {
    var args = input.trim().match(/[^\s"]+|"([^"]*)"/g);
    if (!args || args[0] == "") {
        return;
    }

    args[0] = args[0].toLowerCase()

    for (var i = 0; i < commands.length; i++) {
        if (commands[i].cmd == args[0]) {
            commands[i].fn(args);
            return;
        }
    }
    display_others_msg("Unknown command:" + args[0]);
}

function help(args) {
    if (args.length > 1) {
        for (var i = 0; i < commands.length; i++) {
            if (commands[i].cmd == args[1]) {
                display_others_msg("Usage: :" + commands[i].help);
                return;
            }
        }
        display_others_msg("Usage: :" + commands[0].help);
    }
    else {
        var msg = "Available commands list: </br>"
        for (var i = 0; i < commands.length; i++) {
            msg += "&nbsp;&nbsp;" + commands[i].help + "</br>";
        }
        display_others_msg(msg);
    }
}

function onLauncher() {
    appManager.launcher();
}

function onClose() {
    appManager.close();
}

function get_version(args) {
    didManager.getVersion(
        function (version) {
            display_others_msg(version);
        },
        function (error) {
            display_others_msg("Get version error! " + error);
        }
    );
}

function createIdTransaction(payload, memo) {
    display_others_msg("createIdTransaction payload: " + payload);
}

function initDIDStore(args) {
     didManager.initDidStore(
         "didtest",
         createIdTransaction,
         function (ret) {
             didStore = ret;
             display_others_msg("initDidStore success. ");
         },
         function (error) {
             display_others_msg("initDIDStore error! " + error);
         }
     );
 }

function createDocument(args) {
    didManager.createDIDDocumentFromJson(
        documentJson,
        function (ret) {
            diddocment = ret;
            display_others_msg("CreateDIDDocumentFromJson success " + ret.objId);
        },
        function (error) {
            display_others_msg("CreateDIDDocumentFromJson error! " + error);
        }
    );
 }

function generateMnemonic(args) {
    didManager.generateMnemonic(
        args[1],
        function (ret) {
            mnemonic = ret;
            display_others_msg("generateMnemonic: " + ret);
        },
        function (error) {
            display_others_msg("generateMnemonic error! " + error);
        }
    );
}

function isMnemonicValid(args) {
    didManager.isMnemonicValid(
        args[1],
        mnemonic,
        function (ret) {
            display_others_msg("isMnemonicValid: " + ret);
        },
        function (error) {
            display_others_msg("isMnemonicValid error! " + error);
        }
    );
}

function hasPrivateID(args) {
    didStore.hasPrivateIdentity(
        function (ret) {
            display_others_msg("hasPrivateIdentity: " + ret);
        },
        function (error) {
            display_others_msg("hasPrivateIdentity error! " + error);
        }
    );
}

function initPrivateID(args) {
    didStore.initPrivateIdentity(
        0, "harvest goddess absorb secret drift rail smooth eight boy fresh faculty spawn", "12345678", "12345678", true,
        function (ret) {
            display_others_msg("initPrivateID success!");
        },
        function (error) {
            display_others_msg("initPrivateID error! " + error);
        }
    );
}

function synchronize(args) {
    didStore.synchronize(
        "12345678",
        function (ret) {
            display_others_msg("synchronize success!");
        },
        function (error) {
            display_others_msg("synchronize error! " + error);
        }
    );
}

function newDid(args) {
    didStore.newDid(
        "12345678",
        "didtest",
        function (didStr, did) {
            didString = didStr;
            diddocment = did;
            display_others_msg("newDid: " + didString);
        },
        function (error) {
            display_others_msg("newDid error! " + error);
        }
    );
}

function deleteDid(args) {
    didStore.deleteDid(
        didString,
        function (ret) {
            display_others_msg("deleteDID: " + ret);
        },
        function (error) {
            display_others_msg("deleteDID error! " + error);
        }
    );
}

function loadDid(args) {
    didStore.loadDid(
        didString,
        function (ret) {
            diddocment = ret;
            display_others_msg("loadDid: " + ret.objId);
        },
        function (error) {
            display_others_msg("loadDid error! " + error);
        },
    );
}

function storeDid(args) {
    didStore.storeDid(
        diddocment.objId,
        "didtest",
        function (ret) {
            display_others_msg("storeDid: " + ret);
        },
        function (error) {
            display_others_msg("storeDid error! " + error);
        }
    );
}

function publishDid(args) {
    didStore.publishDid(
        diddocment.objId,
        publickeyUrl,
        "12345678",
        function (ret) {
            display_others_msg("publishDid: " + ret);
        },
        function (error) {
            display_others_msg("publishDid error! " + error);
        }
    );
}

function updateDid(args) {
    didStore.updateDid(
        diddocment.objId,
        publickeyUrl,
        "12345678",
        function (ret) {
            display_others_msg("publishDid: " + ret);
        },
        function (error) {
            display_others_msg("publishDid error! " + error);
        }
    );
}

function resolvedid(args) {
    didStore.resolveDidDocument(
            "did:elastos:iWn6viHLPK9JZN1ixjZyLVEupvCXDoE69D",
            function (ret) {
                diddocment = ret;
                display_others_msg("resolvedid: " + ret.objId);
            },
            function (error) {
                display_others_msg("resolvedid error! " + error);
            }
        );
}
function listDids(args) {
    didStore.listDids(
        2,
        function (ret) {
            didString = ret[0]["did"];
            display_others_msg("listDids count: " + ret.length + "<br>" + JSON.stringify(ret));
        },
        function (error) {
            display_others_msg("listDids error! " + error);
        }
    );
}

// DIDDocument
function getSubject(args) {
    diddocment.getSubject(
        function (ret) {
            did = ret;
            display_others_msg("getSubject: " + ret.objId);
        },
        function (error) {
            display_others_msg("getSubject error! " + error);
        },
    );
}

function getPublicKeyCount(args) {
    diddocment.getPublicKeyCount(
        function (ret) {
            display_others_msg("getPublicKeyCount: " + ret);
        },
        function (error) {
            display_others_msg("getPublicKeyCount error! " + error);
        },
    );
}

function getDefaultPublicKey(args) {
    diddocment.getDefaultPublicKey(
        function (ret) {
            publickeyUrl = ret;
            display_others_msg("getDefaultPublicKey: " + ret);
        },
        function (error) {
            display_others_msg("getDefaultPublicKey error! " + error);
        },
    );
}

function getPublicKey(args) {
    diddocment.getPublicKey(
        publickeyUrl,
        function (ret) {
            publickey = ret;
            display_others_msg("getPublicKey: " + ret.objId);
        },
        function (error) {
            display_others_msg("getPublicKey error! " + error);
        }
    );
}

function getPublicKeys(args) {
    diddocment.getPublicKeys(
        function (ret) {
            publickeyUrl = ret.items[0]["id"];
            display_others_msg("getPublicKeys count: " + ret.items.length+ "<br>" + JSON.stringify(ret.items));
        },
        function (error) {
            display_others_msg("getPublicKeys error! " + error);
        }
    );
}

function addCredential(args) {
    diddocment.addCredential(
        vc.objId,
        function (ret) {
            display_others_msg("addCredential: " + ret);
        },
        function (error) {
            display_others_msg("addCredential error! " + error);
        }
    );
}

function sign(args) {
    diddocment.sign(
        "12345678",
        args[1],
        function (ret) {
            signString = ret;
            display_others_msg("sign: " + ret);
        },
        function (error) {
            display_others_msg("sign error! " + error);
        }
    );
}

function verify(args) {
    diddocment.verify(
        signString,
        args[1],
        function (ret) {
            display_others_msg("verify: " + ret);
        },
        function (error) {
            display_others_msg("verify error! " + error);
        }
    );
}

//DID
function getMethod(args) {
    did.getMethod(
        function (ret) {
            display_others_msg("DID getMethod: " + ret);
        },
        function (error) {
            display_others_msg("DID getMethod error! " + error);
        },
    );
}

function getMethodSpecificId(args) {
    did.getMethodSpecificId(
        function (ret) {
            display_others_msg("DID getMethodSpecificId: " + ret);
        },
        function (error) {
            display_others_msg("DID getMethodSpecificId error! " + error);
        },
    );
}

function didToString(args) {
    did.toString(
        function (ret) {
            display_others_msg("DID toString: " + ret);
        },
        function (error) {
            display_others_msg("DID toString error! " + error);
        },
    );
}

function createCredential(args) {
    let types = new Array();
        types[0] = "BasicProfileCredential";
        types[1] = "SelfProclaimedCredential";

    let props = {
        name: "elastos",
        email: "test@elastos.org",
        phone: "11111"
    }


    did.issueCredential(
        didString,
        "cred-1",
        types,
        15,
        props,
        "12345678",
        function (ret) {
            vc = ret;
            display_others_msg("createCredential success " + ret.objId);
        },
        function (error) {
            display_others_msg("createCredential error! " + error);
        }
    );
}

function listCredentials(args) {
    did.listCredentials(
        function (ret) {
            didUrlString = ret[0]["didurl"];
            let index=didUrlString.indexOf("#");
            didString = didUrlString.substring(0, index);
            vcId = didUrlString.substring(index + 1);
            display_others_msg("listCredentials count: " + ret.length+ "<br>" + JSON.stringify(ret));
        },
        function (error) {
            display_others_msg("listCredentials error! " + error);
        }
    );
}

function storeCredential(args) {
    did.storeCredential(
        vc,
        function (ret) {
            publickey = ret;
            display_others_msg("storeCredential: " + ret);
        },
        function (error) {
            display_others_msg("storeCredential error! " + error);
        }
    );
}

function deleteCredential(args) {
    did.deleteCredential(
        didUrlString,
        function (ret) {
            display_others_msg("deleteCredential: " + ret);
        },
        function (error) {
            display_others_msg("deleteCredential error! " + error);
        }
    );
}

function loadCredential(args) {
    did.loadCredential(
        didString,
        didUrlString,
        function (ret) {
            vc = ret;
            display_others_msg("loadCredential: " + ret.objId);
        },
        function (error) {
            display_others_msg("loadCredential error! " + error);
        }
    );
}

//PublicKey
function getPublicKeyBase58(args) {
    publickey.getPublicKeyBase58(
        function (ret) {
            display_others_msg("getPublicKeyBase58: " + ret);
        },
        function (error) {
            display_others_msg("getPublicKeyBase58 error! " + error);
        },
    );
}

function getController(args) {
    publickey.getController(
        function (ret) {
            did = ret;
            display_others_msg("getController: " + ret);
        },
        function (error) {
            display_others_msg("getController error! " + error);
        },
    );
}

//Credential
function getInfo(args) {
    vc.getFragment(
        function (ret) {
            display_others_msg("getFragment: " + ret);
        },
        function (error) {
            display_others_msg("getFragment error! " + error);
        },
    );

    vc.getType(
        function (ret) {
            display_others_msg("getType: " + ret);
        },
        function (error) {
            display_others_msg("getType error! " + error);
        },
    );

    vc.getIssuanceDate(
        function (ret) {
            display_others_msg("getIssuanceDate: " + ret);
        },
        function (error) {
            display_others_msg("getIssuanceDate error! " + error);
        },
    );

    vc.getExpirationDate(
        function (ret) {
            display_others_msg("getExpirationDate: " + ret);
        },
        function (error) {
            display_others_msg("getExpirationDate error! " + error);
        },
    );

    vc.getProperties(
        function (ret) {
            display_others_msg("getProperties: " + JSON.stringify(ret));
        },
        function (error) {
            display_others_msg("getProperties error! " + error);
        },
    );
}

function openjson(args) {
    openLocalFile("testdiddoc.json");
}

function errorHandler(e) {
    console.log('Error: ' + e.code);
}

function readFile(fileEntry) {
    fileEntry.file(function (file) {
        var reader = new FileReader();
        reader.onloadend = function() {
            documentJson = this.result;
        };
        reader.readAsText(file);
    }, errorHandler);
}

function openLocalFile(filename){
    window.resolveLocalFileSystemURL(cordova.file.applicationDirectory, function (fs) {
        fs.getFile(filename, { create: false }, readFile, errorHandler);
    });
}

let didStore = null;
let diddocment = null;
let did  = null;
let publickey = null;
let documentJson = null;
let vc = null;
let vcId = "";
let signString = "";
let didString = "";
let didUrlString = "";
let mnemonic = ""


var app = {
    // Application Constructor
    initialize: function () {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    onDeviceReady: function () {
        do_command("init");
        do_command("help");

        $("input").focus();
        $("input").bind('keypress', function (event) {
            if (event.keyCode == "13") {
                var content = $('input').val()
                if (content.trim() != "") {
                    display_me_msg($('input').val());
                    do_command($('input').val());
                    $('input').val('');
                }
            }
        });
    },
};

app.initialize();
