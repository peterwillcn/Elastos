/*
* Copyright (c) 2018-2020 Elastos Foundation
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

/**
* This plugins allows apps/capsules to send and receive notifications.
* Usually, the only application able to receive or notifications directly is the launcher app.
* Other applications may only be able to send notifications.
*
* Notifications are stored in a permanent storage after being received and can be retrieved after
* a system restart. Notifications have to be cleared manually whenever needed.
*
* <br><br>
* Usage:
* <br>
* declare let notificationManager: NotificationManagerPlugin.NotificationManager;
*/

declare namespace NotificationManagerPlugin {
    /**
     * Object used to generate a notification.
     */
    type NotificationRequest = {
        /** Identification key used to overwrite a previous notification if it has the same key. */
        key: string;
        /** Title to be displayed as the main message on the notification. */
        title: string;
        /** Intent URL emitted when the notification is clicked. */
        url?: string;
        /** Contact DID emitting this notification, in case of a remotely received notification. */
        emitter?: string;
    }

    /**
     * Received notification.
     */
    type Notification = NotificationRequest & {
        /** Unique identifier for each notification. */
        notificationId: string;
        /** Identification key used to overwrite a previous notification (for the same app id) if it has the same key. */
        key: string;
        /** Package ID of the sending app. */
        appId: string;
    }
    
    interface NotificationManager {
        /**
         * Sends a in-app notification. Notifications are usually displayed
         * by the launcher/home application, in a notifications panel, and they are directly used to 
         * inform users of something they can potentially interact with.
         * 
         * @param request The notification content.
         * 
         * @returns A promise that can be awaited and catched in case or error.
         */
        sendNotification(request: NotificationRequest): Promise<void>;

        /**
         * Registers a callback that will receive all the incoming in-app notifications (sent by this instance
         * of elastOS/Trinity or by a remote contact).
         * 
         * @param onNotification Callback passing the received notification info.
         */
        setNotificationListener(onNotification:(notification: Notification)=>void);

        /**
         * Returns all notifications previously received and not yet cleared.
         * 
         * @returns Unread notifications.
         */
        getNotifications(): Promise<Notification[]>;

        /**
         * Removes a received notification from the notifications list permanently.
         * 
         * @param notificationId Notification ID
         */
        clearNotification(notificationId: string);
    }
}