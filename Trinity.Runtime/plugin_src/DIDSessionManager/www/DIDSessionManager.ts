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

class DIDSessionManagerImpl implements DIDSessionManagerPlugin.DIDSessionManager {
    addIdentityEntry(entry: DIDSessionManagerPlugin.IdentityEntry): Promise<void> {
        return new Promise((resolve, reject) => {
            exec(ret =>{
                resolve();
            }, err =>{
                console.error("Error while calling DIDSessionManagerPlugin.addIdentityEntry()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'addIdentityEntry', [entry]);
        });
    }

    deleteIdentityEntry(didString: string): Promise<void> {
        return new Promise((resolve, reject) => {
            exec(ret =>{
                resolve();
            }, err =>{
                console.error("Error while calling DIDSessionManagerPlugin.deleteIdentityEntry()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'deleteIdentityEntry', [didString]);
        });
    }

    getIdentityEntries(): Promise<DIDSessionManagerPlugin.IdentityEntry[]> {
        return new Promise((resolve, reject) => {
            exec(ret =>{
                resolve(ret.entries);
            }, err =>{
                console.error("Error while calling DIDSessionManagerPlugin.getIdentityEntries()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'getIdentityEntries', []);
        });
    }

    getSignedInIdentity(): Promise<DIDSessionManagerPlugin.IdentityEntry> {
        return new Promise((resolve, reject) => {
            exec(ret =>{
                resolve(ret);
            }, err =>{
                console.error("Error while calling DIDSessionManagerPlugin.getSignedInIdentity()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'getSignedInIdentity', []);
        });
    }

    signIn(entry: DIDSessionManagerPlugin.IdentityEntry): Promise<void> {
        return new Promise((resolve, reject) => {
            exec(ret =>{
                resolve();
            }, err =>{
                console.error("Error while calling DIDSessionManagerPlugin.signIn()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'signIn', [entry]);
        });
    }

    signOut(): Promise<void> {
        return new Promise((resolve, reject) => {
            exec(ret =>{
                resolve();
            }, err =>{
                console.error("Error while calling DIDSessionManagerPlugin.signOut()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'signOut', []);
        });
    }

    authenticate(payload: Object, expiresIn?: Number): Promise<String> {
        return new Promise((resolve, reject) => {
            exec((ret: { jwtToken: String } ) =>{
                if (ret.jwtToken)
                    resolve(ret.jwtToken);
                else
                    resolve(null);
            }, err =>{
                console.error("Error while calling DIDSessionManagerPlugin.authenticate()", err);
                reject(err);
            }, 'DIDSessionManagerPlugin', 'authenticate', [payload, expiresIn]);
        });
    }
}

export = new DIDSessionManagerImpl();