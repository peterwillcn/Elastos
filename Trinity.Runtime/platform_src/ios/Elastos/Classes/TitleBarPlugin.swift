//
//  TitleBarPlugin.swift
//  elastOS
//
//  Created by Benjamin Piette on 05/03/2020.
//

import Foundation

@objc(TitleBarPlugin)
class TitleBarPlugin : TrinityPlugin {
    func success(_ command: CDVInvokedUrlCommand) {
        let result = CDVPluginResult(status: CDVCommandStatus_OK)

        self.commandDelegate.send(result, callbackId: command.callbackId)
    }

    func error(_ command: CDVInvokedUrlCommand, _ retAsString: String) {
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR,
                                     messageAs: retAsString);

        self.commandDelegate.send(result, callbackId: command.callbackId)
    }
    
     private func getTitleBar() -> TitleBarView {
         let viewController = AppManager.getShareInstance().getViewControllerById(self.appId);
         return viewController!.getTitlebar();
     }

     @objc func showActivityIndicator(_ command: CDVInvokedUrlCommand) {
         let activityIndicatoryType = command.arguments[0] as! Int
    
         getTitleBar().showActivityIndicator(activityType: TitleBarActivityType.init(rawValue: activityIndicatoryType) ?? .OTHER)

         self.success(command)
     }

     private func hideActivityIndicator(_ command: CDVInvokedUrlCommand) {
         let activityIndicatoryType = command.arguments[0] as! Int

         getTitleBar().hideActivityIndicator(activityType: TitleBarActivityType.init(rawValue: activityIndicatoryType) ?? .OTHER)

         self.success(command)
     }

     private func setTitle(_ command: CDVInvokedUrlCommand) {
         let title = command.arguments[0] as? String ?? ""

         getTitleBar().setTitle(title)

         self.success(command)
     }

     private func setBackgroundColor(_ command: CDVInvokedUrlCommand) {
         let hexColor = command.arguments[0] as? String ?? "#000000"

         if (getTitleBar().setBackgroundColor(hexColor)) {
             self.success(command)
         } else {
             self.error(command, "Invalid color \(hexColor)")
         }
     }

     private func setForegroundMode(_ command: CDVInvokedUrlCommand) {
         let modeAsInt = command.arguments[0] as! Int

         getTitleBar().setForegroundMode(TitleBarForegroundMode(rawValue: modeAsInt) ?? .LIGHT)

         self.success(command)
     }
}
