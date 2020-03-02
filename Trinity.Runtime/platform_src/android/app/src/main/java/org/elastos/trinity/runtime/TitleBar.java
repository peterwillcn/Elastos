package org.elastos.trinity.runtime;

import android.content.Context;
import androidx.appcompat.widget.Toolbar;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ProgressBar;

public class TitleBar extends Toolbar {
    ProgressBar progressBar;
    ImageButton btnClose = null;
    ImageButton btnLauncher = null;
    ImageButton btnToggle = null;

    boolean isLauncher = false;
    AppManager appManager = null;
    public TitleBar(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public void initialize(String appId) {
        appManager = AppManager.getShareInstance();
        isLauncher = appManager.isLauncher(appId);

        progressBar = findViewById(R.id.progressBar);
        btnClose = findViewById(R.id.btnClose);
        btnLauncher = findViewById(R.id.btnLauncher);
        btnToggle = findViewById(R.id.btnToggle);
        //        this.setTitle("Title");
        //        this.setSubtitle("SubTitle");
        //this.setLogo(R.mipmap.icon);

        btnClose.setOnClickListener(new ImageButton.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    appManager.close(appId);
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        btnLauncher.setOnClickListener(new ImageButton.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    appManager.loadLauncher();
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        btnToggle.setOnClickListener(new ImageButton.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    appManager.sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL, "{\"action\":\"toggle\"}", "system");
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        if (isLauncher) {
            btnClose.setVisibility(View.GONE);
            btnLauncher.setVisibility(View.GONE);
        }
        else {
            btnToggle.setVisibility(View.GONE);
        }

        hideProgress();
    }

    /**
     * Shows the progress bar in this title bar
     */
    public void showProgress() {
        progressBar.setVisibility(View.VISIBLE);
    }

    /**
     * Hides the progress bar from this title bar
     */
    public void hideProgress() {
        // TODO: For now if setting visibility to INVISIBLE, setting it to VISIBLE later doesn't work any more.
        // We will change the  progress bar soon any way so just set progress to 0 for now.
        progressBar.setProgress(0);
    }

    protected void setProgress(int progress) {
        showProgress();
        progressBar.setProgress(progress);
    }
}
