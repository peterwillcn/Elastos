package org.elastos.trinity.runtime.titlebar;

public enum TitleBarNavigationMode {
    HOME(0),
    CLOSE(1);

    private int mValue;

    TitleBarNavigationMode(int value) {
        mValue = value;
    }

    public static TitleBarNavigationMode fromId(int value) {
        for(TitleBarNavigationMode t : values()) {
            if (t.mValue == value) {
                return t;
            }
        }
        return HOME;
    }
}