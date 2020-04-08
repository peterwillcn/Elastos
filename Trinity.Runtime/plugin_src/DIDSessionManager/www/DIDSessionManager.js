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
var DIDSessionManagerImpl = /** @class */ (function () {
    function DIDSessionManagerImpl() {
    }
    DIDSessionManagerImpl.prototype.addIdentityEntry = function (entry) {
        return new Promise(function (resolve, reject) {
            exec(function (ret) {
                resolve();
            }, function (err) {
                console.error("Error while calling DIDSessionManagerPlugin.addIdentityEntry()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'addIdentityEntry', [entry]);
        });
    };
    DIDSessionManagerImpl.prototype.deleteIdentityEntry = function (didString) {
        return new Promise(function (resolve, reject) {
            exec(function (ret) {
                resolve();
            }, function (err) {
                console.error("Error while calling DIDSessionManagerPlugin.deleteIdentityEntry()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'deleteIdentityEntry', [didString]);
        });
    };
    DIDSessionManagerImpl.prototype.getIdentityEntries = function () {
        return new Promise(function (resolve, reject) {
            exec(function (ret) {
                var entries = ret.entries.map(function (entry) {
                    JSON.parse(entry);
                });
                console.log("entries", entries);
                resolve(entries);
            }, function (err) {
                console.error("Error while calling DIDSessionManagerPlugin.getIdentityEntries()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'getIdentityEntries', []);
        });
    };
    DIDSessionManagerImpl.prototype.getSignedInIdentity = function () {
        return new Promise(function (resolve, reject) {
            exec(function (ret) {
                resolve(ret);
            }, function (err) {
                console.error("Error while calling DIDSessionManagerPlugin.getSignedInIdentity()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'getSignedInIdentity', []);
        });
    };
    DIDSessionManagerImpl.prototype.signIn = function (entry) {
        return new Promise(function (resolve, reject) {
            exec(function (ret) {
                resolve();
            }, function (err) {
                console.error("Error while calling DIDSessionManagerPlugin.signIn()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'signIn', [entry]);
        });
    };
    DIDSessionManagerImpl.prototype.signOut = function () {
        return new Promise(function (resolve, reject) {
            exec(function (ret) {
                resolve();
            }, function (err) {
                console.error("Error while calling DIDSessionManagerPlugin.signOut()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'signOut', []);
        });
    };
    return DIDSessionManagerImpl;
}());
module.exports = new DIDSessionManagerImpl();
