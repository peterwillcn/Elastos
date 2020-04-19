package org.elastos.trinity.runtime;

import android.app.AlertDialog;
import android.content.Context;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.cardview.widget.CardView;

public class ApiAuthorityDialog extends AlertDialog {
    public interface OnDenyClickedListener {
        void onDenyClicked();
    }

    public interface OnAcceptClickedListener {
        void onAcceptClicked();
    }

    public static class Builder {
        private Context context;
        private AlertDialog.Builder alertDialogBuilder;
        private AlertDialog alertDialog;
        private ApiAuthorityManager.ApiAuthorityInfo authInfo;
        private AppInfo appInfo;
        private String plugin;
        private String api;
        private OnDenyClickedListener onDenyClickedListener;
        private OnAcceptClickedListener onAcceptClickedListener;

        public Builder(Context context) {
            this.context = context;
            alertDialogBuilder = new android.app.AlertDialog.Builder(context);

            alertDialogBuilder.setCancelable(false);
        }

        Builder setData(ApiAuthorityManager.ApiAuthorityInfo authInfo, AppInfo appInfo, String plugin, String api) {
            this.authInfo = authInfo;
            this.appInfo = appInfo;
            this.plugin = plugin;
            this.api = api;

            return this;
        }

        Builder setOnDenyClickedListener(OnDenyClickedListener listener) {
            this.onDenyClickedListener = listener;
            return this;
        }

        Builder setOnAcceptClickedListener(OnAcceptClickedListener listener) {
            this.onAcceptClickedListener = listener;
            return this;
        }

        public void show() {
            View view = LayoutInflater.from(context).inflate(R.layout.api_alert_authority,null);

            // Hook UI items
            LinearLayout llRoot = view.findViewById(R.id.llRoot);
            LinearLayout llMainContent = view.findViewById(R.id.llMainContent);
            ImageView ivAppIcon = view.findViewById(R.id.ivAppIcon);
            TextView lblAppName = view.findViewById(R.id.lblAppName);
            TextView lblTitle = view.findViewById(R.id.lblTitle);
            TextView lblFeatureTitle = view.findViewById(R.id.lblFeatureTitle);
            TextView lblFeatureValue = view.findViewById(R.id.lblFeatureValue);
            TextView lblDescriptionTitle = view.findViewById(R.id.lblDescriptionTitle);
            TextView lblDescriptionValue = view.findViewById(R.id.lblDescriptionValue);
            ImageView ivRisk = view.findViewById(R.id.ivRisk);
            TextView lblRisk = view.findViewById(R.id.lblRisk);
            Button btDeny = view.findViewById(R.id.btDeny);
            Button btAccept = view.findViewById(R.id.btAccept);
            CardView cardDeny = view.findViewById(R.id.cardDeny);
            CardView cardAccept = view.findViewById(R.id.cardAccept);

            // Customize colors
            llRoot.setBackgroundColor(UIStyling.popupMainBackgroundColor);
            llMainContent.setBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            lblAppName.setTextColor(UIStyling.popupMainTextColor);
            lblTitle.setTextColor(UIStyling.popupMainTextColor);
            lblFeatureTitle.setTextColor(UIStyling.popupMainTextColor);
            lblFeatureValue.setTextColor(UIStyling.popupMainTextColor);
            lblDescriptionTitle.setTextColor(UIStyling.popupMainTextColor);
            lblDescriptionValue.setTextColor(UIStyling.popupMainTextColor);
            lblRisk.setTextColor(UIStyling.popupMainTextColor);
            cardDeny.setCardBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            btDeny.setTextColor(UIStyling.popupMainTextColor);
            cardAccept.setCardBackgroundColor(UIStyling.popupSecondaryBackgroundColor);
            btAccept.setTextColor(UIStyling.popupMainTextColor);

            // Apply data
            lblAppName.setText(appInfo.name);
            lblTitle.setText("This capsule is requesting access to a sensitive feature");
            lblFeatureValue.setText(authInfo.getLocalizedTitle());
            lblDescriptionValue.setText(authInfo.getLocalizedDescription());

            if (authInfo.dangerLevel.equals(ApiAuthorityManager.DANGER_LEVEL_LOW)) {
                ivRisk.setImageResource(R.drawable.ic_risk_green);
                lblRisk.setText("Low Risk");
            }
            else if (authInfo.dangerLevel.equals(ApiAuthorityManager.DANGER_LEVEL_HIGH)) {
                ivRisk.setImageResource(R.drawable.ic_risk_red);
                lblRisk.setText("Potentially Harmful");
            } else {
                ivRisk.setImageResource(R.drawable.ic_risk_yellow);
                lblRisk.setText("Average Risk");
            }

            String[] iconPaths = AppManager.getShareInstance().getIconPaths(appInfo);
            if (iconPaths.length > 0) {
                String appIconPath = iconPaths[0];
                ivAppIcon.setImageURI(Uri.parse(appIconPath));
            }

            btDeny.setOnClickListener(v -> {
                alertDialog.dismiss();
                onDenyClickedListener.onDenyClicked();
            });

            btAccept.setOnClickListener(v -> {
                alertDialog.dismiss();
                onAcceptClickedListener.onAcceptClicked();
            });

            alertDialogBuilder.setView(view);
            alertDialog = alertDialogBuilder.create();
            alertDialog.show();
        }
    }

    protected ApiAuthorityDialog(Context context, int themeResId) {
        super(context, themeResId);
    }
}
