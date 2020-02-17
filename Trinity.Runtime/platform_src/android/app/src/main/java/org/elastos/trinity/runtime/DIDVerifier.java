package org.elastos.trinity.runtime;

import android.util.Log;
import org.elastos.did.*;
import org.elastos.did.exception.DIDException;


public class DIDVerifier {
    private static DIDStore mDIDStore;

    public static void initDidStore(String dataPath) throws Exception {
        String dataDir = dataPath + "/did_stores/" + "DIDVerifier";
        String cacheDir = dataPath + "/did_stores/" + ".cache.did.elastos";

        Log.i("DIDVerifier", "dataDir:" + dataDir);

        String resolver = ConfigManager.getShareInstance().getStringValue("did.resolver", "http://api.elastos.io:20606");

        try {
            DIDBackend.initialize(resolver, cacheDir);
            mDIDStore = DIDStore.open("filesystem", dataDir, new DIDAdapter() {
                @Override
                public void createIdTransaction(String payload, String memo, int confirms, TransactionCallback callback) {
                    Log.i("DIDVerifier", "createIdTransaction");
                    callback.accept("", 0, null);
                }
            });
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
            DIDDocument diddoc = did.resolve(true);
            if (diddoc == null) {
                diddoc = mDIDStore.loadDid(did);
                if (diddoc == null) {
                    return false;
                }
            }
            ret = diddoc.verify(didurl, epk_signature, epk_sha_str.getBytes());
        } catch (DIDException e) {
            e.printStackTrace();
        }
        return ret;
    }
}