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

class IdentityEntry {
    var id: Int64? = nil
    let didStoreId: String
    let didString: String
    let name: String
    var avatar: IdentityAvatar? = nil

    convenience init(didStoreId: String, didString: String, name: String) {
        self.init(didStoreId: didStoreId, didString: didString, name: name, avatar: nil)
    }

    init(didStoreId: String, didString: String, name: String, avatar: IdentityAvatar?) {
        self.didStoreId = didStoreId
        self.didString = didString
        self.name = name
        self.avatar = avatar
    }

    public func asJsonObject() -> Dictionary<String, Any> {
        var jsonObj = Dictionary<String, Any>()
        
        jsonObj["didStoreId"] = didStoreId
        jsonObj["didString"] = didString
        jsonObj["name"] = name

        if avatar != nil {
            jsonObj["avatar"] = avatar!.asJsonObject()
        }

        return jsonObj
    }

    public static func fromJsonObject(_ jsonObj: Dictionary<String, Any>) -> IdentityEntry? {
        if !jsonObj.keys.contains("didStoreId") || !jsonObj.keys.contains("didString") || !jsonObj.keys.contains("name") {
            return nil
        }

        let identity = IdentityEntry(
            didStoreId: jsonObj["didStoreId"] as! String,
            didString: jsonObj["didString"] as! String,
            name: jsonObj["name"] as! String)

        if jsonObj.keys.contains("avatar") {
            if let jsonAvatar = jsonObj["avatar"] as? Dictionary<String, Any> {
                identity.avatar = IdentityAvatar.fromJsonObject(jsonAvatar)
            }
        }

        return identity
    }
}
