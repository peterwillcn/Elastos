//
//  HMWQrCodePopupWindowView.h
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMWQrCodePopupWindowViewDelegate <NSObject>

-(void)QrCodePopupWindowHidde;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HMWQrCodePopupWindowView : UIView
/*
 *<# #>
 */
@property(strong,nonatomic)id<HMWQrCodePopupWindowViewDelegate> delegate;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *walletAddressString;

@end

NS_ASSUME_NONNULL_END
