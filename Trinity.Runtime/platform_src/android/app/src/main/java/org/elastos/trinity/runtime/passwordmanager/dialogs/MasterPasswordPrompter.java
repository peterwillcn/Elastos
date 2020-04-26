package org.elastos.trinity.runtime.passwordmanager.dialogs;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.cardview.widget.CardView;

import org.elastos.trinity.runtime.R;
import org.elastos.trinity.runtime.UIStyling;

public class MasterPasswordPrompter extends AlertDialog {
    public interface OnCancelClickedListener {
        void onCancelClicked();
    }

    public interface OnNextClickedListener {
        void onNextClicked(String password);
    }

    public interface OnErrorListener {
        void onError(String error);
    }

    public static class Builder {
        private Context context;
        private AlertDialog.Builder alertDialogBuilder;
        private AlertDialog alertDialog;
        private OnCancelClickedListener onCancelClickedListener;
        private OnNextClickedListener onNextClickedListener;
        private OnErrorListener onErrorListener;

        public Builder(Context context) {
            this.context = context;
            alertDialogBuilder = new android.app.AlertDialog.Builder(context);

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
            View view = LayoutInflater.from(context).inflate(R.layout.dialog_password_manager_prompt, null);

            // Hook UI items
            LinearLayout llRoot = view.findViewById(R.id.llRoot);
            LinearLayout llMainContent = view.findViewById(R.id.llMainContent);
            TextView lblTitle = view.findViewById(R.id.lblTitle);
            TextView lblWrongPassword = view.findViewById(R.id.lblWrongPassword);
            EditText etPassword = view.findViewById(R.id.etPassword);
            Button btCancel = view.findViewById(R.id.btCancel);
            Button btNext = view.findViewById(R.id.btNext);
            CardView cardDeny = view.findViewById(R.id.cardDeny);
            CardView cardAccept = view.findViewById(R.id.cardAccept);

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

                // Only allow validating the popup if some password is set
                if (password != null && !password.equals("")) {
                    alertDialog.dismiss();
                    onNextClickedListener.onNextClicked(password);
                }
            });

            alertDialogBuilder.setView(view);
            alertDialog = alertDialogBuilder.create();
            alertDialog.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);
            alertDialog.show();
        }
    }

    protected MasterPasswordPrompter(Context context, int themeResId) {
        super(context, themeResId);
    }
}