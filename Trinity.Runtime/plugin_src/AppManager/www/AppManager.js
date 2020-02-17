"use strict";
/*
* Copyright (c) 2018 Elastos Foundation
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
var exec = cordova.exec;
var AppManagerImpl = /** @class */ (function () {
    function AppManagerImpl() {
    }
    AppManagerImpl.prototype.getLocale = function (onSuccess) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info.defaultLang, info.currentLang, info.systemLang);
            }
        }
        ;
        exec(_onSuccess, null, 'AppManager', 'getLocale');
    };
    AppManagerImpl.prototype.setCurrentLocale = function (code, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'setCurrentLocale', [code]);
    };
    AppManagerImpl.prototype.install = function (url, update, onSuccess, onError) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info);
            }
        }
        ;
        exec(_onSuccess, onError, 'AppManager', 'install', [url, update]);
    };
    AppManagerImpl.prototype.unInstall = function (id, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'unInstall', [id]);
    };
    AppManagerImpl.prototype.getInfo = function (onSuccess, onError) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info);
            }
        }
        ;
        exec(_onSuccess, onError, 'AppManager', 'getInfo', []);
    };
    AppManagerImpl.prototype.getAppInfo = function (id, onSuccess, onError) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info);
            }
        }
        ;
        exec(_onSuccess, onError, 'AppManager', 'getAppInfo', [id]);
    };
    AppManagerImpl.prototype.getAppInfos = function (onSuccess) {
        function _onSuccess(info) {
            for (var id in info) {
                jsonInfo(info[id]);
            }
            if (onSuccess) {
                onSuccess(info.infos, info.list);
            }
        }
        ;
        exec(_onSuccess, null, 'AppManager', 'getAppInfos');
    };
    AppManagerImpl.prototype.start = function (id, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'start', [id]);
    };
    AppManagerImpl.prototype.launcher = function (onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'launcher', []);
    };
    AppManagerImpl.prototype.close = function (onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'close', []);
    };
    AppManagerImpl.prototype.closeApp = function (id, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'closeApp', [id]);
    };
    AppManagerImpl.prototype.sendMessage = function (id, type, msg, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'sendMessage', [id, type, msg]);
    };
    AppManagerImpl.prototype.setListener = function (callback) {
        exec(callback, null, 'AppManager', 'setListener');
    };
    AppManagerImpl.prototype.getRunningList = function (onSuccess) {
        exec(onSuccess, null, 'AppManager', 'getRunningList');
    };
    AppManagerImpl.prototype.getAppList = function (onSuccess) {
        exec(onSuccess, null, 'AppManager', 'getAppList');
    };
    AppManagerImpl.prototype.getLastList = function (onSuccess) {
        exec(onSuccess, null, 'AppManager', 'getLastList');
    };
    AppManagerImpl.prototype.setPluginAuthority = function (id, plugin, authority, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'setPluginAuthority', [id, plugin, authority]);
    };
    AppManagerImpl.prototype.setUrlAuthority = function (id, url, authority, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'setUrlAuthority', [id, url, authority]);
    };
    AppManagerImpl.prototype.alertPrompt = function (title, message) {
        exec(null, null, 'AppManager', 'alertPrompt', [title, message]);
    };
    AppManagerImpl.prototype.infoPrompt = function (title, message) {
        exec(null, null, 'AppManager', 'infoPrompt', [title, message]);
    };
    AppManagerImpl.prototype.askPrompt = function (title, message, onOK) {
        exec(onOK, null, 'AppManager', 'askPrompt', [title, message]);
    };
    AppManagerImpl.prototype.sendIntent = function (action, params, options, onSuccess, onError) {
        var str = JSON.stringify(params);
        function _onSuccess(ret) {
            if (typeof (ret.result) == "string") {
                ret.result = JSON.parse(ret.result);
            }
            if (onSuccess) {
                onSuccess(ret);
            }
        }
        ;
        exec(_onSuccess, onError, 'AppManager', 'sendIntent', [action, str, options]);
    };
    AppManagerImpl.prototype.sendUrlIntent = function (url, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'sendUrlIntent', [url]);
    };
    AppManagerImpl.prototype.setIntentListener = function (callback) {
        function _onReceiveIntent(ret) {
            if (typeof (ret.params) == "string") {
                ret.params = JSON.parse(ret.params);
            }
            if (callback) {
                callback(ret);
            }
        }
        exec(_onReceiveIntent, null, 'AppManager', 'setIntentListener');
    };
    AppManagerImpl.prototype.sendIntentResponse = function (action, result, intentId, onSuccess, onError) {
        var str = JSON.stringify(result);
        function _onSuccess(_response) {
            if (onSuccess)
                onSuccess(_response);
        }
        function _onError(_err) {
            if (onError)
                onError(_err);
        }
        exec(_onSuccess, _onError, 'AppManager', 'sendIntentResponse', [action, str, intentId]);
    };
    AppManagerImpl.prototype.hasPendingIntent = function (onSuccess, onError) {
        function _onSuccess(ret) {
            if (typeof (ret) == "string") {
                if (ret == "true") {
                    ret = true;
                }
                else {
                    ret = false;
                }
            }
            if (onSuccess) {
                onSuccess(ret);
            }
        }
        exec(_onSuccess, onError, 'AppManager', 'hasPendingIntent', []);
    };
    AppManagerImpl.prototype.setVisible = function (visible, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'setVisible', [visible]);
    };
    AppManagerImpl.prototype.getVersion = function (onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'getVersion', []);
    };
    AppManagerImpl.prototype.setTitleBarProgress = function (progress, onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'setTitleBarProgress', [progress]);
    };
    AppManagerImpl.prototype.hideTitleBarProgress = function (onSuccess, onError) {
        exec(onSuccess, onError, 'AppManager', 'hideTitleBarProgress', []);
    };
    return AppManagerImpl;
}());
function jsonInfo(info) {
    if (typeof (info.icons) == "string") {
        info.icons = JSON.parse(info.icons);
    }
    if (typeof (info.plugins) == "string") {
        info.plugins = JSON.parse(info.plugins);
    }
    if (typeof (info.urls) == "string") {
        info.urls = JSON.parse(info.urls);
    }
}
module.exports = new AppManagerImpl();
