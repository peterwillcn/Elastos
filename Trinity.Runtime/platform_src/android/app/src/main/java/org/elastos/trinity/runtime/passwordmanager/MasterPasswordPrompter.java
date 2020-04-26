package org.elastos.trinity.runtime.passwordmanager;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.widget.EditText;

class MasterPasswordPrompter {
    public void prompt(Activity activity, PasswordManager.OnMasterPasswordRetrievedListener listener) {
        final EditText txtUrl = new EditText(activity);

        new AlertDialog.Builder(activity)
            .setTitle("Please enter master password")
            .setMessage("Master password:")
            .setView(txtUrl).setCancelable(false)
            .setPositiveButton("Next", (dialog, whichButton) -> {
                String url = txtUrl.getText().toString();
                listener.onMasterPasswordRetrieved(url);
            })
            .setNegativeButton("Cancel", (dialog, whichButton) -> listener.onCancel())
            .show();
    }
}