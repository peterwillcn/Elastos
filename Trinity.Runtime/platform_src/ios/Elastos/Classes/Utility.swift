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

func getAssetsPath(_ url: String) -> String {
    let index = url.index(url.startIndex, offsetBy: 9)
    let substr = url[index ..< url.endIndex];
    return getAbsolutePath(String(substr));
}
 
 enum AppError: Error {
    case error(String)
 }
 
