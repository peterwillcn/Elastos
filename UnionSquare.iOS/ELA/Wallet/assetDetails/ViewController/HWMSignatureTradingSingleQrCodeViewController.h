//
//  HWMSignatureTradingSingleQrCodeViewController.h
//  elastos wallet
//
//  Created by  on 2019/7/16.
//

#import <UIKit/UIKit.h>
#import "HWMSignStatusModel.h"

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
@property(copy,nonatomic)NSDictionary *QRCodeSignatureDic;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *subW;
@property(nonatomic,strong)FLWallet *currentWallet;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMSignStatusModel *SignStatus;
@end

NS_ASSUME_NONNULL_END
