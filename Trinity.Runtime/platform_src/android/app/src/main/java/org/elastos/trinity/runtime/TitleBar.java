package org.elastos.trinity.runtime;

import android.app.Activity;
import android.content.Context;

import android.graphics.Color;
import android.os.Handler;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.TextView;

import java.util.HashMap;


public class TitleBar extends FrameLayout {
    public enum TitleBarActivityType {
        /** There is an on going download. */
        DOWNLOAD(0),
        /** There is an on going upload. */
        UPLOAD(1),
        /** There is on going application launch. */
        LAUNCH(2),
        /** There is another on going operation of an indeterminate type. */
        OTHER(3);

        private int mValue;

        TitleBarActivityType(int value) {
            mValue = value;
        }

        public static TitleBarActivityType fromId(int value) {
            for(TitleBarActivityType t : values()) {
                if (t.mValue == value) {
                    return t;
                }
            }
            return OTHER;
        }
    }

    public enum TitleBarForegroundMode {
        LIGHT(0),
        DARK(1);

        private int mValue;

        TitleBarForegroundMode(int value) {
            mValue = value;
        }

        public static TitleBarForegroundMode fromId(int value) {
            for(TitleBarForegroundMode t : values()) {
                if (t.mValue == value) {
                    return t;
                }
            }
            return LIGHT;
        }
    }

    public enum TitleBarNavigationMode {
        HOME(0),
        CLOSE(1),
        BACK(2);

        private int mValue;

        TitleBarNavigationMode(int value) {
            mValue = value;
        }

        public static TitleBarNavigationMode fromId(int value) {
            for(TitleBarNavigationMode t : values()) {
                if (t.mValue == value) {
                    return t;
                }
            }
            return CLOSE;
        }
    }

    // UI
    View progressBar;
    ImageButton btnLauncher = null;
    ImageButton btnBack = null;
    ImageButton btnClose = null;
    ImageButton btnMenu = null;
    TextView tvTitle = null;
    FrameLayout flRoot = null;

    // UI model
    AlphaAnimation onGoingProgressAnimation = null;

    // Model
    String appId = null;
    boolean isLauncher = false;
    AppManager appManager = null;
    // Reference count for progress bar activity types. An app can start several activities at the same time and the progress bar
    // keeps animating until no one else needs progress animations.
    HashMap<TitleBarActivityType, Integer> activityCounters = new HashMap<TitleBarActivityType, Integer>();

    public TitleBar(Context context, AttributeSet attrs) {
        super(context, attrs);

        activityCounters.put(TitleBarActivityType.DOWNLOAD, 0);
        activityCounters.put(TitleBarActivityType.UPLOAD, 0);
        activityCounters.put(TitleBarActivityType.LAUNCH, 0);
        activityCounters.put(TitleBarActivityType.OTHER, 0);
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();

        LayoutInflater inflater = LayoutInflater.from(getContext());
        inflater.inflate(R.layout.title_bar, this, true);
    }

