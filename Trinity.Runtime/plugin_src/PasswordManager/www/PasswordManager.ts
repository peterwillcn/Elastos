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

class PasswordManagerImpl implements PasswordManagerPlugin.PasswordManager {
    setPasswordInfo(info: PasswordManagerPlugin.PasswordInfo): Promise<boolean> {
        return new Promise((resolve, reject)=>{
            exec((result: { couldSave: boolean })=>{
                resolve(result.couldSave);
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.setPasswordInfo()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'setPasswordInfo', [info]);    
        });
    }
    getPasswordInfo(key: string): Promise<PasswordManagerPlugin.PasswordInfo> {
        throw new Error("Method not implemented.");
    }
    getAllPasswordInfo(): Promise<PasswordManagerPlugin.PasswordInfo[]> {
        throw new Error("Method not implemented.");
    }
    deletePasswordInfo(key: string): Promise<boolean> {
        throw new Error("Method not implemented.");
    }
    generateRandomPassword(options?: PasswordManagerPlugin.PasswordCreationOptions): Promise<string> {
        throw new Error("Method not implemented.");
    }
    setMasterPassword(oldPassword: string, newPassword: string): Promise<void> {
        throw new Error("Method not implemented.");
    }
    lockMasterPassword() {
        throw new Error("Method not implemented.");
    }
    setUnlockMode(mode: PasswordManagerPlugin.PasswordUnlockMode) {
        throw new Error("Method not implemented.");
    }
}

export = new PasswordManagerImpl();