package org.elastos.trinity.runtime;

import org.elastos.did.DIDAdapter;

public class FakeAdapter implements DIDAdapter {
    @Override
    public boolean createIdTransaction(String payload, String memo) {
        return false;
    }

    @Override
    public String resolve(String did) {
        return null;
    }
}