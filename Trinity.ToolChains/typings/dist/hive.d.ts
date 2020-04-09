/*
 * Copyright (c) 2019 Elastos Foundation
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
// TODO: Replace with accurate types everywhere there is "any" or "Function".

/**
* This is about Hive which provides the IPFS(InterPlanetary File System, a protocol and
* peer-to-peer network for storing and sharing data in a distributed file system)-based
* APIs.
* <br><br>
* Please use 'HivePlugin' as the plugin name in the manifest.json if you want to use
* this facility.
* <br><br>
* Usage:
* <br>
* declare let hiveManager: HivePlugin.HiveManager;
*/

declare namespace HivePlugin {
    type Opaque<T, K> = T & { __opaque__: K };
    type Int = Opaque<number, 'Int'>;

    /**
     * The class representing IPFS.
     */
    interface IPFS {
        /**
         * Put data to IPFS backend.
         * 
         * @param data     The data to write.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        put(data: string): Promise<any>;

        /**
         * Get IPFS backend data through cid.
         * 
         * @param data     Content identifiers.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        get(cid: string): Promise<any>;

        /**
         * Get IPFS backend data length.
         * 
         * @param data     Content identifiers.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        size(cid: string): Promise<any>;
    }

    /**
     * The class representing Files.
     */
    interface Files {
        /**
         * Put data to backend.
         * 
         * @param remoteFile    Remote file name.
         * @param data          The data to write.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        put(remoteFile: string, data: string): Promise<any>;

        /**
         * Get backend data as string.
         * 
         * @param remoteFile    Remote file name.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        getAsString(remoteFile: string): Promise<any>;

        /**
         * Get backend data length.
         * 
         * @param remoteFile    Remote file name.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        size(remoteFile: string): Promise<any>;

        /**
         * Delete files on the backend.
         * 
         * @param remoteFile    Remote file name.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        deleteFile(remoteFile: string): Promise<any>;

        /**
         * List the files name on the backend.
         * 
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        list(): Promise<any>;
    }

    /**
     * The class representing KeyValues.
     */
    interface KeyValues {
        /**
         * Put the value of the key on the backend.
         * 
         * @param key       Key that needs to be set.
         * @param value     The value to write.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        putValue(key: string, value: string): Promise<any>;

        /**
         * Set the value of the key on the backend.
         * 
         * @param key       Key that needs to be set.
         * @param value     The data to write.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        putValue(key: string, value: string): Promise<any>;

        /**
         * Get the value of the key on the backend.
         * 
         * @param key       Key that needs to be set.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        getValues(key: string): Promise<any>;

        /**
         * Delete the key on the backend.
         * 
         * @param key       Key that needs to be set.
         * @return
         * A promise object that contains success information will be returned on success,
         * otherwise a promise object that contains error information will be returned.
         */
        deleteKey(key: string): Promise<any>;
    }

    /**
     * The class representing Client.
     */
    interface Client {
        /**
         * Connect to backend.
         * 
         * @param onSuccess  The function to call on success.
         * @param onError    The function to call on error.
         * @return
         * onSuccess will be called on success, otherwise onError will be called.
         */
        connect(onSuccess?: (info: any)=>void, onError?: (err: string)=>void);
        
        /**
         * Disconnect from backend.
         * 
         * @param onSuccess  The function to call on success.
         * @param onError    The function to call on error.
         * @return
         * onSuccess will be called on success, otherwise onError will be called.
         */
        disConnect(onSuccess?: (info: any)=>void, onError?: (err: string)=>void);

        /**
         * Get the connection status.
         * 
         * @param onSuccess  The function to call on success.
         * @param onError    The function to call on error.
         * @return
         * onSuccess will be called on success, otherwise onError will be called.
         */
        isConnected(onSuccess?: (info: any)=>void, onError?: (err: string)=>void);

        /**
         * Get the IPFS interface.
         * 
         * @param onSuccess  The function to call on success.
         * @param onError    The function to call on error.
         * @return
         * onSuccess will be called on success, otherwise onError will be called.
         */
        getIPFS(onSuccess?: (info: any)=>void, onError?: (err: string)=>void);

        /**
         * Get the Files interface.
         * 
         * @param onSuccess  The function to call on success.
         * @param onError    The function to call on error.
         * @return
         * onSuccess will be called on success, otherwise onError will be called.
         */
        getFiles(onSuccess?: (info: any)=>void, onError?: (err: string)=>void);

        /**
         * Get the KeyValues interface.
         * 
         * @param onSuccess  The function to call on success.
         * @param onError    The function to call on error.
         * @return
         * onSuccess will be called on success, otherwise onError will be called.
         */
        getKeyValues(onSuccess?: (info: any)=>void, onError?: (err: string)=>void);
    }

    const enum DriveType {
        NATIVE = 1,
        ONEDRIVE = 2,
        IPFS = 3
    }

    abstract class ClientCreationOptions {
        driveType: DriveType;
        constructor();
    }

    interface IPFSClientCreationOptions extends ClientCreationOptions {}
    interface OneDriveClientCreationOptions extends ClientCreationOptions {
        constructor(clientId: string, scope: string, redirectUrl: string);
    }

    interface HiveManager {
        getVersion(onSuccess?: ()=>void, onError?: (err: string)=>void);
        setListener(type: any, eventCallback: Function);
        createClient(handler: Function, options: ClientCreationOptions, onSuccess: (client: Client)=>void, onError?: (err: string)=>void);
    }
}