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

let exec = cordova.exec;

class AppManagerImpl implements AppManagerPlugin.AppManager {
    constructor() {
    }

    getLocale(onSuccess: (defaultLang: string, currentLang: string, systemLang: string) => void) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info.defaultLang, info.currentLang, info.systemLang);
            }
        };
        exec(_onSuccess, null, 'AppManager', 'getLocale');
    }

    setCurrentLocale(code: string, onSuccess: (appInfo: AppManagerPlugin.AppInfo) => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'setCurrentLocale', [code]);
    }

    install(url: string, update: Boolean, onSuccess: (appInfo: AppManagerPlugin.AppInfo) => void, onError?: (err: string) => void) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info);
            }
        };
        exec(_onSuccess, onError, 'AppManager', 'install', [url, update]);
    }

    unInstall(id: string, onSuccess: (id: string) => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'unInstall', [id]);
    }

    getInfo(onSuccess: (appInfo: AppManagerPlugin.AppInfo) => void, onError?: (err: string) => void) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info);
            }
        };
        exec(_onSuccess, onError, 'AppManager', 'getInfo', []);
    }

    getAppInfo(id: string, onSuccess: (appInfo: AppManagerPlugin.AppInfo) => void, onError?: (err: string) => void) {
        function _onSuccess(info) {
            jsonInfo(info);
            if (onSuccess) {
                onSuccess(info);
            }
        };
        exec(_onSuccess, onError, 'AppManager', 'getAppInfo', [id]);
    }

    getAppInfos(onSuccess: (appsInfo: AppManagerPlugin.AppInfo[], idList: string[]) => void) {
        function _onSuccess(info) {
            for (var id in info) {
                jsonInfo(info[id]);
            }

            if (onSuccess) {
                onSuccess(info.infos, info.list);
            }
        };
        exec(_onSuccess, null, 'AppManager', 'getAppInfos');
    }

    start(id: string, onSuccess: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'start', [id]);
    }

    launcher(onSuccess?: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'launcher', []);
    }

    close(onSuccess?: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'close', []);
    }

    closeApp(id: string, onSuccess?: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'closeApp', [id]);
    }

    sendMessage(id: string, type: AppManagerPlugin.MessageType, msg: string, onSuccess: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'sendMessage', [id, type, msg]);
    }

    broadcastMessage(type: AppManagerPlugin.MessageType, message: string, onSuccess?: () => void) {
        exec(onSuccess, null, 'AppManager', 'broadcastMessage', [type, message]);
    }

    setListener(callback: (msg: AppManagerPlugin.ReceivedMessage) => void) {
        exec(callback, null, 'AppManager', 'setListener');
    }
    getRunningList(onSuccess: (ids: string[]) => void) {
        exec(onSuccess, null, 'AppManager', 'getRunningList');
    }
    getAppList(onSuccess: (ids: string[]) => void) {
        exec(onSuccess, null, 'AppManager', 'getAppList');
    }
    getLastList(onSuccess: (ids: string[]) => void) {
        exec(onSuccess, null, 'AppManager', 'getLastList');
    }
    setPluginAuthority(id: string, plugin: string, authority: AppManagerPlugin.PluginAuthority, onSuccess: () => void, onError: (err: any) => void) {
        exec(onSuccess, onError, 'AppManager', 'setPluginAuthority', [id, plugin, authority]);
    }
    setUrlAuthority(id: string, url: string, authority: AppManagerPlugin.UrlAuthority, onSuccess: () => void, onError: (err: any) => void) {
        exec(onSuccess, onError, 'AppManager', 'setUrlAuthority', [id, url, authority]);
    }
    alertPrompt(title: string, message: string) {
        exec(null, null, 'AppManager', 'alertPrompt', [title, message]);
    }
    infoPrompt(title: string, message: string) {
        exec(null, null, 'AppManager', 'infoPrompt', [title, message]);
    }
    askPrompt(title: string, message: string, onOK: () => void) {
        exec(onOK, null, 'AppManager', 'askPrompt', [title, message]);
    }
    sendIntent(action: string, params: any, options?: AppManagerPlugin.IntentOptions, onSuccess?: (ret: any) => void, onError?: (err: any) => void) {
        var str = JSON.stringify(params);
        function _onSuccess(ret) {
            if (typeof (ret.result) == "string") {
                ret.result = JSON.parse(ret.result);
            }
            if (onSuccess) {
                onSuccess(ret);
            }
        };
        exec(_onSuccess, onError, 'AppManager', 'sendIntent', [action, str, options]);
    }

    sendUrlIntent(url: string, onSuccess: () => void, onError: (err: any) => void) {
        exec(onSuccess, onError, 'AppManager', 'sendUrlIntent', [url]);
    }

    setIntentListener(callback: (msg: AppManagerPlugin.ReceivedIntent) => void) {
        function _onReceiveIntent(ret) {
            if (typeof (ret.params) == "string") {
                ret.params = JSON.parse(ret.params);
            }
            if (callback) {
                callback(ret);
            }
        }
        exec(_onReceiveIntent, null, 'AppManager', 'setIntentListener');
    }
    sendIntentResponse(action: string, result: any, intentId: Number, onSuccess: (response: any) => void, onError?: (err: any) => void) {
        var str = JSON.stringify(result);

        function _onSuccess(_response:any) {
            if (onSuccess)
                onSuccess(_response);
        }
        function _onError(_err:any) {
            if (onError)
                onError(_err);
        }

        exec(_onSuccess, _onError, 'AppManager', 'sendIntentResponse', [action, str, intentId]);
    }

    hasPendingIntent(onSuccess: (hasPendingIntent: boolean) => void, onError?: (err: any) => void) {
        function _onSuccess(ret: any) {
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
    }

    setVisible(visible: string, onSuccess: () => void, onError: (err: any) => void) {
        exec(onSuccess, onError, 'AppManager', 'setVisible', [visible]);
    }

    getVersion(onSuccess: (version: string) => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'getVersion', []);
    }

    getSetting(key: string, onSuccess: (value: any) => void, onError?: (err: string) => void) {
        function _onSuccess(value: any) {
            if (onSuccess) {
                onSuccess(value.value);
            }
        };
        exec(_onSuccess, onError, 'AppManager', 'getSetting', [key]);
    }

    getSettings(onSuccess: (values: any) => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'getSettings', []);
    }


    setSetting(key: string, value: any, onSuccess: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'setSetting', [key, value]);
    }

    getPreference(key: string, onSuccess: (value: any) => void, onError?: (err: string) => void) {
        function _onSuccess(value: any) {
            if (onSuccess) {
                onSuccess(value.value);
            }
        };
        exec(_onSuccess, onError, 'AppManager', 'getPreference', [key]);
    }

    getPreferences(onSuccess: (values: any) => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'getPreferences', []);
    }

    setPreference(key: string, value: any, onSuccess: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'setPreference', [key, value]);
    }

    resetPreferences(onSuccess: () => void, onError?: (err: string) => void) {
        exec(onSuccess, onError, 'AppManager', 'resetPreferences', []);
    }
}

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

export = new AppManagerImpl();