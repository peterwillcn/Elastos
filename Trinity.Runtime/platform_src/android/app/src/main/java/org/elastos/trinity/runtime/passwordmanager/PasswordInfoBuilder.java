package org.elastos.trinity.runtime.passwordmanager;

import org.elastos.trinity.runtime.passwordmanager.passwordinfo.AccountPasswordInfo;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.BankAccountPasswordInfo;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.BankCardPasswordInfo;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.GenericPasswordInfo;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.PasswordInfo;
import org.elastos.trinity.runtime.passwordmanager.passwordinfo.WifiPasswordInfo;
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
            case WIFI:
                return WifiPasswordInfo.fromJsonObject(jsonObject);
            case BANK_ACCOUNT:
                return BankAccountPasswordInfo.fromJsonObject(jsonObject);
            case BANK_CARD:
                return BankCardPasswordInfo.fromJsonObject(jsonObject);
            case ACCOUNT:
                return AccountPasswordInfo.fromJsonObject(jsonObject);
            default:
                throw new Exception("Unknown password info type "+type);
        }
    }
}
