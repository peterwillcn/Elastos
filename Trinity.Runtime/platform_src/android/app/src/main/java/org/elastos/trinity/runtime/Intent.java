package org.elastos.trinity.runtime;

public class Intent {
    public String app_id;
    public String action;

    Intent(String app_id, String action) {
        this.app_id = app_id;
        this.action = action;
    }
}
