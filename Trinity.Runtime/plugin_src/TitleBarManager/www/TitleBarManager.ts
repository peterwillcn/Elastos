/*
* Copyright (c) 2018 Elastos Foundation
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

let exec = cordova.exec;

class TitleBarManagerImpl implements TitleBarPlugin.TitleBarManager {
    setTitle(title?: String) {
        let args = [];
        if (title)
            args[0] = title;

        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setTitle()", err);
        }, 'TitleBarPlugin', 'setTitle', args);
    }

    setBackgroundColor(hexColor: String) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setBackgroundColor()", err);
        }, 'TitleBarPlugin', 'setBackgroundColor', [hexColor]);
    }

    setForegroundMode(mode: TitleBarPlugin.TitleBarForegroundMode) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setForegroundMode()", err);
        }, 'TitleBarPlugin', 'setForegroundMode', [mode]);
    }

    setNavigationMode(navigationMode: TitleBarPlugin.TitleBarNavigationMode) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setNavigationMode()", err);
        }, 'TitleBarPlugin', 'setNavigationMode', [navigationMode]);
    }

    setupMenuItems(menuItems: [TitleBarPlugin.TitleBarMenuItem]) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setupMenuItems()", err);
        }, 'TitleBarPlugin', 'setupMenuItems', [menuItems]);
    }

    setNavigationIconVisibility(visible: boolean) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setNavigationIconVisibility()", err);
        }, 'TitleBarPlugin', 'setNavigationIconVisibility', [visible]);
    }

    setOnItemClickedListener(onItemClicked: (menuItem: TitleBarPlugin.TitleBarIcon) => void) {
        exec((menuItem: TitleBarPlugin.TitleBarIcon)=>{
            onItemClicked(menuItem);
        }, (err)=>{
            console.error("Error while calling TitleBarPlugin.setOnItemClickedListener()", err);
        }, 'TitleBarPlugin', 'setOnItemClickedListener', []);
    }

    setIcon(iconSlot: TitleBarPlugin.TitleBarIconSlot, icon: TitleBarPlugin.TitleBarIcon) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setIcon()", err);
        }, 'TitleBarPlugin', 'setIcon', [iconSlot, icon]);
    }

    setBadgeCount(iconSlot: TitleBarPlugin.TitleBarIconSlot, count: number) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setBadgeCount()", err);
        }, 'TitleBarPlugin', 'setBadgeCount', [iconSlot, count]);
    }

    showActivityIndicator(type: TitleBarPlugin.TitleBarActivityType, hintText?: string) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.showActivityIndicator()", err);
        }, 'TitleBarPlugin', 'showActivityIndicator', [type, hintText]);
    }    
    
    hideActivityIndicator(type: TitleBarPlugin.TitleBarActivityType) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.hideActivityIndicator()", err);
        }, 'TitleBarPlugin', 'hideActivityIndicator', [type]);
    }


    // @deprecated
    setBehavior(behavior: TitleBarPlugin.TitleBarBehavior) {
        // Doesn't do anything any more but keep this empty placeholder for old apps backward
        // compatibility for a while.
    }
}

export = new TitleBarManagerImpl();