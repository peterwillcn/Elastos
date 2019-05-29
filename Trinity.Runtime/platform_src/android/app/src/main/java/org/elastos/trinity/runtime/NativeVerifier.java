package org.elastos.trinity.runtime;

public class NativeVerifier {
    public native static boolean verify(String public_key, String payload, String signed_payload);

    static {
        System.loadLibrary("verifier");
    }
}
