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

import Foundation

class IntentActionChooserController: UIViewController {
    // Outlets
    @IBOutlet var listItemsStackView: UIStackView!
    
    // Model
    private var appManager: AppManager? = nil
    private var appInfos: [AppInfo] = []
    private var selectionCallback: ((AppInfo)->Void)?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add one line for each app that can be used to handle the intent
        for appInfo in appInfos {
            let appInfoLineItem  = IntentActionChooserItemView(appManager: appManager!, appInfo: appInfo)
            appInfoLineItem.setListener() {
                self.selectionCallback?(appInfo)
            }
            
            listItemsStackView.addArrangedSubview(appInfoLineItem)
        }
    }
    
    public func setAppManager(appManager: AppManager) {
        self.appManager = appManager
    }
    
    public func setAppInfos(appInfos: [AppInfo]) {
        self.appInfos = appInfos
    }
    
    public func setListener(_ listener: @escaping (AppInfo) -> Void) {
        self.selectionCallback = listener
    }
}
