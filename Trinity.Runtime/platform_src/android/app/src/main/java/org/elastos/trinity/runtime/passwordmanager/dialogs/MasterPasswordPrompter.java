package org.elastos.trinity.runtime.passwordmanager.dialogs;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
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

import androidx.biometric.BiometricManager;
import androidx.cardview.widget.CardView;

import org.elastos.trinity.plugins.fingerprint.FingerPrintAuthHelper;
import org.elastos.trinity.runtime.R;
import org.elastos.trinity.runtime.UIStyling;
import org.elastos.trinity.runtime.passwordmanager.PasswordManager;

public class MasterPasswordPrompter extends AlertDialog {
    public interface OnCancelClickedListener {
        void onCancelClicked();
    }

    public interface OnNextClickedListener {
        void onNextClicked(String password, boolean shouldSavePasswordToBiometric);
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
        private OnErrorListener onErrorListener;
        private boolean shouldInitiateBiometry; // Whether biometry should be prompted to save password, or just used (previously saved)

        // UI items
        LinearLayout llRoot;
        LinearLayout llMainContent;
        TextView lblTitle;
        TextView lblWrongPassword;
        EditText etPassword;
        Button btCancel;
        Button btNext;
        CardView cardDeny;
        CardView cardAccept;
        Switch swBiometric;
        LinearLayout llBiometric;
        TextView lblBiometricIntro;

        public Builder(Activity activity, PasswordManager passwordManager) {
            this.activity = activity;
            this.passwordManager = passwordManager;
            alertDialogBuilder = new android.app.AlertDialog.Builder(activity);

            alertDialogBuilder.setCancelable(false);
        }

       /* Builder setData(ApiAuthorityManager.ApiAuthorityInfo authInfo, AppInfo appInfo, String plugin, String api) {
            this.authInfo = authInfo;
            this.appInfo = appInfo;
            this.plugin = plugin;
            this.api = api;

            return this;
        }*/

        public Builder setOnCancelClickedListener(OnCancelClickedListener listener) {
            this.onCancelClickedListener = listener;
            return this;
        }

        public Builder setOnNextClickedListener(OnNextClickedListener listener) {
            this.onNextClickedListener = listener;
            return this;
        }

        public Builder setOnErrorListener(OnErrorListener listener) {
            this.onErrorListener = listener;
            return this;
        }

        public void prompt(boolean passwordWasWrong) {
            View view = LayoutInflater.from(activity).inflate(R.layout.dialog_password_manager_prompt, null);

            // Hook UI items
            llRoot = view.findViewById(R.id.llRoot);
            llMainContent = view.findViewById(R.id.llMainContent);
            lblTitle = view.findViewById(R.id.lblTitle);
            lblWrongPassword = view.findViewById(R.id.lblWrongPassword);
            etPassword = view.findViewById(R.id.etPassword);
            btCancel = view.findViewById(R.id.btCancel);
            btNext = view.findViewById(R.id.btNext);
            cardDeny = view.findViewById(R.id.cardDeny);
            cardAccept = view.findViewById(R.id.cardAccept);
            swBiometric = view.findViewById(R.id.swBiometric);
            llBiometric = view.findViewById(R.id.llBiometricInitiate);
            lblBiometricIntro = view.findViewById(R.id.lblBiometricIntro);

            // Customize colors
            llRoot.setBackgroundColor(UIStyling.popupMainBackgroundColor);
            llMainContent.setBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            lblTitle.setTextColor(UIStyling.popupMainTextColor);
            cardDeny.setCardBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            btCancel.setTextColor(UIStyling.popupMainTextColor);
            cardAccept.setCardBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            btNext.setTextColor(UIStyling.popupMainTextColor);

            if (passwordWasWrong)
                lblWrongPassword.setVisibility(View.VISIBLE);
            else
                lblWrongPassword.setVisibility(View.GONE);

            btCancel.setOnClickListener(v -> {
                alertDialog.dismiss();
                onCancelClickedListener.onCancelClicked();
            });

            btNext.setOnClickListener(v -> {
                String password = etPassword.getText().toString();

                // Disable biometric auth for next times if user doesn't want to use that any more
                if (!swBiometric.isChecked()) {
                    passwordManager.setBiometricAuthEnabled(false);
                }

                boolean shouldSaveToBiometric = shouldInitiateBiometry && swBiometric.isChecked();
                if (swBiometric.isChecked() && !shouldInitiateBiometry) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        FingerPrintAuthHelper fingerPrintAuthHelper = new FingerPrintAuthHelper(activity, PasswordManager.FAKE_PASSWORD_MANAGER_PLUGIN_APP_ID);
                        fingerPrintAuthHelper.init();
                        activity.runOnUiThread(() -> {
                            fingerPrintAuthHelper.authenticateAndGetPassword(PasswordManager.MASTER_PASSWORD_BIOMETRIC_KEY, new CancellationSignal(), new FingerPrintAuthHelper.GetPasswordAuthenticationCallback() {
                                @Override
                                public void onSuccess(String password) {
                                    alertDialog.dismiss();
                                    onNextClickedListener.onNextClicked(password, shouldSaveToBiometric);
                                }

                                @Override
                                public void onFailure(String message) {
                                    alertDialog.dismiss();
                                    onErrorListener.onError(message);
                                }

                                @Override
                                public void onHelp(int helpCode, String helpString) {
                                    // Not implemented
                                }
                            });
                        });

                    }
                }
                else {
                    // Only allow validating the popup if some password is set
                    if (!password.equals("")) {
                        alertDialog.dismiss();
                        onNextClickedListener.onNextClicked(password, shouldSaveToBiometric);
                    }
                }
            });

