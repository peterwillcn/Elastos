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
#import "HWMSecretaryGeneralAndMembersInfo.h"
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
    
    //xxl fix the bug for suggestionQrCodeType
    if (type ==credaccessQrCodeType||type==billQrCodeType||type==reviewPropalQrCodeType
        || type == withdrawalsType || type == Updatemilestone || type == Reviewmilestone) {
        
        HWMSecretaryGeneralAndMembersDetailsModel* model=[[HWMSecretaryGeneralAndMembersInfo shareTools]getDetailsModel];
        if (model) {
            if (model.GMtype!= COUNCILType&&model.GMtype!=SECRETARIATType) {
                Complete(CommonIdentityType,data) ;
                return  ;
                
            }
        }else {
            [[HWMSecretaryGeneralAndMembersInfo shareTools] loadDataSourceWithLoading:YES complete:^(HWMSecretaryGeneralAndMembersDetailsModel *model) {
                if (model.GMtype!= COUNCILType&&model.GMtype!=SECRETARIATType) {
                    Complete(CommonIdentityType,data) ;
                    return  ;
                    
                }
            }];
        }
        
        
        if ([self detectionDidInfowithDidString:didString withmastWalletID:masterWalletID]!=ConformIdentityType) {
            
            type=[self detectionDidInfowithDidString:didString withmastWalletID:masterWalletID];
         Complete(type,data) ;
            return  ;
        }
    }
    
    
    id QrCodeData=[self ParsingQrCodeDataWithQrCodeType:type withQrCodeString:data];
    if (QrCodeData) {
        Complete(type,QrCodeData);
    }
    
}
-(QrCodeSignatureType)detectionDidInfowithDidString:(NSString*)didString withmastWalletID:(NSString*)masterWalletID{
    [[HWMDIDManager shareDIDManager]hasDIDWithPWD:@"" withDIDString:didString WithPrivatekeyString:@"" WithmastWalletID:masterWalletID needCreatDIDString:YES];
//    needCreadDIDType,
//    DIDTimePassType,
//    CommonIdentityType
    if (![[HWMDIDManager shareDIDManager]HasBeenOnTheChain]) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"当前钱包未创建DID", nil)];
          return  CreadDIDType;
    }
    if (![[HWMDIDManager shareDIDManager]CheckDIDwhetherExpiredWithDIDString:didString WithmastWalletID:masterWalletID]) {
        return  DIDTimePassType;
    }
    return ConformIdentityType;
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
        }else if(command && [command isEqualToString:@"reviewproposal"]) {
            return reviewPropalQrCodeType;
        }
        else if(command && [command isEqualToString:@"withdraw"]) {
            return withdrawalsType;
        }
        else if(command && [command isEqualToString:@"updatemilestone"]) {
            return Updatemilestone;
        }
        else if(command && [command isEqualToString:@"reviewmilestone"]) {
            return Reviewmilestone;
        }else if (command && [command isEqualToString:@"voteforproposal"]){
            
            return voteforProposalQrCodeType;
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
        case reviewPropalQrCodeType:    //xxl 2.2
        case voteforProposalQrCodeType: //xxl 2.3
            QRCodeString=[QRCodeString stringByReplacingOccurrencesOfString:@"elastos://crproposal/" withString:@""];
            return [[HWMDIDManager shareDIDManager]CRInfoDecodeWithJwtStringInfo:QRCodeString];
            
            break;
            
        case billQrCodeType:
            QRCodeString=[QRCodeString stringByReplacingOccurrencesOfString:@"elastos://credaccess/" withString:@""];
            return [[HWMDIDManager shareDIDManager]CRInfoDecodeWithJwtStringInfo:QRCodeString];
            
            break;
        case unknowQrCodeType:
            return QRCodeString;
            break;
        case withdrawalsType:
            
            return [[HWMDIDManager shareDIDManager] CRInfoDecodeWithJwtStringInfo:QRCodeString];
            break;
        case Updatemilestone:
            
            return [[HWMDIDManager shareDIDManager] CRInfoDecodeWithJwtStringInfo:QRCodeString];
            break;
        case Reviewmilestone:
            
            return [[HWMDIDManager shareDIDManager] CRInfoDecodeWithJwtStringInfo:QRCodeString];
            break;
            
        default:
            break;
    }
    return QRCodeString;
}
-(BOOL)updateMemberIdentity{
    
    return NO;
}

@end
