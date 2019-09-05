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

var client_commands = [
    { name: "onedrive", fn: create_onedrive_client  },
    { name: "ipfs",     fn: create_ipfs_client      }
]

function do_client_command(input) {
    var args = input.trim().match(/[^\s"]+|"([^"]*)"/g);
    if (!args || args[0] == "") {
        return;
    }

    args[0] = args[0].toLowerCase()

    for (var i = 0; i < client_commands.length; i++) {
        if (client_commands[i].name == args[0]) {
            client_commands[i].fn();
            return;
        }
    }
    display_others_msg("Unknown client name:" + args[0]);
}

function create_onedrive_client() {
    $('input').unbind('keypress')

    var success = function (ret) {
        do_command("version");
        do_command("help");

        client  = ret;
        display_others_msg("created onedrive client successfully");

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

    hivePlugin.createClient(success, null, onedrive_opts);
}

function create_ipfs_client() {
    $('input').unbind('keypress')

    var success = function (ret) {
        do_command("version");
        do_command("help");

        client  = ret;
        display_others_msg("created ipfs client successfully");

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

    hivePlugin.createClient(success, null, ipfs_opts);
}

var commands = [
// plugin commands
    { cmd: "help",      fn: help,                   help: "help [cmd]"  },
    { cmd: "version",   fn: get_version,            help: "version"     },

// client commands
    { cmd: "login",     fn: get_login,              help: "login"       },
    { cmd: "logout",    fn: get_logout,             help: "logout"      },
    { cmd: "clastinfo", fn: client_last_info,       help: "clastinfo"   },
    { cmd: "cinfo",     fn: client_info,            help: "cinfo"       },
    { cmd: "drive",     fn: get_drive,              help: "drive"       },

// drive commands
    { cmd: "drvlastinfo",   fn: drive_last_info,    help: "drvlastinfo" },
    { cmd: "drvinfo",   fn: drive_info,             help: "drvinfo"     },
    { cmd: "rootdir",   fn: rootdir,                help: "rootdir"     },
    { cmd: "drvcreatedir",   fn: drive_create_dir,   help: "drvcreatedir path"  },
    { cmd: "drvdir",    fn: drive_get_dir,          help: "drvdir path" },
    { cmd: "drvcreatefile",  fn: drive_create_file,  help: "drvcreatefile path" },
    { cmd: "drvfile",   fn: drive_get_file,         help: "drvfile path"},
    { cmd: "iteminfo",  fn: drive_get_iteminfo,     help: "iteminfo path"       },

// directory commands:
    { cmd: "dlastinfo", fn: get_dir_last_info,      help: "dlastinfo"   },
    { cmd: "dinfo",     fn: get_dir_info,           help: "dinfo"       },
    { cmd: "dcreatedir", fn: dir_create_dir,         help: "dcreatedir name"    },
    { cmd: "ddir",      fn: dir_get_dir,            help: "ddir name"   },
    { cmd: "dcreatefile",    fn: dir_create_file,    help: "dcreatefile name"   },
    { cmd: "dfile",     fn: dir_get_file,           help: "dfile name"  },
    { cmd: "list",      fn: dir_list,               help: "list"        },
    { cmd: "dmoveto",   fn: dir_moveto,             help: "dmoveto path"},
    { cmd: "dcopyto",   fn: dir_copyto,             help: "dcopyto path"},
    { cmd: "drm",       fn: dir_deleteitem,         help: "drm"         },

// file commands
    { cmd: "flastinfo", fn: get_file_last_info,     help: "flastinfo"   },
    { cmd: "finfo",     fn: get_file_info,          help: "finfo"       },
    { cmd: "fmoveto",   fn: file_moveto,            help: "fmoveto path"},
    { cmd: "fcopyto",   fn: file_copyto,            help: "fcopyto path"},
    { cmd: "fdel",      fn: file_deleteitem,        help: "fdel"        },
    { cmd: "read",      fn: file_read,              help: "read length" },
    { cmd: "write",     fn: file_write,             help: "write data"  },
    { cmd: "commit",    fn: file_commit,            help: "command"     },
    { cmd: "discard",   fn: file_discard,           help: "discard"     },

    { cmd: "exit",      fn: exit,                   help: "exit"        }
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

function exit(args) {
    appService.close();
}

function get_version(args) {
    hivePlugin.getVersion(
        function (version) {
            display_others_msg(version);
        },
        function (error) {
            display_others_msg("Get version error! " + error);
        }
    );
}

function get_login(args) {
    client.login(
        function (ret) {
            display_others_msg("Client logined successfuly");
        },
        function (error) {
            display_others_msg("Get login error! " + error);
        },
        function (url) {
            cordova.InAppBrowser.open(url, "_system", "location=yes");
        }
    );
}

function get_logout(args) {
    client.logout(
        function (ret) {
            display_others_msg("Client logged out now");
        },
        function (error) {
            display_others_msg("Get logout error! " + error);
        }
    );
}

function client_last_info(args) {
    client.getLastInfo(
        function (info) {
            var msg = "Client last cached info:"
                    + "<br/>       UserId:" + info.UserId
                    + "<br/>  DisplayName:" + info.DisplayName;
            display_others_msg(msg);
        },
        function (error) {
            display_others_msg("Get cached client info error! " + error);
        }
    );
}

function client_info(args) {
    client.getInfo().then(
        function (info) {
            var msg = "Client last cached info:"
                    + "<br/>       UserId:" + info.UserId
                    + "<br/>  DisplayName:" + info.DisplayName;
            display_others_msg(msg);
        }).catch(
        function (error) {
            display_others_msg("Get remote client info error! " + error);
        }
    );
}

function get_drive(args) {
    client.getDefDrive().then(
        function (ret) {
            drive = ret;
            display_others_msg("Get drive object in success.");
        }).catch(
        function (error) {
            display_others_msg("Get drive error! " + error);
        });
}

function drive_last_info(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please get drive object first.");
        return;
    }
    drive.getLastInfo(
        function (info) {
            var msg = "Drive last cached info:"
                    + "<br/>       DriveId:" + info.DriveId;
            display_others_msg(msg);
        },
        function (error) {
            display_others_msg("Get drive cached info error! " + error);
        }
    );
}

function drive_info(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please get drive object first.");
        return;
    }
    drive.getInfo().then(
        function (info) {
            var msg = "Drive last cached info:"
                    + "<br/>       DriveId:" + info.DriveId;
            display_others_msg(msg);
        }).catch(
        function (error) {
            display_others_msg("Get drive updated info error! " + error);
        });
}

function rootdir(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please get drive object first.");
        return;
    }
    drive.rootDirctory().then(
        function (dir) {
            directory = dir;
            display_others_msg("Get root directory in success");
        }).catch(
        function (error) {
            display_others_msg("Get root directory error! "  + error);
        });
}

function drive_create_dir(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please get drive object first.");
        return;
    }
    drive.createDirectory(args[1]).then(
        function (dir) {
            directory = dir;
            display_others_msg("Create a directory (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Create a directory error! "  + error);
        });
}

function drive_get_dir(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please get drive object first.");
        return;
    }
    drive.getDirectory(args[1]).then(
        function (dir) {
            directory = dir;
            display_others_msg("Get a directory(" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Get a directory error! "  + error);
        });
}

function drive_create_file(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please get drive object first.");
        return;
    }
    drive.createFile(args[1]).then(
        function (ret) {
            file = ret;
            display_others_msg("Create a file (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Create a File error! "  + error);
        });
}

function drive_get_file(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please get drive object first.");
        return;
    }
    drive.getFile(args[1]).then(
        function (ret) {
            file = ret;
            display_others_msg("Get a file (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Get a file error! "  + error);
        });
}

