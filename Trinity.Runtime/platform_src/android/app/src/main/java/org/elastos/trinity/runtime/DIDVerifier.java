package org.elastos.trinity.runtime;

import android.util.Log;
import org.elastos.did.*;
import org.elastos.did.adapter.AbstractAdapter;
import org.elastos.did.exception.DIDException;


public class DIDVerifier {
    private static DIDStore mDIDStore;

    public static void initDidStore(String dataPath) throws Exception {
        String dataDir = dataPath + "/did_stores/" + "DIDVerifier";

        Log.i("DIDVerifier", "dataDir:" + dataDir);

        String resolver = ConfigManager.getShareInstance().getStringValue("did.resolver", "http://api.elastos.io:20606");

        try {
            // TODO Temporary comment, add again after update DID sdk
            // DIDBackend.initialize(new AbstractAdapter(resolver) {
            //     @Override
            //     public String createIdTransaction(String payload, String memo) throws DIDException {
            //         return null;
            //     }
            // });
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