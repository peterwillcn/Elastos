//
//  HWMSignatureTradingSingleQrCodeViewController.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, QrCodeType) {
    SingleSignReadOnlyToBeSigned = 0,
     SingleSignReadOnlySignedDeals=1,
    HowSignToBeSigned=2,
     HowSignSignedDeals,
    ExportReadOnlyWallet,
    LookhHowSignThePublicKey
    
};
@interface HWMSignatureTradingSingleQrCodeViewController : UIViewController
/*
 *<# #>
 */
@property(assign,nonatomic)QrCodeType type;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *QRCodeString;
/*
 *
 */
@property(copy,nonatomic)NSDictionary *QRCodeDic;
@end

NS_ASSUME_NONNULL_END