function drive_get_iteminfo(args) {
    if (drive == null) {
        display_others_msg("Error: null drive object."
                + "</br>  Please create directory object first.");
        return;
    }
    drive.getItemInfo(args[1]).then(
        function (info) {
            display_others_msg("Get iteminfo (" + args[1] + ") in success"
                    + "<br/>  Name:" + info.Name
                    + "<br/>  Type:" + info.Type
                    + "<br/>  Size:" + info.Size);
        }).catch(
        function (error) {
            display_others_msg("Get iteminfo error! "  + error);
        });
}

function get_dir_last_info(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.getLastInfo(
        function (info) {
            display_others_msg("Get dir's Last info successfuly"
                   + "<br/>        Name:" + info.Name
                   + "<br/>  ChildCount:" + info.ChildCount);
        },
        function (error) {
            display_others_msg("get_dir_last_info error! " + error);
        });
}

function get_dir_info(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.getInfo().then(
        function (info) {
            display_others_msg("Get directory info successfuly"
                    + "<br/>        Name:" + info.Name
                    + "<br/>  ChildCount:" + info.ChildCount);
        }).catch(
        function (error) {
            display_others_msg("get directory info error! " + error);
        });
}

function dir_create_dir(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.createDirectory(args[1]).then(
        function (ret) {
            directory = ret;
            display_others_msg("Create a directory (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Create a directory error! "  + error);
        });
}

function dir_get_dir(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.getDirectory(args[1]).then(
        function (ret) {
            directory = ret;
            display_others_msg("Get a directory (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Get a directory error! "  + error);
        });
}

function dir_create_file(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.createFile(args[1]).then(
        function (ret) {
            file = ret;
            display_others_msg("Create a File (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Create a File error! "  + error);
        });
}

function dir_get_file(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.getFile(args[1]).then(
        function (ret) {
            file = ret;
            display_others_msg("Get a file (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Get a file error! "  + error);
        });
}

function dir_list(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.getChildren().then(
        function (ret) {
            var msg = "Get children list in success. Count: " + ret.length;
            for (i = 0; i < ret.length; i++)
                msg += "</br> " + ret[i].Name;

            display_others_msg(msg);
        }).catch(
        function (error) {
            display_others_msg("Get children list error! "  + error);
        });
}

