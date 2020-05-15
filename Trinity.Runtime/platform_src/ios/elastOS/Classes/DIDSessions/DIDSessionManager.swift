/*
* Copyright (c) 2020 Elastos Foundation
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

public class DIDSessionManager {
    private static var instance: DIDSessionManager? = nil
    private let dbAdapter: DIDSessionDatabaseAdapter
    private var appManager: AppManager? = nil

    init() {
        dbAdapter = DIDSessionDatabaseAdapter()
        DIDSessionManager.instance = self
    }

    public static func getSharedInstance() -> DIDSessionManager {
        return instance!
    }

    func setAppManager(_ appManager: AppManager) {
        self.appManager = appManager
    }
    
    func addIdentityEntry(entry: IdentityEntry) throws {
        _ = try dbAdapter.addDIDSessionIdentityEntry(entry: entry)
    }

    func deleteIdentityEntry(didString: String) throws {
        try dbAdapter.deleteDIDSessionIdentityEntry(didString: didString)
    }

    func getIdentityEntries() throws -> Array<IdentityEntry> {
        return try dbAdapter.getDIDSessionIdentityEntries()
    }

    func getSignedInIdentity() throws -> IdentityEntry? {
        return try dbAdapter.getDIDSessionSignedInIdentity()
    }

    func signIn(identityToSignIn: IdentityEntry) throws {
        // Make sure there is no signed in identity already
        guard (try DIDSessionManager.getSharedInstance().getSignedInIdentity()) == nil else {
            throw "Unable to sign in. Please first sign out from the currently signed in identity"
        }

        try dbAdapter.setDIDSessionSignedInIdentity(entry: identityToSignIn)

        // Ask the manager to handle the UI sign in flow.
        try appManager!.signIn()
    }

    public func signOut() throws {
        try dbAdapter.setDIDSessionSignedInIdentity(entry: nil)

        // Ask the app manager to sign out and redirect user to the right screen
        try appManager!.signOut()
    }
}
