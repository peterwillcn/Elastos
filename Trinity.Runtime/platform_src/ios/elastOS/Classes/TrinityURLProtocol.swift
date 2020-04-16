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

@objc(TrinityURLProtocol)
class TrinityURLProtocol: URLProtocol {

    @objc override class func canInit(with request: URLRequest) -> Bool {
        let url = request.url!
        if (url.absoluteString.hasPrefix("asset://")) {
            return true;
        }
        else if (url.absoluteString.hasPrefix("trinity://")) {
            return true;
        }

        return false
    }

    @objc override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request;
    }

    @objc override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b);
    }

    func loadFile(_ path: String) {
        let fileUrl = URL.init(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: fileUrl);
            let response = URLResponse(url: self.request.url!, mimeType: "text/plain", expectedContentLength: data.count, textEncodingName: nil)

            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
            self.client?.urlProtocol(self, didLoad: data);
            self.client?.urlProtocolDidFinishLoading(self);
        }
        catch let error {
            print("loadFile: \(error)");
        }
    }

    @objc override func startLoading() {
        let url = self.request.url!.absoluteString;
        if (url.hasPrefix("asset://")) {
            let path = getAssetPath(url);
            loadFile(path);
        }
        else if (url.hasPrefix("trinity://")) {
            let path = getTrinityPath(url, self.request.mainDocumentURL!.absoluteString);
            if path.range(of: "://") != nil {
                let request = URLRequest(url: NSURL(string: path)! as URL);
                let session: URLSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil);
                let task = session.dataTask(with: request);
                task.resume();
            }
            else if path.hasPrefix("/") {
                loadFile(path);
            }
        }

    }

    @objc override func stopLoading() {
    }
}

 extension TrinityURLProtocol: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
        completionHandler(URLSession.ResponseDisposition.allow);
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data);
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("session error");
        }
        self.client?.urlProtocolDidFinishLoading(self);
    }
 }
