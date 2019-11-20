package org.elastos.trinity.runtime;

import android.util.Log;
import org.elastos.did.*;

public class DIDVerifier {
    private static DIDStore mDIDStore;

    public static void initDidStore(String dataPath) throws Exception {
        String dataDir = dataPath + "/did_stores/" + "DIDVerifier";
        // FIXME: The passphrase should be removed after the DID Java SDK provide a new API
        // for initalize the DIDStore directory without passphrase.
        String passphrase = "mystorepass";

        Log.i("DIDPlugin", "dataDir:" + dataDir + " passphrase:" + passphrase);

        try {
            DIDStore.initialize("filesystem", dataDir, passphrase);
            mDIDStore = DIDStore.getInstance();
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
                diddoc = mDIDStore.resolveDid(did);
            }
            ret = diddoc.verify(didurl, epk_signature, epk_sha_str.getBytes());
        } catch (MalformedDIDURLException | MalformedDocumentException | DIDStoreException e) {
            e.printStackTrace();
        }
        return ret;
    }
}