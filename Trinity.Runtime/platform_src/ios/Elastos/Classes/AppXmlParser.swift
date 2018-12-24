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
 class AppXmlParser: CDVConfigParser {
    let appInfo = AppInfo();
    
    var pluginFeature = false;
    var urlFeature = false;
    var iconFeature = false;
    var currentNodeName = ""
    
    override func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentNodeName = elementName
        if elementName == "dapp" {
            appInfo.id = attributeDict["id"]!
            appInfo.version = attributeDict["version"]!
        }
        else if (elementName == "plugins") {
            pluginFeature = true;
        }
        else if (pluginFeature && elementName == "plugin") {
            appInfo.addPlugin(attributeDict["name"]!, AppInfo.AUTHORITY_NOINIT);
        }
        else if (elementName == "urls") {
            urlFeature = true;
        }
        else if (urlFeature && elementName == "access") {
            appInfo.addUrl(attributeDict["href"]!, AppInfo.AUTHORITY_NOINIT);
        }
        else if (elementName == "icons") {
            iconFeature = true;
        }
        else if (elementName == "author") {
            appInfo.author_name = attributeDict["name"]!;
            appInfo.author_email = attributeDict["email"]!;
        }
    }
    
    override func parser(_ parser: XMLParser, foundCharacters string: String) {
        let value = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        guard value != "" else {
            return
        }
        
        if (iconFeature && currentNodeName == "big") {
            appInfo.big_icon = value;
        }
        else if (iconFeature && currentNodeName == "small") {
            appInfo.small_icon = value;
        }
        else if (currentNodeName == "name") {
            appInfo.name = value;
        }
        else if (currentNodeName == "description") {
            appInfo.desc = value;
        }
        else if (currentNodeName == "launch_path") {
            appInfo.launch_path = value;
        }
        else if (currentNodeName == "default_locale") {
            appInfo.default_locale = value;
        }
    }
    
    override func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "plugins") {
            pluginFeature = false;
        }
        else if (elementName == "urls") {
            urlFeature = false;
        }
        else if (elementName == "icons") {
            iconFeature = false;
        }
    }
    
    func parseSettings(_ path: String) -> AppInfo? {
        let url = URL.init(fileURLWithPath: path)
        let configParser = XMLParser.init(contentsOf: url);
        if (configParser == nil) {
            print("Failed to initialize XML parser.");
            return nil;
        }
        configParser!.delegate = self;
        configParser!.parse()
        
        return appInfo;
    }

 }
