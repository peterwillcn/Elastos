//
// Copyright (c) 2018 Elastos Foundation
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

//Data define
var connection_name = [
    "online",
    "offline"
];

var presence_name = [
    "none",    // None;
    "away",    // Away;
    "busy",    // Busy;
];

var bootstraps = [
    { ipv4: "13.58.208.50", port: "33445", publicKey: "89vny8MrKdDKs7Uta9RdVmspPjnRMdwMmaiEW27pZ7gh" },
    { ipv4: "18.216.102.47", port: "33445", publicKey: "G5z8MqiNDFTadFUPfMdYsYtkUDbX5mNCMVHMZtsCnFeb" },
    { ipv4: "18.216.6.197", port: "33445", publicKey: "H8sqhRrQuJZ6iLtP2wanxt4LzdNrN2NNFnpPdq1uJ9n2" },
    { ipv4: "52.83.171.135", port: "33445", publicKey: "5tuHgK1Q4CYf4K5PutsEPK5E3Z7cbtEBdx7LwmdzqXHL" },
    { ipv4: "52.83.191.228", port: "33445", publicKey: "3khtxZo89SBScAMaHhTvD68pPHiKxgZT6hTCSZZVgNEm" }
];

var opts = {
    udpEnabled: true,
    persistentLocation: ".data",
    bootstraps: bootstraps
};

var commands = [
    { cmd: "help", fn: help, help: "help [cmd]" },

    { cmd: "version", fn: get_version, help: "version" },
    { cmd: "address", fn: get_address, help: "address" },
    { cmd: "nodeid", fn: get_nodeid, help: "nodeid" },
    { cmd: "userid", fn: get_userid, help: "userid" },
    { cmd: "me", fn: self_info, help: "me [set] [name | description | gender | phone | email | region] [value]" },
    { cmd: "nospam", fn: self_nospam, help: "nospam [ value ]" },
    { cmd: "presence", fn: self_presence, help: "presence [ none | away | busy ]" },

    { cmd: "fadd", fn: friend_add, help: "fadd address hello" },
    { cmd: "faccept", fn: friend_accept, help: "faccept userid" },
    { cmd: "fremove", fn: friend_remove, help: "fremove userid" },
    { cmd: "friends", fn: list_friends, help: "friends" },
    { cmd: "friend", fn: show_friend, help: "friend userid" },
    { cmd: "label", fn: label_friend, help: "label userid name" },
    { cmd: "msg", fn: send_message, help: "msg userid message" },
    { cmd: "invite", fn: invite, help: "invite userid data" },
    { cmd: "ireply", fn: reply_invite, help: "ireply userid [confirm message | refuse reason]" },

    // { cmd: "sinit", fn: session_init, help: "sinit" },
    { cmd: "snew", fn: session_new, help: "snew userid" },
    { cmd: "speer", fn: session_peer, help: "speer" },
    { cmd: "srequest", fn: session_request, help: "srequest" },
    { cmd: "sreply", fn: session_reply_request, help: "sreply ok/sreply refuse [reason]" },
    { cmd: "sclose", fn: session_close, help: "sclose" },
    { cmd: "scleanup", fn: session_cleanup, help: "scleanup" },

    { cmd: "sadd", fn: stream_add, help: "sadd [plain] [reliable] [multiplexing] [portforwarding]" },
    { cmd: "sremove", fn: stream_remove, help: "sremove id" },
    { cmd: "swrite", fn: stream_write, help: "swrite streamid string" },
    { cmd: "sinfo", fn: stream_get_info, help: "sinfo id" },
    { cmd: "stype", fn: stream_get_type, help: "stype id" },
    { cmd: "sstate", fn: stream_get_state, help: "sstate id" },

    { cmd: "scopen", fn: stream_open_channel, help: "scopen stream [cookie]" },
    { cmd: "scclose", fn: stream_close_channel, help: "scclose stream channel" },
    { cmd: "scwrite", fn: stream_write_channel, help: "scwrite stream channel string" },
    { cmd: "scpend", fn: stream_pend_channel, help: "scpend stream channel" },
    { cmd: "scresume", fn: stream_resume_channel, help: "scresume stream channel" },

    { cmd: "spfadd", fn: session_add_service, help: "spfadd name tcp|udp host port" },
    { cmd: "spfremove", fn: session_remove_service, help: "spfremove name" },
    { cmd: "spfopen", fn: portforwarding_open, help: "spfopen stream service tcp|udp host port" },
    { cmd: "spfclose", fn: portforwarding_close, help: "spfclose stream pfid" },

    { cmd: "groupc", fn: group_create, help: "groupc" },
    { cmd: "groupj", fn: group_join, help: "groupj userid cookie" },
    { cmd: "groupi", fn: group_invite, help: "groupi friendId"},
    { cmd: "groupl", fn: group_leave, help: "groupl" },
    { cmd: "groupm", fn: group_msg, help: "groupm message" },
    { cmd: "groupt", fn: group_title, help: "groupt" },
    { cmd: "groupst", fn: group_set_title, help: "groupst groupTitle" },
    { cmd: "groupp", fn: group_get_peer, help: "groupp peerId" },
    { cmd: "groupps", fn: group_get_peers, help: "groupps" },
    { cmd: "groups", fn: group_get_groups, help: "groups" },

    { cmd: "ftnew", fn: new_file_transfer, help: "ftnew userid fileid filename size" },
    { cmd: "ftgenerateid", fn: ft_generate_fileId, help: "ftgenerateid" },
    { cmd: "ftgetfileid", fn: ft_get_fileid, help: "ftgetfileid filename" },
    { cmd: "ftgetfilename", fn: ft_get_filename, help: "ftgetfilename fileid" },
    { cmd: "ftconn", fn: ft_connect, help: "ftconn" },
    { cmd: "ftacceptconn", fn: ft_accept_connect, help: "ftacceptconn" },
    { cmd: "ftaddfile", fn: ft_add_file, help: "ftaddfile fileid filename size" },
    { cmd: "ftpulldata", fn: ft_pull_data, help: "ftpulldata fileId" },
    { cmd: "ftwritedata", fn: ft_write_data, help: "ftwritedata fileId data" },
    { cmd: "ftsendfinish", fn: ft_send_finish, help: "ftsendfinish fileId" },
    { cmd: "ftcancel", fn: ft_cancel, help: "ftcancel fileId status reason" },
    { cmd: "ftpend", fn: ft_pend, help: "ftpend fileId" },
    { cmd: "ftresume", fn: ft_resume, help: "ftresume fileId" },

    { cmd:"test",           fn:test,                   help:"test" },

    { cmd: "exit", fn: exit, help: "exit" }
]

