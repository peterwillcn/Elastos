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

import Foundation
import ElastosDIDSDK

class RuntimeDIDAdapter: DIDAdapter {
    func createIdTransaction(_ payload: String, _ memo: String?, _ confirms: Int, _ callback: @escaping (String, Int, String?) -> Void) {
        print("RuntimeDIDAdapter createIdTransaction");
        callback("", 0, nil);
    }
}

public class DIDVerifier {
    private static let mDIDStore: DIDStore? = nil

    public static func initDidStore(dataPath: String) throws {
        let dataDir = dataPath + "/did_stores/" + "DIDVerifier"
        let cacheDir = dataPath + "/did_stores/" + ".cache.did.elastos"

        print("DIDVerifier", "dataDir: \(dataDir)")

        let resolverUrl = PreferenceManager.getShareInstance().getDIDResolver();

        do {
            try DIDBackend.initializeInstance(resolverUrl, cacheDir);

            let adapter = RuntimeDIDAdapter();
            let mDIDStore = try DIDStore.open(atPath: dataDir, withType: "filesystem", adapter: adapter);
        } catch {
            print(error)
        }
    }

    public static func verify(epk_didurl: String, epk_pubkey: String, epk_sha_str: String, epk_signature: String) -> Bool {
        
        var didurl: DIDURL
        var ret = false
        
        guard let didStore = mDIDStore else {
            print("DID Verifier's DID store not initialized")
            return false
        }
        
        do {
            didurl = try DIDURL(epk_didurl)
            
            guard let did = didurl.did as DID? else {
                return false
            }
            
            var diddoc = try did.resolve(true)
            if diddoc == nil {
                diddoc = try didStore.loadDid(did)
                if diddoc == nil {
                    return false
                }
            }
            ret = try diddoc.verify(withId: didurl, using: epk_signature, onto: epk_sha_str.data(using: .utf8)!)
        } catch {
            print(error)
        }
        return ret
    }
}
