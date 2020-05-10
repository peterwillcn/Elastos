
import Foundation

let syncStart = NSNotification.Name("syncStart")
let refreshTransaction = NSNotification.Name("refreshTransaction")
let createWallet = NSNotification.Name("createWallet")

let mnemonicLang = "english"
var masterWalletName = ""
var payPassword = ""
var masterWalletID = ""
var mnemonic = ""
let chainID = "ELA"
var MaxCount = 0
var currentCount = 0
var lastBlockTimeAndProgress = ""

public func getMasterWalletID() -> String {
    return UUID().uuidString
}

public func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
    let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval)
    let formatter = DateFormatter.init()
    if dateFormat == nil {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }else{
        formatter.dateFormat = dateFormat
    }
    return formatter.string(from: date as Date)
}
