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
        return new Promise((resolve, reject)=>{
            exec((result: { passwordInfo: PasswordManagerPlugin.PasswordInfo })=>{
                resolve(result.passwordInfo);
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.getPasswordInfo()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'getPasswordInfo', [key]);    
        });
    }

    getAllPasswordInfo(): Promise<PasswordManagerPlugin.PasswordInfo[]> {
        return new Promise((resolve, reject)=>{
            exec((result: { allPasswordInfo: PasswordManagerPlugin.PasswordInfo[] })=>{
                resolve(result.allPasswordInfo);
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.getAllPasswordInfo()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'getAllPasswordInfo', []);    
        });
    }

    deletePasswordInfo(key: string): Promise<boolean> {
        return new Promise((resolve, reject)=>{
            exec((result: { couldDelete: boolean })=>{
                resolve(result.couldDelete);
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.deletePasswordInfo()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'deletePasswordInfo', [key]);    
        });
    }

    generateRandomPassword(options?: PasswordManagerPlugin.PasswordCreationOptions): Promise<string> {
        return new Promise((resolve, reject)=>{
            exec((result: { generatedPassword: string })=>{
                resolve(result.generatedPassword);
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.generateRandomPassword()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'generateRandomPassword', [options]);    
        });
    }
    setMasterPassword(oldPassword: string, newPassword: string): Promise<boolean> {
        return new Promise((resolve, reject)=>{
            exec((result: { couldSet: boolean })=>{
                resolve(result.couldSet);
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.setMasterPassword()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'setMasterPassword', [oldPassword, newPassword]);    
        });
    }

    lockMasterPassword() {
        return new Promise((resolve, reject)=>{
            exec(()=>{
                resolve();
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.lockMasterPassword()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'lockMasterPassword', []);    
        });
    }

    setUnlockMode(mode: PasswordManagerPlugin.PasswordUnlockMode) {
        return new Promise((resolve, reject)=>{
            exec(()=>{
                resolve();
            }, (err)=>{
                console.error("Error while calling PasswordManagerPlugin.setUnlockMode()", err);
                reject(err);
            }, 'PasswordManagerPlugin', 'setUnlockMode', [mode]);    
        });
    }
}

export = new PasswordManagerImpl();