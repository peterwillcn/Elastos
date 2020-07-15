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
* This plugin allows privileged built-in dApps to manage DID sessions, sign users in using their DIDs, sign out,
* register new identities, etc.
* <br><br>
* Usage:
* <br>
* declare let didSessionManager: DIDSessionManagerPlugin.DIDSessionManager;
*/

declare namespace DIDSessionManagerPlugin {
    type IdentityAvatar = {
        /** Picture content type: "image/jpeg" or "image/png" */
        contentType: string;
        /** Base64 encoded picture data */
        base64ImageData: Blob
    }

    type IdentityEntry = {
        /** ID of the DID store that containes this DID entry */
        didStoreId: string;
        /** DID string (ex: did:elastos:abcdef) */
        didString: string;
        /** Identity entry display name, set by the user */
        name: string;
        /** Optional profile picture for this identity */
        avatar?: IdentityAvatar;
    }

    interface DIDSessionManager {
        /**
         * Inserts a new identity entry and saves it permanently.
         * 
         * In case an entry with the same DID store ID and DID string already exists, the existing 
         * entry is updated.
         */
        addIdentityEntry(entry: IdentityEntry): Promise<void>;

        /**
         * Deletes a previously added identity entry.
         */
        deleteIdentityEntry(didString: string): Promise<void>;

        /**
         * Gets the list of all identity entries previously created.
         */
        getIdentityEntries(): Promise<IdentityEntry[]>;

        /**
         * Gets the signed in identity.
         * 
         * @returns The signed in identity if any, null otherwise.
         */
        getSignedInIdentity(): Promise<IdentityEntry>;

        /**
         * Signs a given identity entry in. 
         * 
         * This identity becomes the new global identity for the "DID Session".
         * All dApps get sandboxed in this DID context and don't see any information about the other available
         * identities.
         */
        signIn(entry: IdentityEntry): Promise<void>;

        /**
         * Signs the active identity out. All opened dApps are closed as there is no more active DID session.
         */
        signOut(): Promise<void>;

        /**
         * Assists dApps during their DID-based authentication phase to remote services.
         * 
         * Traditional authentication mechanism usually require users to provide a username and password and
         * in exchange, they get a JWT access token. 
         * 
         * Using DIDs, users need to proove that they own a DID sting first, so that all further communications
         * with a backend service can be based on that DID. 
         * 
         * For this, the backend service may provide a random nonce and other custom data it needs, and this method uses the signed in user's DID
         * to sign this data into a standadized payload, then returns a JWT. This JWT should be sent to the backend
         * service, who can check its validity and confirm the DID.
         * 
         * After that phase, it's up to the backend sevrice to use its own way to secure communications. Usually,
         * emitting a short-lived JWT access token to the user and using this token in for all exchanges is a 
         * recommended way.
         * 
         * @param payload Custom JSON-encodable object that contains backend service's information.
         * @param expiresIn Number of minutes after which the generated token will expire. Defaults to 5 minutes.
         * 
         * @returns A DID-signed JWT token that contains the given payload encapsulated in an auth-specific format (to NOT let apps automatically sign all kind of documents)
         */
        authenticate(payload: Object, expiresIn?: Number): Promise<String>;
    }
}