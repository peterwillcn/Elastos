//
//  HWMNewPrivateKeyViewController.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/3.
//

#import <UIKit/UIKit.h>

@protocol HWMNewPrivateKeyViewControllerDelegate <NSObject>
-(void)backTheMnemonicWord:(NSString*)word withPWD:(NSString*)PWD;


@end

@interface HWMNewPrivateKeyViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMNewPrivateKeyViewControllerDelegate>delegate;
@end