    public void initialize(String appId) {
        this.appId = appId;
        appManager = AppManager.getShareInstance();
        isLauncher = appManager.isLauncher(appId);

        progressBar = findViewById(R.id.progressBar);
        btnLauncher = findViewById(R.id.btnLauncher);
        btnBack = findViewById(R.id.btnBack);
        btnClose = findViewById(R.id.btnClose);
        btnMenu = findViewById(R.id.btnMenu);
        tvTitle = findViewById(R.id.tvTitle);
        flRoot = findViewById(R.id.flRoot);

        btnClose.setOnClickListener(v -> {
            try {
                appManager.close(appId);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        });

        btnMenu.setOnClickListener(v -> {
            try {
                // Go back to launcher if in an app, and ask to show the menu panel
                if (!isLauncher) {
                    appManager.loadLauncher();
                    appManager.sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL, "menu-show", this.appId);
                }
                else {
                    // If we are in the launcher, toggle the menu visibility
                    appManager.sendLauncherMessage(AppManager.MSG_TYPE_INTERNAL, "menu-toggle", this.appId);
                }
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        });

        if (isLauncher) {
            btnClose.setVisibility(View.INVISIBLE);
        }

        setForegroundMode(TitleBarForegroundMode.LIGHT);
        setNavigationMode(TitleBarNavigationMode.CLOSE);
    }

    public void showActivityIndicator(TitleBarActivityType activityType) {
        ((Activity) getContext()).runOnUiThread(() -> {
            // Increase reference count for this progress animation type
            activityCounters.put(activityType, activityCounters.get(activityType) + 1);
            updateAnimation();
        });
    }

    public void hideActivityIndicator(TitleBarActivityType activityType) {
        ((Activity) getContext()).runOnUiThread(() -> {
            // Decrease reference count for this progress animation type
            activityCounters.put(activityType, Math.max(0, activityCounters.get(activityType) - 1));
            updateAnimation();
        });
    }

    public void setTitle(String title) {
        tvTitle.setText(title);
    }

    public boolean setBackgroundColor(String hexColor) {
        try {
            flRoot.setBackgroundColor(Color.parseColor(hexColor));
            return true;
        }
        catch (Exception e) {
            // Wrong color format?
            return false;
        }
    }

    public void setForegroundMode(TitleBarForegroundMode mode) {
        int color;

        if (mode == TitleBarForegroundMode.DARK) {
            color = Color.parseColor("#444444");
        }
        else {
            color = Color.parseColor("#FFFFFF");
        }

        btnClose.setColorFilter(color);
        tvTitle.setTextColor(color);
        btnMenu.setColorFilter(color);
    }

    public void setNavigationMode(TitleBarNavigationMode navigationMode) {
        if (navigationMode == TitleBarNavigationMode.HOME) {
            btnClose.setVisibility(View.INVISIBLE);
            btnBack.setVisibility(View.INVISIBLE);
            btnLauncher.setVisibility(View.VISIBLE);
        }
        else if (navigationMode == TitleBarNavigationMode.BACK) {
            btnClose.setVisibility(View.INVISIBLE);
            btnBack.setVisibility(View.VISIBLE);
            btnLauncher.setVisibility(View.INVISIBLE);
        }
        else {
            // Default = CLOSE
            btnClose.setVisibility(View.VISIBLE);
            btnBack.setVisibility(View.INVISIBLE);
            btnLauncher.setVisibility(View.INVISIBLE);
        }
    }

    public void setupMenuItems() {

    }

    /**
     * Based on the counters for each activity, determines which activity type has the priority and plays the appropriate animation.
     * If no more animation, the animation is stopped
     */
    private void updateAnimation() {
        // Check if an animation should be launched, and which one
        String backgroundColor = null;
        if (activityCounters.get(TitleBarActivityType.LAUNCH) > 0) {
            backgroundColor = "#FFFFFF";
        }
        else if (activityCounters.get(TitleBarActivityType.DOWNLOAD) > 0 || activityCounters.get(TitleBarActivityType.UPLOAD) > 0) {
            backgroundColor = "#ffde6e";
        }
        else if (activityCounters.get(TitleBarActivityType.OTHER) > 0) {
            backgroundColor = "#20e3d2";
        }

        if (backgroundColor != null) {
            final String bgColor = backgroundColor;
            // Animation init delay/context switch seems to be needed otherwise changing visibility or background color of the progress bar blocks the UI.
            // Unclear reason for now.
            new Handler().postDelayed(() -> {
                ((Activity) getContext()).runOnUiThread(() -> {
                    progressBar.setVisibility(View.VISIBLE);
                    progressBar.setBackgroundColor(Color.parseColor(bgColor));

                    // If an animation is already in progress, don't interrupt it and just change the background color instead.
                    // Otherwise, start an animation
                    if (onGoingProgressAnimation == null) {
                        animateProgressBarIn();
                    }
                });
            }, 100);
        }
        else {
            // Animation init delay/context switch seems to be needed otherwise changing visibility or background color of the progress bar blocks the UI.
            // Unclear reason for now.
            new Handler().postDelayed(() -> {
                ((Activity) getContext()).runOnUiThread(() -> {
                    stopProgressAnimation();
                    progressBar.setVisibility(View.INVISIBLE);
                });
            }, 100);
        }
    }

    private void animateProgressBarIn() {
        onGoingProgressAnimation = new AlphaAnimation(0.0f , 1.0f) ;

        onGoingProgressAnimation.setDuration(1000);
        onGoingProgressAnimation.setStartOffset(300);
        onGoingProgressAnimation.setFillAfter(false);
        onGoingProgressAnimation.setAnimationListener(new Animation.AnimationListener() {
            @Override
            public void onAnimationStart(Animation animation) {

            }

            @Override
            public void onAnimationEnd(Animation animation) {
                onGoingProgressAnimation = null;
                animateProgressBarOut();
            }

            @Override
            public void onAnimationRepeat(Animation animation) {

            }
        });

        progressBar.startAnimation(onGoingProgressAnimation);
    }

    private void animateProgressBarOut() {
        onGoingProgressAnimation = new AlphaAnimation( 1.0f , 0.0f ) ;

        onGoingProgressAnimation.setDuration(1000);
        onGoingProgressAnimation.setFillAfter(false);
        onGoingProgressAnimation.setAnimationListener(new Animation.AnimationListener() {
            @Override
            public void onAnimationStart(Animation animation) {
            }

            @Override
            public void onAnimationEnd(Animation animation) {
                onGoingProgressAnimation = null;
                animateProgressBarIn();
            }

            @Override
            public void onAnimationRepeat(Animation animation) {

            }
        });

        progressBar.startAnimation(onGoingProgressAnimation);
    }

    private void stopProgressAnimation() {
        if (onGoingProgressAnimation != null) {
            progressBar.clearAnimation();
            progressBar.animate().cancel();
            onGoingProgressAnimation.cancel();
            onGoingProgressAnimation = null;
        }
    }
}
