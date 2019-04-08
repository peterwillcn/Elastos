package org.elastos.trinity.runtime;

import android.app.Activity;
import android.content.Intent;

import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.CordovaPlugin;

import java.util.concurrent.Executors;

public class TrinityCordovaInterfaceImpl extends CordovaInterfaceImpl {

    protected WebViewFragment fragment;

    public TrinityCordovaInterfaceImpl(Activity activity, WebViewFragment fragment) {
        super(activity);
        this.fragment = fragment;
    }

    @Override
    public void startActivityForResult(CordovaPlugin command, Intent intent, int requestCode) {
        setActivityResultCallback(command);
        try {
            fragment.startActivityForResult(intent, requestCode);
        } catch (RuntimeException e) { // E.g.: ActivityNotFoundException
            activityResultCallback = null;
            throw e;
        }
    }
}