function do_command(input) {
    var args = input.trim().match(/[^\s"]+|"([^"]*)"/g);
    if (!args || args[0] == "") {
        return;
    }

    args[0] = args[0].toLowerCase()

    for (var i = 1; i < args.length; i++) {
        if (args[i] == "address") {
            args[i] = "Y3P7rBL9jN1vtmXJey5dS4AUZPJMiUdyZiHh6hTTh6dCWHiPXKQY";
        }
        else if (args[i] == "userid") {
            args[i] = "F885rheKL2ejtwqp1gfYaTDnuwyreH7biQKqvybtJH7g";
        }
        else if (args[i] == "addri") {
            args[i] = "3Jmz5s2duMVNPC6yfCAxkgcbpFMtBu4DGn12o43hwevLWaPbqTC5";
        }
        else if (args[i] == "useri") {
            args[i] = "23s7kXkWMXWs9cpBAyGgQan2HAJQ6WX99ezC52uMUJRu";
        }
    }

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

function exit(args) {
    carrier.destroy();
}

function string_user_info(info) {
    var msg = "           ID: " + info.userId
        + "<br/>         Name: " + info.name
        + "<br/>  Description: " + info.description
        + "<br/>       Gender: " + info.gender
        + "<br/>        Phone: " + info.phone
        + "<br/>        Email: " + info.email
        + "<br/>       Region: " + info.region
    return msg;
}


function string_friend_info(info) {
    var msg = string_user_info(info.userInfo)
        + "<br/>     Label: " + info.label
        + "<br/>     Presence: " + presence_name[info.presence]
        + "<br/>   Connection: " + connection_name[info.status];
    return msg;
}

function get_version(args) {
    carrierManager.getVersion(
        function (version) {
            display_others_msg(version);
        },
        function (error) {
            display_others_msg("getVersion error! " + error);
        }
    );
}

function get_address(args) {
    display_others_msg(carrier.address);
}

function get_nodeid(args) {
    display_others_msg(carrier.nodeId);
}

function get_userid(args) {
    display_others_msg(carrier.userId);
}

function self_info(argv) {
    if (argv.length == 1) {
        carrier.getSelfInfo(function (info) {
            var msg = string_user_info(info);
            display_others_msg(msg);
        }
        );
    }
    else if (argv.length == 3 || argv.length == 4) {
        if (argv[1] != "set") {
            display_others_msg("Unknown sub command: " + argv[1]);
            return;
        }

        var value = "";
        if (argv.length == 4) value = argv[3];

        if (argv[2] == "name") {
            //            info.name = value;
        }
        else if (argv[2] == "description") {
            //            info.description = value;
        }
        else if (argv[2] == "gender") {
            //            info.gender = value;
        }
        else if (argv[2] == "phone") {
            //            info.phone = value;
        }
        else if (argv[2] == "email") {
            //            info.email = value;
        }
        else if (argv[2] == "region") {
            //            info.region = value;
        }
        else {
            display_others_msg("Invalid attribute name: " + argv[2]);
            return;
        }

        var str = "Set " + argv[2] + ":'" + argv[3] + "'";
        carrier.setSelfInfo(
            argv[2], argv[3],
            function (ret) {
                display_others_msg(str + " succeess.");
            },
            function (ret) {
                display_others_msg(str + " failed.");
            }
        );
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}

function self_nospam(argv) {
    if (argv.length == 1) {
        display_others_msg(carrier.nospam);
    }
    else if (argv.length == 2) {
        var nospam = parseInt(argv[1]);
        if (isNaN(nospam) || nospam == 0) {
            display_others_msg("Invalid nospam value to set.");
            return;
        }

        carrier.nospam = nospam;
        display_others_msg("User's nospam changed to be " + info.nospam + ".");
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}

function self_presence(argv) {
    var presence;
    if (argv.length == 1) {
        display_others_msg("Self presence: " + presence_name[carrier.presence]);
    }
    else if (argv.length == 2) {
        if (argv[1] == "none") {
            presence = carrierManager.PresenceStatus.NONE;
        }
        else if (argv[1] == "away") {
            presence = carrierManager.PresenceStatus.AWAY;
        }
        else if (argv[1] == "busy") {
            presence = carrierManager.PresenceStatus.BUSY;
        }
        else {
            display_others_msg("Invalid command syntax.");
            return;
        }

        carrier.presence = presence
        display_others_msg("User's presence changed to be " + argv[1] + ".");
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}

function friend_add(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function (info) {
        display_others_msg("Request to add a new friend succeess.");
    };
    var error = function (error) {
        display_others_msg("Request to add a new friend failed: " + error + ".");
    };
    carrier.addFriend(argv[1], argv[2], success, error);
}

function friend_accept(argv) {
    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function (info) {
        display_others_msg("Accept friend request success.");
    };
    var error = function (error) {
        display_others_msg("Accept friend request failed: " + error + ".");
    };
    carrier.acceptFriend(argv[1], success, error);
}

function friend_remove(argv) {
    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function (info) {
        display_others_msg("Remove friend " + argv[1] + " success.");
    };
    var error = function (error) {
        display_others_msg("Remove friend failed: " + error + ".");
    };
    carrier.removeFriend(argv[1], success, error);
}

function list_friends(argv) {
    if (argv.length != 1) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    carrier.getFriends(display_friends, null);
}

function show_friend(argv) {
    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function(info) {
        display_others_msg("Friend " + argv[1] + "information: <br/>" + string_friend_info(info));
    };
    var error = function (error) {
        display_others_msg("Get friend information failed: " + error + ".");
    };
    carrier.getFriend(argv[1], success, error);
}

function label_friend(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function(info) {
        display_others_msg("Update friend label success.");
    };
    var error = function (error) {
        display_others_msg("Update friend label failed: " + error + ".");
    };
    carrier.labelFriend(argv[1], argv[2], success, error);
}

function send_message(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function(info) {
        display_others_msg("Send message success.");
    };
    var error = function (error) {
        display_others_msg("Send message failed: " + error + ".");
    };
    carrier.sendFriendMessage(argv[1], argv[2], success, error);
}

function invite(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function(info) {
        display_others_msg("Send invite request success.");
    };
    var error = function (error) {
        display_others_msg("Send invite request failed: " + error + ".");
    };
    carrier.inviteFriend(argv[1], argv[2], invite_response_callback, success, error);
}

function reply_invite(argv) {
    var status = 0;
    var reason = null;
    var msg = null;

    if (argv.length != 4) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (argv[2] == "confirm") {
        msg = argv[3];
    }
    else if (argv[2] == "refuse") {
        status = -1; // TODO: fix to correct status code.
        reason = argv[3];
    } else {
        display_others_msg("Unknown sub command: " + argv[2]);
        return;
    }

    var success = function(info) {
        display_others_msg("Send invite reply to inviter success.");
    };
    var error = function (error) {
        display_others_msg("Send invite reply to inviter failed: " + error + ".");
    };
    carrier.replyFriendInvite(argv[1], status, reason, msg, success, error);
}

var mGroup = null ;
function group_create(argv) {
     var success = function(group) {
        mGroup = group;
        display_others_msg("group_create success.");
     };
     var error = function (error) {
        display_others_msg("group_create failed: " + error + ".");
     };
     carrier.newGroup(groupCallbacks, success, error);
}

function group_join(argv) {
    var success = function(group) {
       mGroup = group;
       display_others_msg("group_join success.<br/>");
    };
    var error = function (error) {
       display_others_msg("group_join failed: " + error + ".");
    };
    var friendId = argv[1];
    var cookieStr = argv[2];
    carrier.groupJoin(friendId, cookieStr, groupCallbacks, success, error);
}


function group_invite(argv) {
    var success = function(success) {
       display_others_msg("group_invite success.");
    };
    var error = function (error) {
       display_others_msg("group_invite failed: " + error + ".");
    };
    var friendId = argv[1] ;
    mGroup.invite(friendId, success, error);
}


function group_leave(argv) {
    var success = function(success) {
       mGroup = null ;
       display_others_msg("group_leave success.");
    };
    var error = function (error) {
       display_others_msg("group_leave failed: " + error + ".");
    };

    if (mGroup == null){
        display_others_msg("group is null");
        return ;
    }
    carrier.groupLeave(mGroup, success, error);
}

function group_msg(argv) {
    var success = function(success) {
       display_others_msg("group_msg success.");
    };
    var error = function (error) {
       display_others_msg("group_msg failed: " + error + ".");
    };
    var message = argv[1];
    mGroup.sendMessage(message, success, error);
}

function group_title(argv) {
    var success = function(title) {
       display_others_msg("group_title success.<br/>"+"groupTitle = "+title+".");
    };
    var error = function (error) {
       display_others_msg("group_title failed: " + error + ".");
    };
    mGroup.getTitle(success, error);
}

function group_set_title(argv) {
    var success = function(title) {
       display_others_msg("group_set_title success.<br/>"+"groupTitle = "+title+".");
    };
    var error = function (error) {
       display_others_msg("group_set_title failed: " + error + ".");
    };
    var title = argv[1];
    mGroup.setTitle(title, success, error);
}

function group_get_peer(argv) {
    var success = function(peer) {
       display_others_msg("group_get_peer success.<br/>"+"peerName = "+peer.peerName+";<br/> peerUserId = "+peer.peerUserId+".");
    };
    var error = function (error) {
       display_others_msg("group_get_peer failed: " + error + ".");
    };
    var peerId = argv[1];
    mGroup.getPeer(peerId, success, error);
}

function group_get_peers(argv) {
    var success = function(peers) {
       display_others_msg("group_get_peers success."+JSON.stringify(peers)+".");
    };
    var error = function (error) {
       display_others_msg("group_get_peers failed: " + error + ".");
    };
    mGroup.getPeers(success, error);
}

function group_get_groups(argv) {
    var success = function(groups) {
        var myGroups = [];
        myGroups = groups;
        display_others_msg("There are "+myGroups.length+" group object.");
    };
    var error = function (error) {
       display_others_msg("group_get_groups failed: " + error + ".");
    };
    carrier.getGroups(success, error);
}

var fileTransfer = null ;
function new_file_transfer(argv){
    var success = function(mFileTransfer) {
        fileTransfer = mFileTransfer ;
        display_others_msg("There are "+JSON.stringify(fileTransfer));
    };
    var error = function (error) {
       display_others_msg("new_file_transfer failed: " + error + ".");
    };

    var friendId = argv[1];
    var fileId = argv[2];
    var filename = argv[3];
    var size = argv[4];

    var fileTransferInfo = new Object();
    fileTransferInfo.filename = filename ;
    fileTransferInfo.fileId = fileId ;
    fileTransferInfo.size = size ;

    carrier.newFileTransfer(friendId, fileTransferInfo, fileTransferCallbacks, success, error);
}

function ft_generate_fileId(argv){
    var success = function(fileId){
        display_others_msg("generate_fileId : "+ fileId);
    };

    carrier.generateFileId(success);
}

function ft_get_fileid(argv){
    var success = function(fileId){
        display_others_msg("get file id : "+ fileId);
    };
    var error = function (error) {
       display_others_msg("ft_get_fileid failed: " + error + ".");
    };
    if (fileTransfer){
        var filename = argv[1];
        fileTransfer.getFileId(filename, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_get_filename(argv){
    var success = function(filename){
        display_others_msg("get filename : "+ filename);
    };
    var error = function (error) {
       display_others_msg("ft_get_filename failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        fileTransfer.getFileName(fileId, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_connect(argv){
    var success = function(success){
        display_others_msg("ft_connect : "+ success);
    };
    var error = function (error) {
       display_others_msg("ft_connect failed: " + error + ".");
    };
    if (fileTransfer){
        fileTransfer.connect(success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_accept_connect(argv){
    var success = function(success){
        display_others_msg("ft_accept_connect : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_accept_connect failed: " + error + ".");
    };
    if (fileTransfer){
        fileTransfer.acceptConnect(success , error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_add_file(argv){
    var success = function(success){
        display_others_msg("ft_add_file : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_add_file failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        var filename = argv[2];
        var size = argv[3];

        var fileTransferInfo = new Object();
        fileTransferInfo.filename = filename ;
        fileTransferInfo.fileId = fileId ;
        fileTransferInfo.size = size ;

        fileTransfer.addFile(fileTransferInfo, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_pull_data(argv){
    var success = function(success){
        display_others_msg("ft_pull_data : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_pull_data failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        fileTransfer.pullData(fileId , 0, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}


function ft_write_data(argv){
    var success = function(success){
        display_others_msg("ft_write_data : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_write_data failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        var data = argv[2];
        fileTransfer.writeData(fileId, data, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_send_finish(argv){
    var success = function(success){
        display_others_msg("ft_send_finish : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_send_finish failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        fileTransfer.sendFinish(fileId, success , error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_cancel(argv){
    var success = function(success){
        display_others_msg("ft_cancel : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_cancel failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        var status = argv[2];
        var reason = argv[3];
        fileTransfer.cancelTransfer(fileId, status, reason, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_pend(argv){
    var success = function(success){
        display_others_msg("ft_pend : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_pend failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        fileTransfer.pendTransfer(fileId, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}

function ft_resume(argv){
    var success = function(success){
        display_others_msg("ft_resume : "+success);
    };
    var error = function (error) {
       display_others_msg("ft_resume failed: " + error + ".");
    };
    if (fileTransfer){
        var fileId = argv[1];
        fileTransfer.resumeTransfer(fileId, success, error);
    } else {
        display_others_msg("please create file transfer firstly");
    }
}


//-----------------------------------------------------------------------------
var session;
var session_ctx = {
    remote_sdp: "",
    unchanged_streams: 0,
    need_start: false,
}

function session_request_callback(event) {
    session_ctx.remote_sdp = event.sdp;
    var msg = "Session request from[" + event.from + "] with SDP:" + event.sdp
        + "<br/>Reply use following commands:"
        + "<br/>  1. snew " + event.from
        + "<br/>  2. sreply refuse [reason]"
        + "<br/>OR:"
        + "<br/>  1. snew " + event.from
        + "<br/>  2. sadd [plain] [reliable] [multiplexing] [portforwarding]"
        + "<br/>  3. sreply ok";
    display_others_msg(msg);
}

function session_start() {
    var success = function(info) {
        display_others_msg("Session start success.");
    };
    var error = function (error) {
        display_others_msg("Session start inviter failed: " + error + ".");
    };
    session.start(session_ctx.remote_sdp, success, error);
}

function session_request_complete_callback(event) {
    if (event.status != 0) {
        display_others_msg("Session complete, status: " + event.status + ", reason:" + event.reason);
    }
    else {
        session_ctx.remote_sdp = event.sdp;
        session_start();
    }
}

function stream_on_data(event) {
    display_others_msg("Stream [" + event.stream.id + "] received data [" + window.atob(event.data) + "]");
}

function stream_on_state_changed(event) {
    var state_name = [
        "raw",
        "initialized",
        "transport_ready",
        "connecting",
        "connected",
        "deactivated",
        "closed",
        "failed"
    ];

    var msg = "Stream [" + event.stream.id + "] state changed to: " + state_name[event.state];
    display_others_msg(msg);

    if (event.state == carrierManager.StreamState.TRANSPORT_READY) {
        --session_ctx.unchanged_streams;
        if ((session_ctx.unchanged_streams == 0) && (session_ctx.need_start)) {
            session_start();
            session_ctx.need_start = false;
        }
    }
}

function on_channel_open(event) {
    display_others_msg("Stream request open new channel:" + event.channel + " cookie:" + event.cookie);
    return true;
}

function on_channel_opened(event) {
    display_others_msg("Channel " + event.stream.id + ":" + event.channel + " opened.");
}

function on_channel_close(event) {
    display_others_msg("Channel " + event.stream.id + ":" + event.channel + " closed.");
}

function on_channel_data(event) {
    display_others_msg("Channel " + event.stream.id + ":" + event.channel + " received data [" + window.atob(event.data) + "]");
    return true;
}

function on_channel_pending(event) {
    display_others_msg("Channel " + event.stream.id + ":" + event.channel + " is pending.");
}

function on_channel_resume(event) {
    display_others_msg("Channel " + event.stream.id + ":" + event.channel + " resumed.");
}

function session_init(argv) {
    if (argv.length != 1) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    session_ctx.remote_sdp = "";
    var ret = carrier.initSession(session_request_callback);
    if (!ret) {
        display_others_msg("Session initialized failed.");
    }
    else {
        display_others_msg("Session initialized successfully.");
    }
}

function session_cleanup(argv) {
    if (argv.length != 1) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    carrier.cleanupSession();
    display_others_msg("Session cleaned up.");
}

function session_new(argv) {
    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var success = function(_session) {
        display_others_msg("Create session successfully.");
        session = _session;
        session_ctx.need_start = false;
        session_ctx.unchanged_streams = 0;
    };
    var error = function (error) {
        display_others_msg("Create session failed. " + error);
    };
    carrier.newSession(argv[1], success, error);
}

function session_close(argv) {
    if (argv.length != 1) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (session) {
        var success = function(info) {
            display_others_msg("Session closed.");
            session = null;
        };
        var error = function (error) {
            display_others_msg("Session closed failed. " + error);
        };
        session.close(success, error);
    }
    else {
        display_others_msg("No session available.");
    }
}

function stream_add(argv) {
    var callbacks = new Object;
    var options = 0;

    callbacks.onStateChanged = stream_on_state_changed;
    callbacks.onStreamData = stream_on_data;

    if (!session) {
        display_others_msg("No session available.");
        return;
    }

    if (argv.length < 1) {
        display_others_msg("Invalid command syntax.");
        return;
    }
    else if (argv.length > 1) {
        for (var i = 1; i < argv.length; i++) {
            if (argv[i] == "reliable") {
                options |= carrierManager.StreamMode.RELIABLE;
            }
            else if (argv[i] == "plain") {
                options |= carrierManager.StreamMode.PLAIN;
            }
            else if (argv[i] == "multiplexing") {
                options |= carrierManager.StreamMode.MULTIPLEXING;
            }
            else if (argv[i] == "portforwarding") {
                options |= carrierManager.StreamMode.PORT_FORWARDING;
            } else {
                display_others_msg("Invalid command syntax.");
                return;
            }
        }
    }

    if ((options & carrierManager.StreamMode.MULTIPLEXING) || (options & carrierManager.StreamMode.PORT_FORWARDING)) {
        callbacks.onChannelOpen = on_channel_open;
        callbacks.onChannelOpened = on_channel_opened;
        callbacks.onChannelData = on_channel_data;
        callbacks.onChannelPending = on_channel_pending;
        callbacks.onChannelResume = on_channel_resume;
        callbacks.onChannelClose = on_channel_close;
    }

    var success = function(_stream) {
        stream = _stream;
        session_ctx.unchanged_streams++;
        stream.channel = [];
        display_others_msg("Add stream successfully and stream id " + stream.id);
    };
    var error = function (error) {
        display_others_msg("Add stream failed. " + error);
    };
    session.addStream(carrierManager.StreamType.TEXT, options, callbacks, success, error);
}

function stream_remove(argv) {
    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Remove stream " + stream.id + " success.");
    };
    var error = function (error) {
        display_others_msg("Remove stream " + stream.id + " failed. " + error);
    };
    session.removeStream(stream, success, error);
}

function session_peer(argv) {
    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }

    display_others_msg("Get peer: " + session.peer);
}

function session_request(argv) {
    if (argv.length != 1) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("session request successfully.");
    };
    var error = function (error) {
        display_others_msg("session request failed. " + error);
    };
    session.request(session_request_complete_callback, success, error);
}

function session_reply_request(argv) {
    var ret;
    if ((argv.length != 2) && (argv.length != 3)) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }

    if ((argv[1] == "ok") && (argv.length == 2)) {
        var success = function(info) {
            display_others_msg("response invite successuflly.");

            if (session_ctx.unchanged_streams > 0) {
                session_ctx.need_start = true;
            }
            else {
                ret = session.start(session_ctx.remote_sdp);
                display_others_msg("Session start " + (ret ? "success." : "failed."));
            }
        };
        var error = function (error) {
            display_others_msg("response invite failed. " + error);
        };
        session.replyRequest(0, null, success, error);
    }
    else if ((argv[1] == "refuse") && (argv.length == 3)) {
        var success = function(info) {
            display_others_msg("response invite successuflly.");
        };
        var error = function (error) {
            display_others_msg("response invite failed. " + error);
        };
        session.replyRequest(1, argv[2], success, error);
    }
    else {
        display_others_msg("Unknown sub command.");
        return;
    }
}

function stream_write(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }
    var buf = window.btoa(argv[2]);

    var success = function(info) {
        display_others_msg("write data successfully.written: " + info.written);
    };
    var error = function (error) {
        display_others_msg("write data failed. " + error);
    };
    stream.write(buf, success, error);
}

function stream_get_info(argv) {

    var topology_name = [
        "LAN",
        "P2P",
        "RELAYED"
    ];

    var addr_type = [
        "HOST   ",
        "SREFLEX",
        "PREFLEX",
        "RELAY  "
    ];

    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        var msg = "Stream transport information:"
            + "<br/>    Network: " + topology_name[info.topology]
            + "<br/>      Local: " + addr_type[info.localAddr.type] + " " + info.localAddr.address + ":" + info.localAddr.port;
        if (info.localAddr.relatedAddress)
            msg += "<br/>       related " + info.localAddr.relatedAddress + ":" + info.localAddr.relatedPort;

        msg += "<br/>     Remote: " + addr_type[info.remoteAddr.type] + " " + info.remoteAddr.address + ":" + info.remoteAddr.port;
        if (info.remoteAddr.relatedAddress)
            msg += "<br/>       related " + info.remoteAddr.relatedAddress + ":" + info.remoteAddr.relatedPort;
        display_others_msg(msg);
    };

    var error = function (error) {
        display_others_msg("get state failed. " + error);
    };

    stream.getTransportInfo(success, error);
}

function stream_get_type(argv) {
    var info;

    var type_name = [
        "audio",
        "video",
        "text",
        "application",
        "message"
    ];

    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }
    if (!stream.type) {
        display_others_msg("get type failed.");
        return;
    }

    display_others_msg("Stream type: " + type_name[stream.type]);
}

function stream_get_state(argv) {
    var state_name = [
        "raw",
        "initialized",
        "transport_ready",
        "connecting",
        "connected",
        "deactivated",
        "closed",
        "failed"
    ];

    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Stream state: " + state_name[info.state]);
    };
    var error = function (error) {
        display_others_msg("get state failed. " + error);
    };
    stream.getState(success, error);
}

function stream_open_channel(argv) {
    if (argv.length < 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }
    var cookie = null;
    if (argv.length == 3) {
        cookie = argv[2];
    }
    var success = function(info) {
        display_others_msg("Channel " + info.channel + " created.");
    };
    var error = function (error) {
        display_others_msg("Create channel failed. " + error);
    };
    stream.openChannel(cookie, success, error);
}

function stream_close_channel(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Channel " + argv[2] + " closed.");
    };
    var error = function (error) {
        display_others_msg("Close channel failed. " + error);
    };
    stream.closeChannel(parseInt(argv[2]), success, error);
}

function stream_write_channel(argv) {
    if (argv.length != 4) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }
    var buf = window.btoa(argv[3]);

    var success = function(info) {
        display_others_msg("Channel " + argv[2] + " write successfully.");
    };
    var error = function (error) {
        display_others_msg("Write channel failed. " + error);
    };
    stream.writeChannel(parseInt(argv[2]), buf, success, error);
}

function stream_pend_channel(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Channel " + argv[2] + " input is pending.", );
    };
    var error = function (error) {
        display_others_msg("Pend channel failed. " + error);
    };
    stream.pendChannel(parseInt(argv[2]), success, error);
}

function stream_resume_channel(argv) {
    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Channel " + argv[2] + " input is resumed.");
    };
    var error = function (error) {
        display_others_msg("Resume channel(input) failed. " + error);
    };
    stream.resumeChannel(parseInt(argv[2]), success, error);
}

function session_add_service(argv) {
    var protocol;

    if (argv.length != 5) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (argv[2] == "tcp")
        protocol = carrierManager.PortForwardingProtocol.TCP;
    else {
        display_others_msg("Unknown protocol " + argv[2]);
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Add service " + argv[1] + " success.");
    };
    var error = function (error) {
        display_others_msg("Add service " + argv[1] + " failed. " + error);
    };
    session.addService(argv[1], protocol, argv[3], argv[4], success, error);
}

function session_remove_service(argv) {
    if (argv.length != 2) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Remove service " + argv[1] + " success.");
    };
    var error = function (error) {
        display_others_msg("Remove service " + argv[1] + " failed. " + error);
    };
    session.removeService(argv[1], success, error);
}

function portforwarding_open(argv) {
    var protocol;
    var pfid;

    if (argv.length != 6) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    if (argv[3] == "tcp")
        protocol = carrierManager.PortForwardingProtocol.TCP;
    else {
        display_others_msg("Unknown protocol: " + argv[3]);
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Open portforwarding to service " + argv[2] + " <<== " + argv[4] + ":" + argv[5] + " success, id is " + info.pfId);
    };
    var error = function (error) {
        display_others_msg("Open portforwarding to service " + argv[2] + " <<== " + argv[4] + ":" + argv[5] + " failed. " + error);
    };
    stream.openPortForwarding(argv[2], protocol, argv[4], argv[5], success, error);
}

function portforwarding_close(argv) {
    var pfid;

    if (argv.length != 3) {
        display_others_msg("Invalid command syntax.");
        return;
    }

    var pfid = parseInt(argv[2]);
    if (pfid <= 0) {
        display_others_msg("Invalid portforwarding id: " + argv[2]);
        return;
    }

    if (!session) {
        display_others_msg("session is invalid.");
        return;
    }
    var stream = session.streams[parseInt(argv[1])];
    if (!stream) {
        display_others_msg("stream " + argv[1] + " is invalid.");
        return;
    }

    var success = function(info) {
        display_others_msg("Portforwarding " + pfid + " closed success.");
    };
    var error = function (error) {
        display_others_msg("Portforwarding " + pfid + " closed failed. " + error);
    };
    stream.closePortForwarding(pfid, success, error);
}

//Callback Functions
function idle_callback(event) {

    // var i = 1;
    // display_others_msg("call idle_callback.");
}

function ready_callback(event) {
    display_others_msg("Carrier is ready!");
}

function self_info_callback(event) {
    var msg = string_user_info(event.userInfo);
    display_others_msg(msg);
}

function connection_callback(event) {
    switch (event.status) {
        case carrierManager.ConnectionStatus.CONNECTED:
            display_others_msg("Connected to carrier network.");
            break;

        case carrierManager.ConnectionStatus.DISCONNECTED:
            display_others_msg("Disconnect from carrier network.");
            break;

        default:
            display_others_msg("Error!!! Got unknown connection status :" + status);
    }
    //rl.prompt();
}

var count = 0;
var first_friends_item = 1;

function fmt_str_blank(string, length) {
    for (var i = string.length; i < length; i++) {
        string += " "
    }
    return string;
}

function display_friends(ret) {
    var friends = ret.friends;
    if (typeof friends == "string") {
        friends = JSON.parse(friends);
    }

    var msg = "Friends: <br/>";
    var i = 0;
    for (var id in friends) {
        msg += "No." + i++ + "<br/> -------------------- <br/>";
        msg += string_friend_info(friends[id]);
        msg += "<br/><br/>";
    }
    msg += "********************<br/>Total " + i + " friends.";
    display_others_msg(msg);
}

function friends_list_callback(event) {
    if (event.friends.length) {
        display_friends(event.friends);
    }
}

function friend_connection_callback(event) {
    switch (event.status) {
        case carrierManager.ConnectionStatus.CONNECTED:
            display_others_msg("Friend[" + event.friendId + "] connection changed to be online");
            break;

        case carrierManager.ConnectionStatus.DISCONNECTED:
            display_others_msg("Friend[" + event.friendId + "] connection changed to be offline.");
            break;

        default:
            display_others_msg("Error!!! Got unknown connection status:" + event.status);
    }
}

function friend_info_callback(event) {
    var msg = "Friend information changed: <br/>" + string_friend_info(event.friendInfo);
    display_others_msg(msg);
}

function friend_presence_callback(event) {
    if (event.presence >= carrierManager.PresenceStatus.NONE &&
        event.presence <= carrierManager.PresenceStatus.BUSY) {
        display_others_msg("Friend[" + event.friendId + "] change presence to " + presence_name[event.presence]);
    }
    else {
        display_others_msg("Error!!! Got unknown presence status: " + event.presence);
    }
}

function friend_request_callback(event) {
    var msg = "Friend request from user[" + event.userId + "] with HELLO: " + event.hello + ".<br/>"
        + "Reply use following commands:<br/>"
        + "  faccept " + event.userId;
    display_others_msg(msg);
}

function friend_added_callback(event) {
    var msg = "New friend added. The friend information: <br/>" + string_friend_info(event.friendInfo);
    display_others_msg(msg);
}

function friend_removed_callback(event) {
    display_others_msg("Friend " + event.friendId + " removed!");
}

function message_callback(event) {
    display_others_msg("Message from friend[" + event.from + "]: " + event.message);
}

function invite_request_callback(event) {
    var msg = "Invite request from[" + event.from + "] with data: " + event.data
        + "<br/>Reply use following commands:"
        + "<br/>  ireply " + event.from + " confirm [message]"
        + "<br/>  ireply " + event.from + " refuse [reason]";
    display_others_msg(msg);
}

function invite_response_callback(event) {
    var msg = "Got invite response from " + event.from + ".<br/>";
    if (event.status == 0) {
        msg += "message within response: " + event.data;
    }
    else {
        msg += "refused: " + event.reason;
    }
    display_others_msg(msg);
}

function manager_connect_request_callback(event){
    var msg = "Got file transfer manager connect request callback response .<br/>"
        + "if you want connect file transfer .<br/>"
        + "Please enter the following command .<br/> "
        + "ftnew " + event.from +" "+event.info.fileId+ " "+event.info.filename+" "+event.info.size ;
    display_others_msg(msg);
}

function group_invite_callback(event){
    var msg = "Got group invite callback response " + event.from + "; "+event.cookieCode
            + ".<br/>if you want Accept the invitation,"
            + "<br/>input sub command:"
            +"<br/>groupj "+ event.from +" "+event.cookieCode;
    display_others_msg(msg);
}

function group_connected_callback(event) {
    var msg = "Got group connected callback response <br/>";
    display_others_msg(msg);
}

function group_msg_callback(event) {
    var msg = "receive group msg . <br/>"
        + "<br/>from:"+event.from
        + "<br/>msg:"+event.message;
    display_others_msg(msg);
}

function group_title_callback(event) {
    var msg = "Got group title change callback response .<br/>"
        + "<br/>from:"+event.from
        + "<br/>new title:"+event.title;
    display_others_msg(msg);
}

function group_peer_name_callback(event) {
    var msg = "Got group peer name change callback response .<br/>"
        + "<br/>peerId:"+event.peerId
        + "<br/>peerName:"+event.peerName;
    display_others_msg(msg);
}

function group_peer_list_change_callback(event) {
    var msg = "Got group peer list changed callback response .<br/>";
    display_others_msg(msg);
}

function ft_state_changed_callback(event) {
    var msg = "Got file transfer state changed callback response .<br/>"
        +"state = "+event.state;
    display_others_msg(msg);
}

function ft_file_request_callback(event) {
    var msg = "Got file transfer file request callback response .<br/>"
        +"fileId = "+event.fileId+"<br/>"
        +"filename = "+event.filename+"<br/>"
        +"size = "+event.size+"<br/>";
    display_others_msg(msg);
}

function ft_pull_request_callback(event) {
    var msg = "Got file transfer pull request callback response .<br/>"
        +"fileId = "+event.fileId+"<br/>"
        +"offset = "+event.offset;
    display_others_msg(msg);
}

function ft_on_data_callback(event) {
    var msg = "Got file transfer on data callback response .<br/>"
        +"fileId = "+event.fileId+"<br/>"
        +"data = "+event.data+"<br/>";
    display_others_msg(msg);
}

function ft_on_data_finished_callback(event) {
    var msg = "Got file transfer on data finished callback response .<br/>"
        +"fileId = "+event.fileId;
    display_others_msg(msg);
}

function ft_on_pending_callback(event) {
    var msg = "Got file transfer on pending callback response .<br/>"
        +"fileId = "+event.fileId;
    display_others_msg(msg);
}


function ft_on_resume_callback(event) {
    var msg = "Got file transfer on resume callback response .<br/>"
        +"fileId = "+event.fileId;
    display_others_msg(msg);
}

function ft_on_cancel_callback(event) {
    var msg = "Got file transfer on cancel callback response .<br/>"
        +"fileId = "+event.fileId+"<br/>"
        +"status = "+event.status+"<br/>"
        +"reason = "+event.reason ;
    display_others_msg(msg);
}

var callbacks = {
    onIdle: idle_callback,
    onConnection: connection_callback,
    onReady: ready_callback,
    onSelfInfoChanged: self_info_callback,
    onFriends: friends_list_callback,
    onFriendConnection: friend_connection_callback,
    onFriendInfoChanged: friend_info_callback,
    onFriendPresence: friend_presence_callback,
    onFriendRequest: friend_request_callback,
    onFriendAdded: friend_added_callback,
    onFriendRemoved: friend_removed_callback,
    onFriendMessage: message_callback,
    onFriendInviteRequest: invite_request_callback,
    onSessionRequest: session_request_callback,
    onGroupInvite:group_invite_callback,
    onConnectRequest:manager_connect_request_callback,
}

var groupCallbacks = {
    onGroupConnected:group_connected_callback,
    onGroupMessage:group_msg_callback,
    onGroupTitle:group_title_callback,
    onPeerName:group_peer_name_callback,
    onPeerListChanged:group_peer_list_change_callback,
}

var fileTransferCallbacks = {
    onStateChanged:ft_state_changed_callback,
    onFileRequest:ft_file_request_callback,
    onPullRequest:ft_pull_request_callback,
    onData:ft_on_data_callback,
    onDataFinished:ft_on_data_finished_callback,
    onPending:ft_on_pending_callback,
    onResume:ft_on_resume_callback,
    onCancel:ft_on_cancel_callback,
}

function onLauncher() {
    appManager.launcher();
}

function onClose() {
    if (carrier != null) {
        carrier.destroy();
    }

    appManager.close();
}

var carrier = null;

var app = {
    // Application Constructor
    initialize: function () {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    onDeviceReady: function () {
        var success = function (ret) {
            carrier = ret;
            carrier.start(50, null, null);
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
        }
        carrierManager.createObject(callbacks, opts, success, null);
    },
};

app.initialize();

function test(argv) {;
//    do_command("snew userid");
    do_command("sadd reliable multiplexing portforwarding");
//    do_command("swrite 1 datagt");
//    var success = function() {
//        alert("ok");
//    };
//    carrierManager.test(success, null, window.btoa("hello"));
}

// $(document).ready(function () {
//     do_command("help");
// });