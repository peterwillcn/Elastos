package org.elastos.trinity.runtime.passwordmanager.dialogs;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Build;
import android.os.CancellationSignal;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.TextView;

import androidx.cardview.widget.CardView;

import org.elastos.trinity.plugins.fingerprint.FingerPrintAuthHelper;
import org.elastos.trinity.runtime.R;
import org.elastos.trinity.runtime.UIStyling;
import org.elastos.trinity.runtime.passwordmanager.PasswordManager;

public class MasterPasswordCreator extends AlertDialog {
    public interface OnCancelClickedListener {
        void onCancelClicked();
    }

    public interface OnNextClickedListener {
        void onNextClicked(String password);
    }

    public interface OnDontUseMasterPasswordListener {
        void onDontUseMasterPassword();
    }

    public interface OnErrorListener {
        void onError(String error);
    }

    public static class Builder {
        private Activity activity;
        private PasswordManager passwordManager;
        private AlertDialog.Builder alertDialogBuilder;
        private AlertDialog alertDialog;
        private OnCancelClickedListener onCancelClickedListener;
        private OnNextClickedListener onNextClickedListener;
        private OnDontUseMasterPasswordListener onDontUseMasterPasswordListener;
        private OnErrorListener onErrorListener;
        private boolean canDisableMasterPasswordUse = true;
        private boolean shouldInitiateBiometry; // Whether biometry should be prompted to save password, or just used (previously saved)

        // UI items
        LinearLayout llRoot;
        LinearLayout llMainContent;
        TextView lblTitle;
        EditText etPassword;
        EditText etPasswordRepeat;
        TextView lblDontUseMasterPassword;
        Button btCancel;
        Button btNext;
        CardView cardDeny;
        CardView cardAccept;

        public Builder(Activity activity, PasswordManager passwordManager) {
            this.activity = activity;
            this.passwordManager = passwordManager;

            alertDialogBuilder = new android.app.AlertDialog.Builder(activity);
            alertDialogBuilder.setCancelable(false);
        }

        public Builder setOnCancelClickedListener(OnCancelClickedListener listener) {
            this.onCancelClickedListener = listener;
            return this;
        }

        public Builder setOnNextClickedListener(OnNextClickedListener listener) {
            this.onNextClickedListener = listener;
            return this;
        }

        public Builder setOnDontUseMasterPasswordListener(OnDontUseMasterPasswordListener listener) {
            this.onDontUseMasterPasswordListener = listener;
            return this;
        }

        public Builder setOnErrorListener(OnErrorListener listener) {
            this.onErrorListener = listener;
            return this;
        }

        public void prompt() {
            View view = LayoutInflater.from(activity).inflate(R.layout.dialog_password_manager_create, null);

            // Hook UI items
            llRoot = view.findViewById(R.id.llRoot);
            llMainContent = view.findViewById(R.id.llMainContent);
            lblTitle = view.findViewById(R.id.lblTitle);
            etPassword = view.findViewById(R.id.etPassword);
            etPasswordRepeat = view.findViewById(R.id.etPasswordRepeat);
            lblDontUseMasterPassword = view.findViewById(R.id.lblDontUseMasterPassword);
            btCancel = view.findViewById(R.id.btCancel);
            btNext = view.findViewById(R.id.btNext);
            cardDeny = view.findViewById(R.id.cardDeny);
            cardAccept = view.findViewById(R.id.cardAccept);

            // Customize colors
            llRoot.setBackgroundColor(UIStyling.popupMainBackgroundColor);
            llMainContent.setBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            lblTitle.setTextColor(UIStyling.popupMainTextColor);
            cardDeny.setCardBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            btCancel.setTextColor(UIStyling.popupMainTextColor);
            cardAccept.setCardBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            btNext.setTextColor(UIStyling.popupMainTextColor);
            lblDontUseMasterPassword.setTextColor(UIStyling.popupMainTextColor);

            btCancel.setOnClickListener(v -> {
                alertDialog.dismiss();
                onCancelClickedListener.onCancelClicked();
            });

            btNext.setOnClickListener(v -> {
                String password = etPassword.getText().toString();
                String passwordRepeat = etPasswordRepeat.getText().toString();

                // Only allow validating the popup if some password is set
                if (!password.equals("") && password.equals(passwordRepeat)) {
                    alertDialog.dismiss();
                    onNextClickedListener.onNextClicked(password);
                }
            });

            if (!canDisableMasterPasswordUse) {
                // In case of password change mode, we can't disable using a master password here.
                lblDontUseMasterPassword.setVisibility(View.GONE);
            }
            else {
                lblDontUseMasterPassword.setOnClickListener(v -> {
                    alertDialog.dismiss();
                    onDontUseMasterPasswordListener.onDontUseMasterPassword();
                });
            }

            alertDialogBuilder.setView(view);
            alertDialog = alertDialogBuilder.create();
            alertDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
            alertDialog.show();
        }

        public Builder setCanDisableMasterPasswordUse(boolean canDisableMasterPasswordUse) {
            this.canDisableMasterPasswordUse = canDisableMasterPasswordUse;
            return this;
        }
    }

    public MasterPasswordCreator(Context context, int themeResId) {
        super(context, themeResId);
    }
}