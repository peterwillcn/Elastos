/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

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

    { cmd: "msg", fn: send_message, help: "msg [No.] message" },
    { cmd: "info", fn: info, help: "info [No.]" },
    { cmd: "infos", fn: infos, help: "infos" },
    { cmd: "close", fn: close, help: "close [No.]" },
    { cmd: "list", fn: app_list, help: "list" },
    { cmd: "running", fn: running_list, help: "running" },
    { cmd: "last", fn: last_list, help: "last" },
    { cmd: "pluginauth", fn: plugin_auth, help: "pluginauth [No.] pluginanme authority" },
    { cmd: "urlauth", fn: url_auth, help: "urlauth [No.] url authority" },
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
function getId(No) {
    var demo = document.getElementById("demo" + No);
    if (demo.status == INSTALLED) {
        return demo.appInfo.id;
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
    if (argv.length == 2) {
        var success = function (ret) {
            display_others_msg(string_app_info(ret));
        };
        var error = function (error) {
            display_others_msg("getAppInfo fail!");
        };
        appManager.getAppInfo(getId(argv[1]), success, error);
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}

function infos(argv) {
    if (argv.length == 1) {
        var success = function (infos) {
            var str = ""
            for (var id in infos) {
                str += "info[" + id + "]:<br/>"
                str += string_app_info(infos[id]);
            }
            display_others_msg(str);
        };
        var error = function (error) {
            display_others_msg("getAppInfos fail!");
        };
        appManager.getAppInfos(success, error);
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}

function close(argv) {
    if (argv.length == 2) {
        var success = function (ret) {
            display_others_msg("close ok!");
        };
        var error = function (error) {
            display_others_msg("close fail!");
        };
        appManager.close(getId(argv[1]), success, error);
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}

function running_list() {
    var success = function (ret) {
        display_others_msg(ret.toString());
    };
    var error = function (error) {
        display_others_msg("getRunningList fail!");
    };

    appManager.getRunningList(success, error);
}

function app_list() {
    var success = function (ret) {
        display_others_msg(ret.toString());
    };
    var error = function (error) {
        display_others_msg("getAppList fail!");
    };

    appManager.getAppList(success, error);
}

function last_list() {
    var success = function (ret) {
        display_others_msg(ret.toString());
    };
    var error = function (error) {
        display_others_msg("getLastList fail!");
    };

    appManager.getLastList(success, error);
}

function plugin_auth(argv) {
    var success = function (ret) {
        display_others_msg(ret.toString());
    };
    var error = function (error) {
        display_others_msg("setPluginAuthority fail!");
    };

    appManager.setPluginAuthority(getId(argv[1]), argv[2], argv[3], success, error);
}

function url_auth(argv) {
    var success = function (ret) {
        display_others_msg(ret.toString());
    };
    var error = function (error) {
        display_others_msg("setUrlAuthority fail!");
    };

    appManager.setUrlAuthority(getId(argv[1]), argv[2], argv[3], success, error);
}

function send_message(argv) {
    if (argv.length == 3) {
        var success = function (ret) {
            display_others_msg("send_message ok!");
        };
        var error = function (error) {
            display_others_msg("send_message fail!");
        };
        appManager.sendMessage(getId(argv[1]), 1, argv[2], success, error);
    }
    else {
        display_others_msg("Invalid command syntax.");
    }
}

function exit(args) {
}

function clickButton() {
    alert("2");
}

function install() {

}

var NOINSTALL = 0;
var INSTALLED = 1;

function setNoInstallItem(No) {
    var demo = document.getElementById("demo" + No);
    if (demo && demo != null) {
        demo.src = "img/install.png";
        demo.appInfo = null;
        demo.status = NOINSTALL;
    }
    var udemo = document.getElementById("udemo" + No);
    if (udemo && udemo != null) {
        udemo.src = "img/uninstall_disable.png";
        udemo.appInfo = null;
        udemo.status = NOINSTALL;
    }

    var name = document.getElementById("name" + No);
    if (name && name != null) {
        name.innerHTML = "Demo" + No;
    }
}

function setRetNoInstallItem(id) {
   for (var i = 1; i < 5; i++ ) {
        var demo = document.getElementById("demo" + i);
        if (demo.status == INSTALLED && demo.appInfo.id == id) {
            setNoInstallItem(i);
            break;
        }
   }
}

function setNoInstallItems() {
    for (var i = 1; i < 5; i++ ) {
        setNoInstallItem(i);
    }
 }

function setInstalledItem(appInfo) {
    for (var i = 1; i < 5; i++ ) {
        var demo = document.getElementById("demo" + i);
        if (demo.status != INSTALLED) {
            demo.src = appInfo.icons[0].src;
            demo.appInfo = appInfo;
            demo.status = INSTALLED;

            var udemo = document.getElementById("udemo" + i);
            udemo.src = "img/uninstall_enable.png";
            udemo.appInfo = appInfo;
            udemo.status = INSTALLED;

            var name = document.getElementById("name" + i);
            name.innerHTML = appInfo.name;
            break;
        }
    }
}

function refreshItems(appInfos) {
    setNoInstallItems();
    for (id in appInfos) {
         setInstalledItem(appInfos[id]);
     }
}

function touchDemo(No) {
    var demo = document.getElementById("demo" + No);
    if (demo.status == INSTALLED) {
        appManager.start(demo.appInfo.id);
    }
    else {
        appManager.install("assets://www/install-files/demo" + No + ".epk", setInstalledItem);
    }
}

function touchUDemo(No) {
    var udemo = document.getElementById("udemo" + No);
    if (udemo.status == INSTALLED) {
        appManager.unInstall(udemo.appInfo.id, setRetNoInstallItem);
    }
    else {

    }
}

function init() {

    function onReceive(ret) {
        display_others_msg("receive message:" + ret.message + ". from: " + ret.from);
    }

    appManager.setListener(onReceive);

    setNoInstallItems();
    appManager.getAppInfos(refreshItems);

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


var app = {

    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        this.receivedEvent('deviceready');
        init();
        window.location.href ="#page2"
    },

    // Update DOM on a Received Event
    receivedEvent: function(id) {
        var parentElement = document.getElementById(id);
        var listeningElement = parentElement.querySelector('.listening');
        var receivedElement = parentElement.querySelector('.received');

        listeningElement.setAttribute('style', 'display:none;');
        receivedElement.setAttribute('style', 'display:block;');

        console.log('Received Event: ' + id);
    }
};

app.initialize();