function dir_moveto(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.moveTo(args[1]).then(
        function (ret) {
            display_others_msg("Move a directory (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Move a directory error! "  + error);
        });
}

function dir_copyto(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.copyTo(args[1]).then(
        function (ret) {
            display_others_msg("Copy a directory (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Copy a directory error! "  + error);
        });
}

function dir_deleteitem(args) {
    if (directory == null) {
        display_others_msg("Error: null directory object."
                + "</br>  Please create directory object first.");
        return;
    }
    directory.deleteItem().then(
        function (ret) {
            directory = null;
            display_others_msg("Delete item successfuly");
        }).catch(
        function (error) {
            display_others_msg("Delete item error! "  + error);
        });
}

function get_file_last_info(args) {
    if (file == null) {
        display_others_msg("Error: null file object."
                + "</br>  Please create file object first.");
        return;
    }
    file.getLastInfo(
        function (ret) {
            display_others_msg("Get file Last info successfuly"
                    + "<br/>  Name:" + info.Name
                    + "<br/>  Size:" + info.Size);
        },
        function (error) {
            display_others_msg("get_file_last_info error! " + error);
        });
}

function get_file_info(args) {
    if (file == null) {
        display_others_msg("Error: null file object."
                + "</br>  Please create file object first.");
        return;
    }
    file.getInfo().then(
        function (info) {
            display_others_msg("Get file info successfuly"
                    + "<br/>  Name:" + info.Name
                    + "<br/>  Size:" + info.Size);
        }).catch(
        function (error) {
            display_others_msg("get file info error! " + error);
        });
}

function file_moveto(args) {
    if (file == null) {
        display_others_msg("Error: null file object."
                + "</br>  Please create file object first.");
        return;
    }
    file.moveTo(args[1]).then(
        function (ret) {
            display_others_msg("Move a file (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Move a file error! "  + error);
        });
}

function file_copyto(args) {
    if (file == null) {
        display_others_msg("Error: null file object."
                + "</br>  Please create file object first.");
        return;
    }

    file.copyTo(args[1]).then(
        function (ret) {
            display_others_msg("Copy a file (" + args[1] + ") in success");
        }).catch(
        function (error) {
            display_others_msg("Copy a file error! "  + error);
        });
}

function file_deleteitem(args) {
    if (file == null) {
        display_others_msg("Error: null file object."
                + "</br>  Please create file object first.");
        return;
    }

    file.deleteItem().then(
        function (ret) {
            file = null;
            display_others_msg("Delete item successfuly");
        }).catch(
        function (error) {
            display_others_msg("Delete item error! "  + error);
        });
}

function file_read(args) {
    if (file == null) {
        display_others_msg("Error: null file object"
                + "</br> Please create file object first.");
        return;
    }

    file.readData(args[1]).then(
        function(ret) {
            display_others_msg("Read " + args[1] + " data: "
                    + "</br> " + ret.data);
        }).catch(
        function (error) {
            display_others_msg("Read data error!" + error);
        });
}

function file_write(args) {
    if (file == null) {
        display_others_msg("Error: null file object"
                + "</br> Please create file object first.");
        return;
    }

    file.writeData(args[1]).then(
        function(ret) {
            display_others_msg("Write data in success.");
        }).catch(
        function (error) {
            display_others_msg("Write data error!" + error);
        });
}

function file_commit(args) {
    if (file == null) {
        display_others_msg("Error: null file object"
                + "</br> Please create file object first.");
        return;
    }

    file.commit().then(
        function(ret) {
            display_others_msg("Commit data in success.");
        }).catch(
        function (error) {
            display_others_msg("Commit data error!" + error);
        });
}

function file_discard(args) {
    if (file == null) {
        display_others_msg("Error: null file object"
                + "</br> Please create file object first.");
        return;
    }

    file.discard(function() {
        display_others_msg("Discard written data in success.");
    });
}

function onLauncher() {
    appService.launcher();
}

function onClose() {
    appService.close();
}

var onedrive_opts = {
    type: "2",
    client_id: "afd3d647-a8b7-4723-bf9d-1b832f43b881",
    scope: "User.Read Files.ReadWrite.All offline_access",
    redirect_url: "http://localhost:12345"
};

var ipfs_opts = {
    type: "3"
};

var client = null;
var drive  = null;
var directory = null;
var file = null;

var app = {
    // Application Constructor
    initialize: function () {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    onDeviceReady: function () {
        var msg = "Create which client："
                    + "<br/> 1.onedrive"
                    + "<br/> 2.ipfs";
        display_others_msg(msg);

        $("input").focus();
        $("input").bind('keypress', function (event) {
            if (event.keyCode == "13") {
                var content = $('input').val()
                if (content.trim() != "") {
                    display_me_msg($('input').val());
                    do_client_command($('input').val());
                    $('input').val('');
                }
            }
        });
    },
};

app.initialize();
