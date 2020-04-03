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
    type IdentityEntry = {
        didStoreId: string;
        didString: string;
        name: string;
        //picture: string;
    }

    interface DIDSessionManager {
        /**
         * Inserts a new identity entry and saves it permanently.
         */
        addIdentityEntry(entry: IdentityEntry);

        /**
         * Deletes a previously added identity entry.
         */
        deleteIdentityEntry(didString: string);

        /**
         * Gets the list of all identity entries previously created.
         */
        getIdentityEntries();

        /**
         * Gets the signed in identity.
         * 
         * @returns The signed in identity if any, null otherwise.
         */
        getSignedInIdentity(): IdentityEntry;

        /**
         * Signs a given identity entry in. 
         * 
         * This identity becomes the new global identity for the "DID Session".
         * All dApps get sandboxed in this DID context and don't see any information about the other available
         * identities.
         */
        signIn(entry: IdentityEntry);
        signOut();
    }
}