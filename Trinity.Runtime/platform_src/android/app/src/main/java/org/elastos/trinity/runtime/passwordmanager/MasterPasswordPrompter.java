package org.elastos.trinity.runtime.passwordmanager;

import android.app.Activity;
import android.content.DialogInterface;
import android.widget.EditText;

import androidx.appcompat.app.AlertDialog;

class MasterPasswordPrompter {
    public void prompt(Activity activity, PasswordManager.OnMasterPasswordRetrievedListener listener) {
        final EditText txtUrl = new EditText(activity);

        new AlertDialog.Builder(activity)
            .setTitle("Please enter master password")
            .setMessage("Master password:")
            .setView(txtUrl).setCancelable(false)
            .setPositiveButton("Moustachify", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {
                    String url = txtUrl.getText().toString();
                    listener.onMasterPasswordRetrieved(url);
                }
            })
            .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {
                    listener.onCancel();
                }
            })
            .show();
    }
}