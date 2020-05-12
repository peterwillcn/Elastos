
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

func changeEla(_ sela: String) -> String {
    do {
        let sela: Double = try Double(value: sela)
        return String(sela / 100000000.0)
    } catch {
        print(error)
    }
    return ""
}

func changeSEla(_ ela: String) -> String {
    do {
        let ela: Double = try Double(value: ela)
        return String(format:"%.0f",ela * 100000000)
    } catch {
        print(error)
    }
    return ""
}

public func getMasterWalletID() -> String {
    return UUID().uuidString
}

public func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
    if timeInterval <= 0 {
        return ""
    }
    let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval)
    let formatter = DateFormatter.init()
    if dateFormat == nil {
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }else{
        formatter.dateFormat = dateFormat
    }
    return formatter.string(from: date as Date)
}
