package org.elastos.trinity.runtime.titlebar;

import android.content.Context;
import android.graphics.Color;
import android.graphics.ColorMatrixColorFilter;
import android.net.Uri;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;

import org.elastos.trinity.runtime.R;
import org.elastos.trinity.runtime.Utility;


public class TitleBarIconView extends FrameLayout {
    ImageButton ivMainIcon;
    ImageView ivBadge;

    public TitleBarIconView(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onFinishInflate() {
        super.onFinishInflate();

        LayoutInflater inflater = LayoutInflater.from(getContext());
        inflater.inflate(R.layout.title_bar_icon_view, this, true);

        ivMainIcon = findViewById(R.id.ivMainIcon);
        ivBadge = findViewById(R.id.ivBadge);

        setBadgeCount(0);
    }

    public void setPaddingDp(int dpPadding) {
        int paddingPx = (int) Utility.convertDpToPx(getContext(), dpPadding);
        ivMainIcon.setPadding(paddingPx, paddingPx, paddingPx, paddingPx);
    }

    public void setImageResource(int resId) {
        ivMainIcon.setImageResource(resId);
    }

    public void setImageURI(Uri uri) {
        ivMainIcon.setImageURI(uri);
    }

    public void setColorFilter(int color) {
        ivMainIcon.setColorFilter(color);
    }

    public void setColorFilter(ColorMatrixColorFilter filter) {
        ivMainIcon.setColorFilter(filter);
    }

    public void setOnClickListener(OnClickListener listener) {
        ivMainIcon.setOnClickListener(listener);
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
