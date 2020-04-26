package org.elastos.trinity.runtime.passwordmanager.passwordinfo;

import org.json.JSONException;
import org.json.JSONObject;

public class BankCardPasswordInfo extends PasswordInfo {
    private BankCardType cardType = null;
    private String accountOwner = null;
    private String cardNumber = null;
    private String expirationDate = null;
    private String cvv = null;
    private String bankName = null;

    public static PasswordInfo fromJsonObject(JSONObject jsonObject) throws Exception {
        WifiPasswordInfo info = new WifiPasswordInfo();

        info.fillWithJsonObject(jsonObject);

        return info;
    }

    @Override
    public JSONObject asJsonObject() {
        try {
            JSONObject jsonObject = super.asJsonObject();

            jsonObject.put("cardType", cardType.mValue);
            jsonObject.put("accountOwner", accountOwner);
            jsonObject.put("cardNumber", cardNumber);
            jsonObject.put("expirationDate", expirationDate);
            jsonObject.put("cvv", cvv);
            jsonObject.put("bankName", bankName);

            return jsonObject;
        } catch (
                JSONException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void fillWithJsonObject(JSONObject jsonObject) throws Exception {
        // Fill base fields
        super.fillWithJsonObject(jsonObject);

        // Fill specific fields
        if (jsonObject.has("type")) {
            this.cardType = BankCardType.fromValue(jsonObject.getInt("cardType"));
        }
        this.accountOwner = jsonObject.optString("accountOwner");
        this.accountOwner = jsonObject.optString("cardNumber");
        this.accountOwner = jsonObject.optString("expirationDate");
        this.accountOwner = jsonObject.optString("cvv");
        this.accountOwner = jsonObject.optString("bankName");
    }
}
