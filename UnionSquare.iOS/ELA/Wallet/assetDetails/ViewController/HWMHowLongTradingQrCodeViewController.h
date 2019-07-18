//
//  HWMHowLongTradingQrCodeViewController.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, HowLongTradingQrCodeType) {
    ToBeSignedDealsQrCodeType,
    SignedDealsQrCodeType
    
};
@interface HWMHowLongTradingQrCodeViewController : UIViewController
    /*
     *<# #>
     */
    @property(assign,nonatomic)HowLongTradingQrCodeType QrCodeTyp;
@end

NS_ASSUME_NONNULL_END
