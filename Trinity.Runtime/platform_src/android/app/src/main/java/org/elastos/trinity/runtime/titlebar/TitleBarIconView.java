package org.elastos.trinity.runtime.titlebar;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.ColorMatrix;
import android.graphics.ColorMatrixColorFilter;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Handler;
import android.util.AttributeSet;
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

import org.elastos.trinity.runtime.AppInfo;
import org.elastos.trinity.runtime.AppManager;
import org.elastos.trinity.runtime.R;

import java.util.ArrayList;
import java.util.HashMap;


public class TitleBarIconView extends FrameLayout {
    ImageButton ivIcon;
    ImageView ivBadge;

    public TitleBarIconView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();

        LayoutInflater inflater = LayoutInflater.from(getContext());
        inflater.inflate(R.layout.title_bar_icon_view, this, true);

        ivIcon = findViewById(R.id.ivIcon);
        ivBadge = findViewById(R.id.ivBadge);

        setBadgeCount(0);
    }

    public void setImageResource(int resId) {
        ivIcon.setImageResource(resId);
    }

    public void setImageURI(Uri uri) {
        ivIcon.setImageURI(uri);
    }

    public void setColorFilter(int color) {
        ivIcon.setColorFilter(color);
    }

    public void setOnClickListener(OnClickListener listener) {
        ivIcon.setOnClickListener(listener);
    }

    /**
     * For now, just a on/off toggle, no real count used.
     */
    public void setBadgeCount(int count) {
        if (count == 0)
            ivBadge.setVisibility(View.GONE);
        else
            ivBadge.setVisibility(View.VISIBLE);
    }
}
