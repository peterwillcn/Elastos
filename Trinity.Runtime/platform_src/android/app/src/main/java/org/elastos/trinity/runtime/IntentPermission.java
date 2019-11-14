package org.elastos.trinity.runtime;

import java.util.ArrayList;

public class IntentPermission {
    private String name;
    private ArrayList<String> senderList = new ArrayList<String>();
    private ArrayList<String> receiverList = new ArrayList<String>();

    public IntentPermission(String name) {
        this.name = name;
    }

    public void addSender(String appId) {
        if (senderList == null) {
            senderList = new ArrayList<String>();
        }
        senderList.add(appId);
    }

    public void addReceiver(String appId) {
        if (receiverList == null) {
            receiverList = new ArrayList<String>();
        }
        receiverList.add(appId);
    }

    public boolean senderIsAllow(String appId) {
        if (senderList == null) {
            return true;
        }
        return senderList.contains(appId);
    }

    public boolean receiverIsAllow(String appId) {
        if (receiverList == null) {
            return true;
        }
        return receiverList.contains(appId);
    }
}
