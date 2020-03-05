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

public class DIDVerifier {
    private static let mDIDStore: DIDStore? = nil

    public static func initDidStore(dataPath: String) throws {
        let dataDir = dataPath + "/did_stores/" + "DIDVerifier"
        let cacheDir = dataPath + "/did_stores/" + ".cache.did.elastos"

        Log.i("DIDVerifier", "dataDir: \(dataDir)")

        let resolverUrl = ConfigManager.getShareInstance().getStringValue("did.resolver", "http://api.elastos.io:20606")

        do {
            // TODO: IN A MESS - WAITING FOR MULTIE INSTANCE SUPPORT IN SIWFT DID SDK TO CONTINUE
            /* TPDP let backend = DIDPlugin.getDIDBackendInstance()
            mDIDStore = DIDStore.open("filesystem", dataDir, new DIDAdapter() {
                @Override
                public void createIdTransaction(String payload, String memo, int confirms, TransactionCallback callback) {
                    Log.i("DIDVerifier", "createIdTransaction");
                    callback.accept("", 0, null);
                }
            });*/
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
            
            guard let did = didurl.did else {
                return false
            }
            
            var diddoc = try did.resolve(true)
            if diddoc == nil {
                diddoc = try didStore.loadDid(did)
                if diddoc == nil {
                    return false
                }
            }
            ret = try diddoc?.verify(didurl, epk_signature, epk_sha_str) ?? false
        } catch {
            print(error)
        }
        return ret
    }
}
