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
    showActivityIndicator(type: TitleBarPlugin.TitleBarActivityType) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.showActivityIndicator()", err);
        }, 'TitleBarPlugin', 'showActivityIndicator', [type]);
    }    
    
    hideActivityIndicator(type: TitleBarPlugin.TitleBarActivityType) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.hideActivityIndicator()", err);
        }, 'TitleBarPlugin', 'hideActivityIndicator', [type]);
    }

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

    setBehavior(behavior: TitleBarPlugin.TitleBarBehavior) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setBehavior()", err);
        }, 'TitleBarPlugin', 'setBehavior', [behavior]);
    }

    setNavigationMode(navigationMode: TitleBarPlugin.TitleBarNavigationMode) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setNavigationMode()", err);
        }, 'TitleBarPlugin', 'setNavigationMode', [navigationMode]);
    }

    setupMenuItems(menuItems: [TitleBarPlugin.TitleBarMenuItem], onItemClicked: (TitleBarMenuItem: any) => void) {
        exec((menuItem)=>{
            onItemClicked(menuItem);
        }, (err)=>{
            console.error("Error while calling TitleBarPlugin.setForegroundMode()", err);
        }, 'TitleBarPlugin', 'setupMenuItems', [menuItems]);
    }

    setVisibility(visibility: TitleBarPlugin.TitleBarVisibility) {
        exec(()=>{}, (err)=>{
            console.error("Error while calling TitleBarPlugin.setVisibility()", err);
        }, 'TitleBarPlugin', 'setVisibility', [visibility]);
    }
}

export = new TitleBarManagerImpl();