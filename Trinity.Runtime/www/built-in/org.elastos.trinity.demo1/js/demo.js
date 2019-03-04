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

var commands = [
    { cmd: "help", fn: help, help: "help [cmd]" },

    { cmd: "info", fn: info, help: "info" },

    { cmd: "msg", fn: send_message, help: "msg [No.] message" },
    { cmd: "check", fn: check, help: "check url" },
//    { cmd: "test", fn:test,          help: "test" },

//    { cmd: "exit", fn: exit, help: "exit" }
]

function do_command(input) {
    input = input.toLowerCase()
    var args = input.trim().match(/[^\s"]+|"([^"]*)"/g);
    if (!args || args[0] == "") {
        return;
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
function string_icons_info(icons) {
    var str = ""
    for (var i = 0; i < icons.length; i++) {
        str += "<br/>              icon[" + i + "]:" +
        "<br/>                  src:" + icons[i].src +
        "<br/>                sizes:" + icons[i].sizes  +
        "<br/>                 type:" + icons[i].type;
    }
    return str;
}

function string_plugins_info(plugins) {
    var str = ""
    for (var i = 0; i < plugins.length; i++) {
        str += "<br/>              plugin[" + i + "]:" +
        "<br/>                  name:" + plugins[i].plugin +
        "<br/>             authority:" + plugins[i].authority ;
    }
    return str;
}

function string_urls_info(urls) {
    var str = ""
    for (var i = 0; i < urls.length; i++) {
        str += "<br/>              url[" + i + "]:" +
        "<br/>                  name:" + urls[i].url +
        "<br/>             authority:" + urls[i].authority ;
    }
    return str;
}

function string_app_info(info) {
    var msg = "              id:" + info.id +
          "<br/>        version:" + info.version +
          "<br/>           name:" + info.name +
          "<br/>    description:" + info.description +
          "<br/>       startUrl:" + info.startUrl +
          "<br/>          icons:" + string_icons_info(info.icons) +
          "<br/>     authorName:" + info.authorName +
          "<br/>    authorEmail:" + info.authorEmail +
          "<br/>  defaultLocale:" + info.defaultLocale +
          "<br/>        plugins:" + string_plugins_info(info.plugins) +
          "<br/>           urls:" + string_urls_info(info.urls) +
          "<br/>backgroundColor:" + info.backgroundColor +
          "<br/>   themeDisplay:" + info.themeDisplay +
          "<br/>     themeColor:" + info.themeColor +
          "<br/>  themeFontName:" + info.themeFontName +
          "<br/> themeFontColor:" + info.themeFontColor +
          "<br/>    installTime:" + info.installTime +
          "<br/>        builtIn:" + info.builtIn +
          "<br/>        appPath:" + info.appPath +
          "<br/>       dataPath:" + info.dataPath;
    return msg;
}

function info(argv) {
    var success = function (ret) {
        display_others_msg(string_app_info(ret));
    };
    var error = function (error) {
        display_others_msg("getAppInfo fail!");
    };
    appService.getAppInfo(success, error);
}

function check(args) {
    if (args.length == 2) {
        var success = function (ret) {
            display_others_msg(ret);
        };
        var error = function (error) {
            display_others_msg(error);
        };
        pluginDemo.check(args[1], success, error);
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}


function getId(No) {
    var ret;
    if (parseInt(No) == 0) {
        return "launcher"
    }
    else {
        return "org.elastos.trinity.demo" + No;
    }
}

function send_message(argv) {
    if (argv.length == 3) {
        var success = function (ret) {
            display_others_msg("send_message ok!");
        };
        var error = function (error) {
            display_others_msg("send_message fail!");
        };
        appService.sendMessage(getId(argv[1]), 1, argv[2], success, error);
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}


function onLauncher() {
    appService.launcher();
}

function onClose() {
    appService.close();
}

function onReceive(ret) {
    display_others_msg("receive message:" + ret.message + ". from: " + ret.from);
}

var app = {
    // Application Constructor
    initialize: function () {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    onDeviceReady: function () {
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
        appService.setListener(onReceive);
    },
};

app.initialize();

function test(argv) {
    window.location.href='index.html#page2';
}


