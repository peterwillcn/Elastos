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

class ContactImpl implements ContactNotifierPlugin.Contact {
    did: string = null;
    carrierUserID: string = null;

    getDID(): string {
        return this.did;
    }

    getCarrierUserID(): string {
        return this.carrierUserID;
    }

    sendRemoteNotification(remoteNotification: ContactNotifierPlugin.RemoteNotificationRequest): Promise<void> {
        return new Promise((resolve, reject) => {
            exec(ret => {
                resolve();
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.sendRemoteNotification()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'contactSendRemoteNotification', [this, remoteNotification]);
        });
    }

    setAllowNotifications(allowNotifications: boolean) {
        exec(() =>{
        }, err =>{
            console.error("Error while calling ContactNotifierPlugin.setAllowNotifications()", err);
        }, 'ContactNotifierPlugin', 'contactSetAllowNotifications', [this, allowNotifications]);
    }

    getOnlineStatus(): Promise<ContactNotifierPlugin.OnlineStatus> {
        return new Promise((resolve, reject) => {
            exec((result: { onlineStatus: ContactNotifierPlugin.OnlineStatus }) =>{
                resolve(result.onlineStatus);
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.getOnlineStatus()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'contactGetOnlineStatus', [this]);
        });
    }

    static fromJson(jsonObj: any): ContactImpl {
        let contact = new ContactImpl();
        Object.assign(contact, jsonObj);
        return contact;
    }
}

class ContactNotifierImpl implements ContactNotifierPlugin.ContactNotifier {
    getCarrierAddress(): Promise<string> {
        return new Promise((resolve, reject) => {
            exec((result: { address: string }) =>{
                resolve(result.address);
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.getCarrierAddress()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'notifierGetCarrierAddress', []);
        });
    }

    resolveContact(did: string): Promise<ContactNotifierPlugin.Contact> {
        return new Promise((resolve, reject) => {
            exec((result: { contact: any }) =>{
                let contact = ContactImpl.fromJson(result.contact);
                resolve(contact);
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.resolveContact()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'notifierResolveContact', [did]);
        });
    }

    removeContact(did: string) {
        exec(() =>{
        }, err =>{
            console.error("Error while calling ContactNotifierPlugin.removeContact()", err);
        }, 'ContactNotifierPlugin', 'notifierRemoveContact', [did]);
    }

    setOnlineStatusListener(onStatusChanged: (contact: ContactNotifierPlugin.Contact, status: ContactNotifierPlugin.OnlineStatus) => void, onError?: (error: string) => void) {
        exec((result: { contact: ContactNotifierPlugin.Contact, status: ContactNotifierPlugin.OnlineStatus}) =>{
            onStatusChanged(result.contact, result.status);
        }, err =>{
            console.error("Error while calling ContactNotifierPlugin.setOnlineStatusListener()", err);
        }, 'ContactNotifierPlugin', 'notifierSetOnlineStatusListener', []);
    }

    setOnlineStatusMode(onlineStatusMode: ContactNotifierPlugin.OnlineStatusMode) {
        exec(() =>{
        }, err =>{
            console.error("Error while calling ContactNotifierPlugin.setOnlineStatusMode()", err);
        }, 'ContactNotifierPlugin', 'notifierSetOnlineStatusMode', [onlineStatusMode]);
    }

    getOnlineStatusMode(): Promise<ContactNotifierPlugin.OnlineStatusMode> {
        return new Promise((resolve, reject)=>{
            exec((result: { onlineStatusMode: ContactNotifierPlugin.OnlineStatusMode }) =>{
                resolve(result.onlineStatusMode);
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.getOnlineStatusMode()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'notifierGetOnlineStatusMode', []);
        });
    }

    sendInvitation(did: string, carrierAddress: string) {
        exec(() =>{
        }, err =>{
            console.error("Error while calling ContactNotifierPlugin.sendInvitation()", err);
        }, 'ContactNotifierPlugin', 'notifierSendInvitation', [did, carrierAddress]);
    }

    acceptInvitation(invitationId: string): Promise<ContactNotifierPlugin.Contact> {
        return new Promise((resolve, reject) => {
            exec((result: { contact: any }) =>{
                let contact = ContactImpl.fromJson(result.contact);
                resolve(contact);
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.acceptInvitation()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'notifierAcceptInvitation', [invitationId]);
        });
    }

    rejectInvitation(invitationID: string) {
        return new Promise((resolve, reject) => {
            exec(() =>{
                resolve();
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.rejectInvitation()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'notifierRejectInvitation', [invitationID]);
        });
    }

    setOnInvitationAcceptedListener(onInvitationAccepted: (contact: ContactNotifierPlugin.Contact) => void) {
        exec((result: { contact: any }) =>{
            let contact = ContactImpl.fromJson(result.contact);
            onInvitationAccepted(contact);
        }, err =>{
            console.error("Error while calling ContactNotifierPlugin.setOnInvitationAcceptedListener()", err);
        }, 'ContactNotifierPlugin', 'notifierSetOnInvitationAcceptedListener', []);
    }

    setInvitationRequestsMode(mode: ContactNotifierPlugin.InvitationRequestsMode) {
        exec(() =>{
        }, err =>{
            console.error("Error while calling ContactNotifierPlugin.setInvitationRequestsMode()", err);
        }, 'ContactNotifierPlugin', 'notifierSetInvitationRequestsMode', [mode]);
    }

    getInvitationRequestsMode(): Promise<ContactNotifierPlugin.InvitationRequestsMode> {
        return new Promise((resolve, reject)=>{
            exec((result: { invitationRequestsMode: ContactNotifierPlugin.InvitationRequestsMode }) =>{
                resolve(result.invitationRequestsMode);
            }, err =>{
                console.error("Error while calling ContactNotifierPlugin.getInvitationRequestsMode()", err);
                reject(err);
            }, 'ContactNotifierPlugin', 'notifierGetInvitationRequestsMode', []);
        });
    }
}

export = new ContactNotifierImpl();