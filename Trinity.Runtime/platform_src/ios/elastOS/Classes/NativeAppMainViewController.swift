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

class NativeAppMainViewController: UIViewController {
    var appInfo: AppInfo?;
    var basePlugin: AppBasePlugin?;
    var isReady = false;

    required convenience init(_ appInfo: AppInfo, _ basePlugin: AppBasePlugin) {
        self.init();
        self.appInfo = appInfo;
        self.basePlugin = basePlugin;
    }

    func setReady() {
        if (!isReady) {
            isReady = true;
            self.basePlugin!.setMessageListener(onReceiveMessage);
            self.basePlugin!.setIntentListener(onReceiveIntent);
        }
    }

    func getParams(_ params: String?) -> [String: Any]? {
        if (params == nil) {
            return nil;
        }

        let data = params!.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if (data == nil) {
            return nil;
        }

        return try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : Any]
    }

    func onReceiveMessage(_ type: Int, _ msg: String, _ fromId: String) {

    }

    func onReceiveIntent(_ action: String, _ params: String?, _ fromId: String, _ intentId: Int64) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
