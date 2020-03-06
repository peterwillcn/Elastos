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

    /**
     * Color mode for all icons and texts on the title bar.
     */
    const enum TitleBarForegroundMode {
        /** Title bar title and icons use a light (white) color. Use this on a dark background color. */
        LIGHT = 0,
        /** Title bar title and icons use a dark (dark gray) color. Use this on a light background color. */
        DARK = 1
    }

    /**
     * Status for the top left icon that can switch from one mode to another.
     */
    const enum TitleBarNavigationMode {
        /** Home icon - goes back to launcher and closes the active app if any, then toggles the launcher left panel. */
        HOME = 0,
        /** Close icon - goes back to launcher and closes the app. */
        CLOSE = 1,
        /** Back icon - sends a "go-back" internal message to the active app in order to let it manage its own navigzation. */
        BACK = 2
    }

    /**
     * Type describing a context menu entry opened from the title bar.
     */
    type TitleBarMenuItem = {
        /** Unique key to identity each item. */
        key: String,
        /** Path to an icon picture illustrating this menu item. */
        iconPath: String,
        /** Localized menu item display title. */
        title: String
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
         * @param foregroundMode A TitleBarForegroundMode mode, LIGHT or DARK.
         */
        setForegroundMode(foregroundMode: TitleBarForegroundMode);

        /**
         * Changes the top left icon appearance and behaviour. See @TitleBarNavigationMode for available
         * navigation modes.
         * 
         * Applications are responsible for managing their "back" state when opening screens that can go back.
         * They can also choose to always close only.
         * 
         * @param navigationMode See @TitleBarNavigationMode
         */
        setNavigationMode(navigationMode: TitleBarNavigationMode);

        /**
         * TODO ------- Changes the visibility status of the "favorite" icon
         * 
         * @param visible 
         */
        //setFavoriteVisibility(visible: Boolean);

        /**
         * Configures the menu popup that is opened when the top right menu icon is touched.
         * This menu popup mixes app-specific items (menuItems) and native system actions.
         * When a menu item is touched, onItemClicked() is called.
         * 
         * @param menuItems List of app-specific menu entries @TitleBarMenuItem .
         * @param onItemClicked Callback called when an item is clicked.
         */
        setupMenuItems(menuItems: [TitleBarMenuItem], onItemClicked: (TitleBarMenuItem)=>void);
    }
}