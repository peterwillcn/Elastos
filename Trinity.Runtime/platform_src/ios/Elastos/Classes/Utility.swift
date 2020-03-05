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
import WebKit

func resetPath(_ dir: String, _ origin: String) -> String {
    var ret = origin;
    if (!ret.hasPrefix("http://") && !ret.hasPrefix("https://")
        && !ret.hasPrefix("file:///")) {
        while (ret.first == "/") {
            ret.remove(at: ret.startIndex);
        }
        ret = dir + ret;
    }
    return ret;
}

func getAbsolutePath(_ path: String, _ type: String? = nil) -> String {
    let nsPath: NSString = path as NSString;
    if !nsPath.isAbsolutePath {
        let absolutePath = Bundle.main.path(forResource: path, ofType: nil)
        if absolutePath != nil {
            return absolutePath!;
        }
    }
    return path;
}

func getAssetPath(_ url: String) -> String {
    let index = url.index(url.startIndex, offsetBy: 8)
    let substr = url[index ..< url.endIndex];
    return getAbsolutePath(String(substr));
}

 func getTrinityPath(_ url: String, _ mainUrl: String) -> String {
    let appManager = AppManager.getShareInstance();
    for (id, view) in appManager.viewControllers {
        if (view.startPage == mainUrl) {
            var offset = 0;
            var path = "";
            if url.hasPrefix("trinity:///asset/") {
                offset = 18;
                path = appManager.getAppPath(view.appInfo!);
            }
            else if url.hasPrefix("trinity:///data/") {
                offset = 16;
                path = appManager.getDataPath(id);
            }
            else if url.hasPrefix("trinity:///temp/") {
                offset = 16;
                path = appManager.getTempPath(id);
            }
            else {
                return ""
            }
            let index = url.index(url.startIndex, offsetBy: offset);
            let substr = url[index ..< url.endIndex];
            return  path + substr;
        }

    }
    return "";
 }

 func handleUrlSchemeTask(_ path: String, _ urlSchemeTask: WKURLSchemeTask) {
    if path.range(of: "://") != nil {
        let request = URLRequest(url: NSURL(string: path)! as URL);
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default);
        let task = session.dataTask(with: request, completionHandler: {[weak urlSchemeTask] (data, response, error) in
            guard let urlSchemeTask = urlSchemeTask else {
                return
            }

            if let error = error {
                urlSchemeTask.didFailWithError(error)
            } else {
                if let response = response {
                    urlSchemeTask.didReceive(response)
                }

                if let data = data {
                    urlSchemeTask.didReceive(data)
                }
                urlSchemeTask.didFinish()
            }
        })
        task.resume();
    }
    else if path.hasPrefix("/") {
        do {
            let fileUrl = URL.init(fileURLWithPath: path)

            let data = try Data(contentsOf: fileUrl);
            let response = URLResponse(url: urlSchemeTask.request.url!, mimeType: "text/plain", expectedContentLength: data.count, textEncodingName: nil)
            urlSchemeTask.didReceive(response);
            urlSchemeTask.didReceive(data)
            urlSchemeTask.didFinish();
        }
        catch let error {
            print("HandleUrlSchemeTask: \(error)");
        }
    }
 }

 func getJsonFromFile(_ path: String)  throws -> [String: Any] {
    let url = URL.init(fileURLWithPath: path)

    let data = try Data(contentsOf: url);
    let json = try JSONSerialization.jsonObject(with: data,
                                                options: []) as! [String: Any];
    return json;
 }

 enum AppError: Error {
    case error(String)
 }

//----------------------------------------------------------------------
 // Extend String to be able to throw simple String Errors
 extension String: LocalizedError{

    public var errorDescription: String? { return self }

    func toDict() -> [String : Any]? {
        let data = self.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return nil
    }

     func fromBase64() -> String? {
         guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
             return nil
         }

         return String(data: data as Data, encoding: String.Encoding.utf8)
     }

    func toBase64() -> String? {
         guard let data = self.data(using: String.Encoding.utf8) else {
             return nil
         }

         return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }

    func toBase64Data() -> Data? {
        var st = self;
        if (self.count % 4 <= 2){
            st += String(repeating: "=", count: (self.count % 4))
        }
        return Data(base64Encoded: st)
    }

    func encodingURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    func encodingQuery() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
 }

 extension Dictionary {
     func percentEncoded() -> Data? {
         return map { key, value in
             let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
             let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
             return escapedKey + "=" + escapedValue
         }
         .joined(separator: "&")
         .data(using: .utf8)
     }

    func toString() -> String? {
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }
 }

 extension CharacterSet {
     static let urlQueryValueAllowed: CharacterSet = {
         let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
         let subDelimitersToEncode = "!$&'()*+,;="

         var allowed = CharacterSet.urlQueryAllowed
         allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
         return allowed
     }()
 }

 extension URL {
     public var parametersFromQueryString : [String: String]? {
         guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
         let queryItems = components.queryItems else { return nil }
         return queryItems.reduce(into: [String: String]()) { (result, item) in
             result[item.name] = item.value
         }
     }
 }

 extension UIColor {
    /** Html-like #AARRGGBB or #RRGGBB formats */
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 || hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    if hexColor.count == 8 {
                        a = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    }
                    else {
                        a = 255
                    }
                    r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        print("Failed to initialize color from HEX code \(hex)")
        return nil
    }
 }
