package org.elastos.trinity.runtime;

import android.app.Activity;
import android.content.Context;

import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Handler;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.Serializable;
import java.util.ArrayList;
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
        BACK(2),
        NONE(3);

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

    public static class MenuItem {
        String key;
        String iconPath;
        String title;

        MenuItem(String key, String iconPath, String title) {
            this.key = key;
            this.iconPath = iconPath;
            this.title = title;
        }

        public JSONObject toJson() throws JSONException  {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("key", key);
            jsonObject.put("iconPath", iconPath);
            jsonObject.put("title", title);
            return jsonObject;
        }
    }

    public interface OnMenuItemSelection {
        void onMenuItemSelected(MenuItem menuItem);
    }

    // UI
    View progressBar;
    ImageButton btnLauncher = null;
    ImageButton btnBack = null;
    ImageButton btnClose = null;
    ImageButton btnMenu = null;
    ImageButton btnFav = null;
    TextView tvTitle = null;
    FrameLayout flRoot = null;
    PopupWindow menuPopup = null;

    // UI model
    AlphaAnimation onGoingProgressAnimation = null;

    // Model
    String appId = null;
    boolean isLauncher = false;
    AppManager appManager = null;
    // Reference count for progress bar activity types. An app can start several activities at the same time and the progress bar
    // keeps animating until no one else needs progress animations.
    HashMap<TitleBarActivityType, Integer> activityCounters = new HashMap<TitleBarActivityType, Integer>();
    ArrayList<MenuItem> menuItems;
    OnMenuItemSelection onMenuItemSelection = null;

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
        btnFav = findViewById(R.id.btnFav);
        tvTitle = findViewById(R.id.tvTitle);
        flRoot = findViewById(R.id.flRoot);

        btnLauncher.setOnClickListener(v -> {
            goToLauncher();
        });

        btnBack.setOnClickListener(v -> {
            sendNavBackMessage();
        });

        btnClose.setOnClickListener(v -> {
            closeApp();
        });

        btnMenu.setOnClickListener(v -> {
            toggleMenu();
        });

        if (isLauncher) {
            btnClose.setVisibility(View.INVISIBLE);
        }

        btnFav.setVisibility(View.INVISIBLE); // TODO: Waiting until the favorite management is available in system settings
        btnMenu.setVisibility(View.INVISIBLE);

        setForegroundMode(TitleBarForegroundMode.LIGHT);

        if (isLauncher)
            setNavigationMode(TitleBarNavigationMode.NONE);
        else
            setNavigationMode(TitleBarNavigationMode.HOME);
    }

    private void goToLauncher() {
        try {
            if (!isLauncher) {
                appManager.loadLauncher();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void sendNavBackMessage() {
        try {
            // Send "navback" message to the active app
            appManager.sendMessage(this.appId, AppManager.MSG_TYPE_INTERNAL, "navback", this.appId);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void closeApp() {
        try {
            appManager.close(appId);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void toggleMenu() {
        if (menuPopup == null) {
            LayoutInflater inflater = LayoutInflater.from(getContext());
            View menuView = inflater.inflate(R.layout.title_bar_menu, null);
            menuPopup = new PopupWindow(menuView, RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT, true);

            menuPopup.setClippingEnabled(false);

            // Catch events to hide
            menuView.setOnClickListener(v -> {
                closeMenuPopup();
            });
            menuPopup.setOnDismissListener(() -> {
                menuPopup = null;
            });

            // Append menu items
            if (menuItems != null) {
                LinearLayout llMenuItems = menuView.findViewById(R.id.llMenuItems);
                for (MenuItem mi : menuItems) {
                    View menuItemView = inflater.inflate(R.layout.title_bar_menu_item, llMenuItems, false);
                    menuItemView.setOnClickListener(v -> {
                        closeMenuPopup();
                        onMenuItemSelection.onMenuItemSelected(mi);
                    });

                    // Setup menu item content
                    AppInfo appInfo = appManager.getAppInfo(appId);
                    appInfo.remote = 0; // TODO - DIRTY! FIND A BETTER WAY TO GET THE REAL IMAGE PATH FROM JS PATH !
                    String iconPath = appManager.getAppPath(appInfo) + mi.iconPath;

                    // Icon
                    ImageView ivIcon = menuItemView.findViewById(R.id.ivIcon);
                    ivIcon.setImageURI(Uri.parse(iconPath));

                    // Icon - grayscale effect
                    ColorMatrix matrix = new ColorMatrix();
                    matrix.setSaturation(0);

                    ColorMatrixColorFilter filter = new ColorMatrixColorFilter(matrix);
                    ivIcon.setColorFilter(filter);

                    // Title
                    ((TextView)menuItemView.findViewById(R.id.tvTitle)).setText(mi.title);

                    llMenuItems.addView(menuItemView);
                }
            }

            // Make is touchable outside
            menuPopup.setBackgroundDrawable(new BitmapDrawable());
            menuPopup.setOutsideTouchable(true);
            menuPopup.setFocusable(true);

            // Animate
            menuPopup.setAnimationStyle(R.style.TitleBarMenuAnimation);

            // Show relatively to the title bar itself, to simulate it's stuck on the right (didn't find a better way)
            menuView.measure(MeasureSpec.makeMeasureSpec(0, MeasureSpec.UNSPECIFIED), MeasureSpec.makeMeasureSpec(0, MeasureSpec.UNSPECIFIED));
            menuPopup.showAsDropDown(this, 0, 0);
        }
        else {
            closeMenuPopup();
        }
    }

    private void closeMenuPopup() {
        menuPopup.dismiss();
        menuPopup = null;
    }

    public void showActivityIndicator(TitleBarActivityType activityType) {
        // Increase reference count for this progress animation type
        activityCounters.put(activityType, activityCounters.get(activityType) + 1);
        updateAnimation();
    }

    public void hideActivityIndicator(TitleBarActivityType activityType) {
        // Decrease reference count for this progress animation type
        activityCounters.put(activityType, Math.max(0, activityCounters.get(activityType) - 1));
        updateAnimation();
    }

    public void setTitle(String title) {
        if (title != null)
            tvTitle.setText(title);
        else
            tvTitle.setText(appManager.getAppInfo(appId).name);
    }

    public boolean setBackgroundColor(String hexColor) {
        try {
            flRoot.setBackgroundColor(Color.parseColor(hexColor));
            return true;
        } catch (Exception e) {
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
        btnClose.setVisibility(View.INVISIBLE);
        btnBack.setVisibility(View.INVISIBLE);
        btnLauncher.setVisibility(View.INVISIBLE);

        if (navigationMode == TitleBarNavigationMode.HOME) {
            btnLauncher.setVisibility(View.VISIBLE);
        }
        else if (navigationMode == TitleBarNavigationMode.BACK) {
            btnBack.setVisibility(View.VISIBLE);
        }
        else if (navigationMode == TitleBarNavigationMode.CLOSE) {
            btnClose.setVisibility(View.VISIBLE);
        }
        else {
            // Default = NONE
        }
    }

    public void setupMenuItems(ArrayList<MenuItem> menuItems, OnMenuItemSelection onMenuItemSelection) {
        this.menuItems = menuItems;
        this.onMenuItemSelection = onMenuItemSelection;

        if (menuItems.size() > 0)
            btnMenu.setVisibility(View.VISIBLE);
        else
            btnMenu.setVisibility(View.INVISIBLE);
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
