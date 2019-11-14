package org.elastos.trinity.runtime;

import android.content.Intent;
import android.content.res.Configuration;
import android.net.Uri;
import android.os.Bundle;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaArgs;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaPreferences;
import org.apache.cordova.CordovaResourceApi;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.ICordovaClientCertRequest;
import org.apache.cordova.ICordovaHttpAuthHandler;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class Utility {
    public static JSONObject getJsonFromFile(InputStream inputStream) throws Exception {
        InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "UTF-8");
        BufferedReader bufReader = new BufferedReader(inputStreamReader);
        String line;
        StringBuilder builder = new StringBuilder();
        while ((line = bufReader.readLine()) != null) {
            builder.append(line);
        }
        bufReader.close();
        inputStreamReader.close();
        JSONObject json = new JSONObject(builder.toString());
        return json;
    }
}
