package org.elastos.trinity.runtime.passwordmanager.dialogs;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.widget.EditText;

public class MasterPasswordCreator {
    public interface OnMasterPasswordCreatorListener {
        void onMasterPasswordCreated(String password);
        void onCancel();
        void onDontUseMasterPassword();
    }

    public void promptMasterPassword(Activity activity, OnMasterPasswordCreatorListener listener) {
        final EditText txtUrl = new EditText(activity);

        new AlertDialog.Builder(activity)
            .setTitle("Please create a master password")
            .setMessage("Master password:")
            .setView(txtUrl).setCancelable(false)
            .setPositiveButton("Done", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {
                    String password = txtUrl.getText().toString();
                    listener.onMasterPasswordCreated(password);
                }
            }).setNeutralButton("Don't use master", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    listener.onDontUseMasterPassword();
                }
            }).setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                public void onClick(DialogInterface dialog, int whichButton) {
                    listener.onCancel();
                }
            })
            .show();
    }
}