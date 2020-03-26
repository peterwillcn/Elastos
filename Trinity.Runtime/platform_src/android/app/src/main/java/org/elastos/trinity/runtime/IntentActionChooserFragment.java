package org.elastos.trinity.runtime;

import android.annotation.SuppressLint;
import android.app.DialogFragment;
import android.net.Uri;
import android.os.Bundle;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.io.File;
import java.util.ArrayList;

@SuppressLint("ValidFragment")
public class IntentActionChooserFragment extends DialogFragment {
    private AppManager appManager;
    private ArrayList<AppInfo> appInfos;
    private OnAppChosenListener listener = null;
    private OnNativeShareListener nativeShareListener = null;
    private IntentManager.ShareIntentParams shareIntentParams = null;

    public IntentActionChooserFragment(AppManager appManager, ArrayList<AppInfo> appInfos) {
        this.appManager = appManager;
        this.appInfos = appInfos;
    }

    public void setListener(OnAppChosenListener listener) {
        this.listener = listener;
    }

    public void setNativeShareListener(OnNativeShareListener listener) {
        this.nativeShareListener = listener;
    }

    public void useNativeShare(IntentManager.ShareIntentParams shareIntentParams) {
        if (shareIntentParams == null) {
            return;
        }

        this.shareIntentParams = shareIntentParams;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_intent_action_chooser, container);

        // Apps list
        RecyclerView rvApps = rootView.findViewById(R.id.rvApps);
        RecyclerView.LayoutManager layoutManager = new LinearLayoutManager(getActivity());
        rvApps.setLayoutManager(layoutManager);
        rvApps.setAdapter(new AppsListAdapter(appInfos, shareIntentParams, listener, nativeShareListener));

        // Cancel button
        /*rootView.findViewById(R.id.btCancel).setOnClickListener(view -> {
            // Cancelling - close the popup.
            IntentActionChooserFragment.this.dismiss();
        });*/

        return rootView;
    }

    /**
     * Listener for apps selection
     */
    public interface OnAppChosenListener {
        void onAppChosen(AppInfo appInfo);
    }

    /**
     * Listener for native share action selection
     */
    public interface OnNativeShareListener {
        void onNativeShare();
    }

    /**
     * Apps list adapter
     */
    public class AppsListAdapter extends RecyclerView.Adapter<AppsListAdapter.ViewHolder> {
        private ArrayList<AppInfo> appInfos;
        private IntentManager.ShareIntentParams shareIntentParams;
        private OnAppChosenListener listener;
        private OnNativeShareListener nativeShareListener;

        class ViewHolder extends RecyclerView.ViewHolder {
            private View rootView;
            ImageView ivAppIcon;
            TextView tvAppName;

            ViewHolder(View v) {
                super(v);

                rootView = v;

                this.ivAppIcon = v.findViewById(R.id.ivAppIcon);
                this.tvAppName = v.findViewById(R.id.tvAppName);
            }
        }

        AppsListAdapter(ArrayList<AppInfo> appInfos, IntentManager.ShareIntentParams shareIntentParams, OnAppChosenListener listener, OnNativeShareListener nativeShareListener) {
            this.appInfos = appInfos;
            this.shareIntentParams = shareIntentParams;
            this.listener = listener;
            this.nativeShareListener = nativeShareListener;
        }

        @Override
        public AppsListAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.row_intent_chooser_app_info, parent, false);
            AppsListAdapter.ViewHolder vh = new AppsListAdapter.ViewHolder(v);

            return vh;
        }

        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            if (!isNativeShareItemPosition(position)) {
                AppInfo appInfo = appInfos.get(position);

                // TODO: dirty - use a method to get app icon path in a clean way.
                String[] iconPaths = appManager.getIconPaths(appInfo);
                if (iconPaths != null && iconPaths.length > 0) {
                    String appIconPath = iconPaths[0];
                    holder.ivAppIcon.setImageURI(Uri.fromFile(new File(appIconPath)));
                } else {
                    holder.ivAppIcon.setVisibility(View.INVISIBLE);
                }
                holder.tvAppName.setText(appInfo.name);

                holder.rootView.setOnClickListener(view -> {
                    listener.onAppChosen(appInfo);
                });
            }
            else {
                // Native share index
                holder.ivAppIcon.setImageResource(R.drawable.ic_android_share);
                holder.tvAppName.setText("Another app");

                holder.rootView.setOnClickListener(view -> {
                    nativeShareListener.onNativeShare();
                });
            }
        }

        @Override
        public int getItemCount() {
            return appInfos.size() + (shareIntentParams != null ? 1 : 0);
        }

        private boolean isNativeShareItemPosition(int position) {
            if (shareIntentParams == null)
                return false;
            else
                return position == appInfos.size(); // After the app infos number of items, we are on the "native share" item
        }
    }
}
