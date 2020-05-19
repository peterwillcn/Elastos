 /*
  * Copyright (c) 2020 Elastos Foundation
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

import UIKit
 import SwiftJWT

@objc(TrinityViewController)
class TrinityViewController : CDVViewController {
    var basePlugin: AppBasePlugin?;
    var id = "";
    var appInfo: AppInfo?;
    var whitelistFilter: WhitelistFilter?;

    @IBOutlet weak var titlebarContainer: UIView!
    @IBOutlet weak var webContainer: UIView!
    var titlebar: TitleBarView!
    var webOriginFrame: CGRect?;
    var webLayoutView: UIView?;

    @IBOutlet weak var titlebarHeightConstraint: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        if let nib = Bundle.main.loadNibNamed("TrinityViewController", owner: self),
            let nibView = nib.first as? UIView {
            view = nibView
            webOriginFrame = webContainer.frame;
        }
    }

    func setTrinityPluginInfo(_ plugin:CDVPlugin!) {
        let trinityPlugin = plugin as? TrinityPlugin

        if trinityPlugin != nil {
            trinityPlugin!.setWhitelist(self.whitelistFilter)
            trinityPlugin!.setInfo(self.appInfo);
        }
    }

    override func register(_ plugin:CDVPlugin!, withClassName className:String!) {
        setTrinityPluginInfo(plugin);
        return super.register(plugin, withClassName: className);
    }

    override func register(_ plugin:CDVPlugin!, withPluginName pluginName:String!) {
        setTrinityPluginInfo(plugin);
        return super.register(plugin, withPluginName: pluginName);
    }

    func filterPlugin(_ pluginName: String, _ className: String) -> NullPlugin? {
        return nil;
    }

    override func getCommandInstance(_ name: String) -> Any {
        let pluginName = name.lowercased();
        let className = self.pluginsMap[pluginName] as! String;
        var obj = self.pluginObjects[className as Any];
        guard obj == nil else {
            return obj as Any;
        }

        obj = filterPlugin(pluginName, className)
        guard obj == nil else {
            return obj as Any;
        }

        obj = super.getCommandInstance(pluginName)
        let plugin = obj as? CDVPlugin
        if plugin != nil {
            plugin!.pluginName = pluginName;
        }

        return obj as Any;
    }

    override func newCordovaView(withFrame bounds: CGRect) ->UIView {
        titlebar = TitleBarView(self, titlebarContainer.frame, id == "launcher", id)
        titlebarContainer.addSubview(titlebar!)
        self.addMatchParentConstraints(view: titlebar, parent: titlebarContainer)

        let webview = super.newCordovaView(withFrame: CGRect())
        if (webview != nil) {
            webContainer.addSubview(webview!)
            self.addMatchParentConstraints(view: webview!, parent: webContainer)
        }

        return webContainer
    }

    func addMatchParentConstraints(view: UIView, parent: UIView) {
        parent.addConstraint(NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1.0, constant: 0.0))
        parent.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1.0, constant: 0.0))
        parent.addConstraint(NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        parent.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: parent, attribute: .trailing, multiplier: 1.0, constant: 0.0))

        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func addSwipe(_ direction: UInt) {
        let swipe = UISwipeGestureRecognizer(target:self, action:#selector(handleSwipes(_:)));
        swipe.direction = UISwipeGestureRecognizer.Direction(rawValue: direction);
        self.webView.addGestureRecognizer(swipe);
        self.webView.scrollView.panGestureRecognizer.require(toFail: swipe);
    }

    @objc func handleSwipes(_ recognizer:UISwipeGestureRecognizer){
        if (recognizer.direction == UISwipeGestureRecognizer.Direction.right) {
            // BPI REMOVED titlebar!.clickBack();
        }
        else {
            if titlebarHeightConstraint.constant == 0.0 {
                // Show the hidden title bar and move the web container down
                UIView.animate(withDuration: 0.3, animations: {
                    self.titlebarHeightConstraint.constant = 45.0
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    self.titlebarContainer.isHidden = false
                })
            }
            else {
                // Hide the visible title bar and move the web container up
                titlebarContainer.isHidden = true
                UIView.animate(withDuration: 0.3, animations: {
                    self.titlebarHeightConstraint.constant = 0.0
                    self.view.layoutIfNeeded()
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad();

        for (name , value) in self.pluginObjects as! [String: CDVPlugin] {
            if (name == "AppBasePlugin") {
                let plugin = value as! AppBasePlugin;
                self.basePlugin = plugin;
                break;
            }
        }

//        if (appInfo!.type == "url") {
//            addSwipe(UISwipeGestureRecognizer.Direction.left.rawValue);
//            addSwipe(UISwipeGestureRecognizer.Direction.right.rawValue);
//        }
//        else {
//            addSwipe(UISwipeGestureRecognizer.Direction.down.rawValue);
//        }

    }

    @objc func getBasePlugin() -> AppBasePlugin {
        return self.basePlugin!;
    }

    @objc func getTitlebar() -> TitleBarView {
        return self.titlebar;
    }

    func loadUrl(_ url: URL) {
        //TODO:: it isn't work
        self.webViewEngine.load(URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0));
    }
    
    func setReady() {

    }
    
    func isNativeApp() -> Bool {
        return false;
    }
}
