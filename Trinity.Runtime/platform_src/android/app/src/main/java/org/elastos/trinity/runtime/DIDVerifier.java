package org.elastos.trinity.runtime;

import android.util.Log;
import org.elastos.did.*;
import org.elastos.did.exception.DIDException;


public class DIDVerifier {
    private static DIDStore mDIDStore;

    public static void initDidStore(String dataPath) throws Exception {
        String dataDir = dataPath + "/did_stores/" + "DIDVerifier";

        Log.i("DIDPlugin", "dataDir:" + dataDir);

        try {
            DIDBackend.initialize(new FakeAdapter());
            mDIDStore = DIDStore.open("filesystem", dataDir);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean verify(String epk_didurl, String epk_pubkey, String epk_sha_str, String epk_signature) {
        DIDURL didurl;
        boolean ret = false;
        try {
            didurl = new DIDURL(epk_didurl);
            DID did = didurl.getDid();
            DIDDocument diddoc = mDIDStore.loadDid(did);
            if (diddoc == null) {
                diddoc = did.resolve(true);
            }
            ret = diddoc.verify(didurl, epk_signature, epk_sha_str.getBytes());
        } catch (DIDException e) {
            e.printStackTrace();
        }
        return ret;
    }
}