            swBiometric.setChecked(passwordManager.isBiometricAuthEnabled());

            // If biometric auth is not enabled, we will follow the flow to initiate it during this prompter session.
            shouldInitiateBiometry = !passwordManager.isBiometricAuthEnabled();

            if (canUseBiometrictAuth()) {
                if (shouldInitiateBiometry) {
                    setTextPasswordVisible(true);
                    setBiometryLayoutVisible(false);
                }
                else {
                    setTextPasswordVisible(false);
                    setBiometryLayoutVisible(true);
                    updateBiometryIntroText();
                }

                swBiometric.setOnCheckedChangeListener((compoundButton, checked) -> {
                    if (checked) {
                        // Willing to enable biometric auth?
                        setBiometryLayoutVisible(false);
                        updateBiometryIntroText();
                    }
                    else {
                        // Willing to disable biometric auth?
                        shouldInitiateBiometry = true;
                        setBiometryLayoutVisible(false);
                        setTextPasswordVisible(true);

                        // Focus the password input
                        alertDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
                        etPassword.requestFocus();
                    }
                });
            }
            else {
                // No biometric auth mechanism available - hide the feature
                llBiometric.setVisibility(View.GONE);
                swBiometric.setVisibility(View.GONE);
            }

            alertDialogBuilder.setView(view);
            alertDialog = alertDialogBuilder.create();
            alertDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
            alertDialog.show();
        }

        private void setTextPasswordVisible(boolean shouldShow) {
            if (shouldShow)
                etPassword.setVisibility(View.VISIBLE);
            else
                etPassword.setVisibility(View.GONE);
        }

        private void setBiometryLayoutVisible(boolean shouldShow) {
            if (shouldShow)
                llBiometric.setVisibility(View.VISIBLE);
            else
                llBiometric.setVisibility(View.GONE);
        }

        private void updateBiometryIntroText() {
            lblBiometricIntro.setText("Continue to authenticate using fingerprint or face recognition");
        }

        private boolean canUseBiometrictAuth() {
            BiometricManager biometricManager = BiometricManager.from(activity.getApplicationContext());
            switch (biometricManager.canAuthenticate()) {
                case BiometricManager.BIOMETRIC_SUCCESS:
                    return true;
                case BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE:
                case BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE:
                case BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED:
                default:
                    return false;
            }
        }
    }


    protected MasterPasswordPrompter(Context context, int themeResId) {
        super(context, themeResId);
    }
}