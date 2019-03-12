/********* Wallet.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "IMasterWallet.h"
#import "IDidManager.h"
#import "DIDManagerSupervisor.h"
#import "MasterWalletManager.h"
#import <string.h>
#import "ELWalletManager.h"


@interface Wallet : CDVPlugin {
    
    ELWalletManager *walletManager;
}


- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)print:(CDVInvokedUrlCommand*)command;
- (void)getAllMasterWallets:(CDVInvokedUrlCommand*)command;
- (void)createMasterWallet:(CDVInvokedUrlCommand*)command;
- (void)generateMnemonic:(CDVInvokedUrlCommand*)command;
- (void)createSubWallet:(CDVInvokedUrlCommand*)command;
- (void)getAllSubWallets:(CDVInvokedUrlCommand*)command;
- (void)getBalance:(CDVInvokedUrlCommand *)command;
- (void)getSupportedChains:(CDVInvokedUrlCommand *)command;
- (void)getMasterWalletBasicInfo:(CDVInvokedUrlCommand *)command;
- (void)getAllTransaction:(CDVInvokedUrlCommand *)command;
- (void)createAddress:(CDVInvokedUrlCommand *)command;
- (void)getGenesisAddress:(CDVInvokedUrlCommand *)command;
- (void)getMasterWalletPublicKey:(CDVInvokedUrlCommand *)command;
- (void)exportWalletWithKeystore:(CDVInvokedUrlCommand *)command;
- (void)exportWalletWithMnemonic:(CDVInvokedUrlCommand *)command;
- (void)importWalletWithKeystore:(CDVInvokedUrlCommand *)command;
- (void)importWalletWithMnemonic:(CDVInvokedUrlCommand *)command;
@end

@implementation Wallet

- (void)pluginInitialize
{
    walletManager = [[ELWalletManager alloc] init];
    [walletManager pluginInitialize];
}
- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [walletManager coolMethod:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)print:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [walletManager print:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getAllMasterWallets:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [walletManager getAllMasterWallets:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
- (void)createMasterWallet:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [walletManager createMasterWallet:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}
- (void)generateMnemonic:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [walletManager generateMnemonic:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)createSubWallet:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [walletManager createSubWallet:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getAllSubWallets:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult *pluginResult = [walletManager getAllSubWallets:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getBalance:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager getBalance:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void)getSupportedChains:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager getSupportedChains:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getMasterWalletBasicInfo:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager getMasterWalletBasicInfo:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getAllTransaction:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager getAllTransaction:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)createAddress:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager createAddress:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getGenesisAddress:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager getGenesisAddress:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)getMasterWalletPublicKey:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager getMasterWalletPublicKey:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)exportWalletWithKeystore:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager exportWalletWithKeystore:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)exportWalletWithMnemonic:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager exportWalletWithMnemonic:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)changePassword:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager changePassword:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)importWalletWithKeystore:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager importWalletWithKeystore:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)importWalletWithMnemonic:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *pluginResult = [walletManager importWalletWithMnemonic:command];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
