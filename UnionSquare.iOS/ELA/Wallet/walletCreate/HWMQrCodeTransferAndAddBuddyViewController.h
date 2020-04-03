//
//  HWMQrCodeTransferAndAddBuddyViewController.h
//  elastos wallet
//
//  Created by  on 2019/8/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMQrCodeTransferAndAddBuddyViewController : UIViewController
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *addressString;
/*
 *<# #>
 */
@property(copy,nonatomic)NSDictionary *addressDic;

@property(nonatomic,strong)FLWallet *currentWallet;

@end

NS_ASSUME_NONNULL_END
