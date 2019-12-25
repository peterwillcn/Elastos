package org.elastos.trinity.runtime;

import org.elastos.did.DIDAdapter;

import java.io.InputStream;

public class FakeAdapter implements DIDAdapter {
    @Override
    public String createIdTransaction(String payload, String memo) {
        return "";
    }

    @Override
    public InputStream resolve(String requestId, String did, boolean all) {
        return null;
    }
}