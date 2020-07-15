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


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, QrCodeSignatureType) {
    credaccessQrCodeType,
    suggestionQrCodeType,
    billQrCodeType,
    reviewPropalQrCodeType, //xxl 2.2 flow
    voteforProposalQrCodeType, //xxl 2.3 flow
   
    
    SecretaryGeneralType,
    withdrawalsType,
    Updatemilestone,
    Reviewmilestone,
    ConformIdentityType,
    CreadDIDType,
    DIDTimePassType,
    CommonIdentityType,//普通人身份
    QRTimePassType,
    AuthenticationDID,
     unknowQrCodeType,
    errQrCodeType,
    
};
typedef void(^QrCodeSignatureTypeBlock)(QrCodeSignatureType type,id data);


NS_ASSUME_NONNULL_BEGIN

@interface HWMQrCodeSignatureManager : NSObject
+(instancetype)shareTools;
-(void)QrCodeDataWithData:(NSString*)data withDidString:(NSString*)didString withmastWalletID:(NSString*)masterWalletID withComplete:(QrCodeSignatureTypeBlock)Complete;
@end

NS_ASSUME_NONNULL_END
