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

class NotificationManagerImpl implements NotificationManagerPlugin.NotificationManager {
    sendNotification(request: NotificationManagerPlugin.NotificationRequest): Promise<void> {
        return new Promise((resolve, reject) => {
            exec(ret =>{
                resolve();
            }, err =>{
                console.error("Error while calling NotificationManagerPlugin.sendNotification()", err);
                reject(err);
            }, 'NotificationManagerPlugin', 'sendNotification', [request]);
        });
    }

    setNotificationListener(onNotification: (notification: NotificationManagerPlugin.Notification) => void) {
        exec(ret =>{
        }, err =>{
            console.error("Error while calling NotificationManagerPlugin.setNotificationListener()", err);
        }, 'NotificationManagerPlugin', 'setNotificationListener', [onNotification]);
    }

    getNotifications(): Promise<NotificationManagerPlugin.Notification[]> {
        return new Promise((resolve, reject) => {
            exec((notifications: NotificationManagerPlugin.Notification[]) => {
                resolve(notifications);
            }, err =>{
                console.error("Error while calling NotificationManagerPlugin.getNotifications()", err);
                reject(err);
            }, 'NotificationManagerPlugin', 'getNotifications', []);
        });
    }


    clearNotification(notificationId: string) {
        exec(ret =>{
        }, err =>{
            console.error("Error while calling NotificationManagerPlugin.clearNotification()", err);
        }, 'NotificationManagerPlugin', 'clearNotification', [notificationId]);
    }
}

export = new NotificationManagerImpl();