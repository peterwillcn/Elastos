package org.elastos.trinity.runtime.titlebar;

enum BuiltInIcon {
    BACK("back"),
    CLOSE("close"),
    SCAN("scan"),
    ADD("add"),
    DELETE("delete"),
    SETTINGS("settings"),
    HELP("help"),
    HORIZONTAL_MENU("horizontal_menu"),
    VERTICAL_MENU("vertical_menu");

    private String mValue;

    BuiltInIcon(String value) {
        mValue = value;
    }

    public static BuiltInIcon fromString(String value) {
        for(BuiltInIcon t : values()) {
            if (t.mValue.equals(value)) {
                return t;
            }
        }
        return null;
    }
}