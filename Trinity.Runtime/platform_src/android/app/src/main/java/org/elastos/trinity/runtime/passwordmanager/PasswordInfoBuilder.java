package org.elastos.trinity.runtime.passwordmanager;

import org.elastos.trinity.runtime.passwordmanager.passwordinfo.GenericPasswordInfo;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.PasswordInfo;
import org.json.JSONObject;

public class PasswordInfoBuilder {
    public static PasswordInfo buildFromType(JSONObject jsonObject) throws Exception {
        if (!jsonObject.has("type")) {
            throw new Exception("JSON object has no type information");
        }

        PasswordType type = PasswordType.fromValue(jsonObject.getInt("type"));
        switch (type) {
            case GENERIC_PASSWORD:
                return GenericPasswordInfo.fromJsonObject(jsonObject);
                // TODO: all types
            default:
                throw new Exception("Unknown password info type "+type);
        }
    }
}
