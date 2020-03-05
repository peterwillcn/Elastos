/*
* Copyright (c) 2018-2020 Elastos Foundation
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

/**
* This plugin allows dApps to communicate with the global native title bar embedded in all elastOS dApps.
* DApps can change the title background color, set a title, customize action icons and more.
* <br><br>
* Usage:
* <br>
* declare let titleBarManager: TitleBarPlugin.TitleBarManager;
*/

declare namespace TitleBarPlugin {
    /**
     * Type of activity indicators that the title bar can display.
     * Activity indicators are icon animations showing that something is currently busy.
     */
   const enum TitleBarActivityType {
        /** There is an on going download. */
        DOWNLOAD = 0,
        /** There is an on going upload. */
        UPLOAD = 1,
        /** There is on going application launch. */
        LAUNCH = 2,
        /** There is another on going operation of an indeterminate type. */
        OTHER = 3
    }

    const enum TitleBarForegroundMode {
        /** Title bar title and icons use a light (white) color. Use this on a dark background color. */
        LIGHT = 0,
        /** Title bar title and icons use a dark (dark gray) color. Use this on a light background color. */
        DARK = 1
    }

    interface TitleBarManager {
        /**
         * Shows an indicator on the title bar to indicate that something is busy.
         * Several dApps can interact with an activity indicator at the same time. As long as there
         * is at least one dApp setting an indicator active, that indicator remains shown.
         * 
         * @param type Type of activity indicator to start showing.
         */
        showActivityIndicator(type: TitleBarActivityType);

        /**
         * Requests to hide a given activity indicator. In case other dApps are still busy using
         * this indicator, the activity indicator remains active, until the last dApp releases it.
         * 
         * @param type Type of activity indicator to stop showing for the active dApp.
         */
        hideActivityIndicator(type: TitleBarActivityType);

        /**
         * Sets the main title bar title information. Pass null to clear the previous title.
         * DApps are responsible for managing this title from their internal screens.
         * 
         * @param title Main title to show on the title bar.
         */
        setTitle(title: String);

        /**
         * Sets the status bar background color.
         * 
         * @param hexColor Hex color code with format "#RRGGBB"
         */
        setBackgroundColor(hexColor: String);

        /**
         * Sets the title bar foreground (title, icons) color. Use this API in coordination with 
         * setBackgroundColor() in order to adjust foreground with background.
         * 
         * @param mode A TitleBarForegroundMode mode, LIGHT or DARK.
         */
        setForegroundMode(mode: TitleBarForegroundMode);
    }
}