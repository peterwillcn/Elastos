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

import SQLite

class IdentityAvatar {
    let contentType: String
    let base64ImageData: SQLite.Blob

    init(contentType: String, base64ImageData: SQLite.Blob) {
        self.contentType = contentType
        self.base64ImageData = base64ImageData
    }

    public func asJsonObject() -> Dictionary<String, Any> {
        var jsonObj = Dictionary<String, Any>()
        jsonObj["contentType"] = contentType
        jsonObj["base64ImageData"] = base64ImageData
        return jsonObj
    }

    public static func fromJsonObject(_ jsonObj: Dictionary<String, Any>) -> IdentityAvatar? {
        if !jsonObj.keys.contains("contentType") || !jsonObj.keys.contains("base64ImageData") {
            return nil
        }

        return IdentityAvatar(contentType: jsonObj["contentType"] as! String, base64ImageData: jsonObj["base64ImageData"] as! SQLite.Blob)
    }
}
