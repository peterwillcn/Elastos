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

import Foundation

 
 @nonobjc extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        
        child.view.frame = view.frame
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func switchController(from fromViewController: TrinityViewController,
                          to toViewController: TrinityViewController) {
        self.transition(from: fromViewController, to: toViewController, duration: 0, animations: nil);
    }
 }
 
@objc(MainViewController)
class MainViewController: UIViewController {
    var appManager: AppManager? = nil;
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        appManager = AppManager(self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        try! appManager!.loadLauncher();
    }
    
    // Called for elastos:// link types
    @objc func openURL(_ url: URL) -> Bool {
        // Handler for elastos://action?params urls.
        if let scheme = url.scheme, scheme.localizedCaseInsensitiveCompare("elastos") == .orderedSame {
            
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            
            print(url.scheme)
            print(url.query)
            print(parameters)
            
            // TODO: pass all this info to the app manager to handle elastos://action?params urls
            
            return true
        }
        else {
            return false
        }
        
        // TODO: do we still need to call setInstallUri()? Need to check if
        // BPI out for now - need to check --> appManager!.setInstallUri(url.absoluteString);
    }
    
    // Called for universal links (applinks:scheme.elastos.org)
    @objc func continueAndRestore(userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if let url = userActivity.webpageURL {
            var view = url.lastPathComponent
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            
            // TODO: pass all this info to the app manager to handle https://scheme.elastos.org/action?params urls
        }
        return true
    }
}

