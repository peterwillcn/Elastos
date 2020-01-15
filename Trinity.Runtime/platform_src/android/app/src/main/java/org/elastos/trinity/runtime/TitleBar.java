package org.elastos.trinity.runtime;

import android.content.Context;
import android.support.v7.widget.Toolbar;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ProgressBar;

public class TitleBar extends Toolbar {
    ImageButton btnClose = null;
    ImageButton btnLauncher = null;
    ImageButton btnToggle = null;

    boolean isLauncher = false;
    AppManager appManager = null;
    public TitleBar(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    public void setInit(String id) {
        appManager = AppManager.getShareInstance();
        isLauncher = appManager.isLauncher(id);

        btnClose = findViewById(R.id.btnClose);
        btnLauncher = findViewById(R.id.btnLauncher);
        btnToggle = findViewById(R.id.btnToggle);
        //        this.setTitle("Title");
//        this.setSubtitle("SubTitle");
        this.setLogo(R.mipmap.icon);

        btnClose.setOnClickListener(new ImageButton.OnClickListener() {
            @Override
            public void onClick(View v) {
                try {
                    appManager.close(id);
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
                    appManager.sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL, "toggle", "system");
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

        setProgress(0);
    }

    protected void setProgress(int progress) {
        ProgressBar progressBar = findViewById(R.id.progressBar);
        progressBar.setProgress(progress);
    }

}
