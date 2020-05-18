//
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


#import "HWMQrCodeSignatureManager.h"
#import "HWMDIDManager.h"
static HWMQrCodeSignatureManager * _instance;

@implementation HWMQrCodeSignatureManager
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance==nil) {
            _instance=[super allocWithZone:zone];
        }
    });
    return _instance;
}
+(instancetype)shareTools
{
    return [[self alloc]init];
}
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}
-(void)QrCodeDataWithData:(NSString*)data withDidString:(NSString*)didString withmastWalletID:(NSString*)masterWalletID withComplete:(QrCodeSignatureTypeBlock)Complete{
    
    QrCodeSignatureType type=[self QrCodeStringtype:data];
    
    if (type ==credaccessQrCodeType||type==suggestionQrCodeType||type==billQrCodeType) {
        if ([self detectionDidInfowithDidString:didString withmastWalletID:masterWalletID]==NO) {
            return;
        }
    }
    id QrCodeData=[self ParsingQrCodeDataWithQrCodeType:type withQrCodeString:data];
    if (QrCodeData) {
        Complete(type,QrCodeData);
    }
    
}
-(BOOL)detectionDidInfowithDidString:(NSString*)didString withmastWalletID:(NSString*)masterWalletID{
    [[HWMDIDManager shareDIDManager]hasDIDWithPWD:@"" withDIDString:didString WithPrivatekeyString:@"" WithmastWalletID:masterWalletID needCreatDIDString:YES];
    if (![[HWMDIDManager shareDIDManager]HasBeenOnTheChain]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"当前钱包未创建DID", nil)];
        return NO;
    }
    if (![[HWMDIDManager shareDIDManager]CheckDIDwhetherExpiredWithDIDString:didString WithmastWalletID:masterWalletID]) {
        return NO;
    }
    return YES;
}
-(QrCodeSignatureType)QrCodeStringtype:(NSString*)QRCodeString{
    if ([QRCodeString containsString:@"elastos://credaccess/"]) {
        
        return credaccessQrCodeType;
    }
    else if ([QRCodeString containsString:@"elastos://crproposal/"]){
        NSDictionary * PayLoadDic=  [[HWMDIDManager shareDIDManager]CRInfoDecodeWithJwtStringInfo:QRCodeString];
        NSString *command = PayLoadDic[@"command"];
        if(command && [command isEqualToString:@"createsuggestion"]){
            return suggestionQrCodeType;
        }else if(command && [command isEqualToString:@"createproposal"]) {
            return billQrCodeType;
        }
    }else if ([QRCodeString containsString:@"elastos://credaccess/"]){
        return billQrCodeType;
    }else{
        return unknowQrCodeType;
        
    }
    
}
-(id)ParsingQrCodeDataWithQrCodeType:(QrCodeSignatureType)type withQrCodeString:(NSString*)QRCodeString{
    
    switch (type) {
        case credaccessQrCodeType:
            QRCodeString=[QRCodeString stringByReplacingOccurrencesOfString:@"elastos://credaccess/" withString:@""];
            return [[HWMDIDManager shareDIDManager]jwtDecodeWithJwtStringInfo:QRCodeString];
            break;
        case suggestionQrCodeType:
            QRCodeString=[QRCodeString stringByReplacingOccurrencesOfString:@"elastos://crproposal/" withString:@""];
            return [[HWMDIDManager shareDIDManager]jwtDecodeWithJwtStringInfo:QRCodeString];
            
            break;
        case billQrCodeType:
            QRCodeString=[QRCodeString stringByReplacingOccurrencesOfString:@"elastos://credaccess/" withString:@""];
            return [[HWMDIDManager shareDIDManager]CRInfoDecodeWithJwtStringInfo:QRCodeString];
            return QRCodeString;
            break;
        case unknowQrCodeType:
            return QRCodeString;
            break;
        default:
            break;
    }
    return QRCodeString;
}

@end
