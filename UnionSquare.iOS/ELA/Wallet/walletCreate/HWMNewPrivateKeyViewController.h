//
//  HWMNewPrivateKeyViewController.h
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import <UIKit/UIKit.h>

@protocol HWMNewPrivateKeyViewControllerDelegate <NSObject>
-(void)backTheMnemonicWord:(NSString*)word withPWD:(NSString*)PWD withPhrasePassword:(NSString*)phrasePassword;


@end

@interface HWMNewPrivateKeyViewController : UIViewController
/*
 *<# #>
 */
@property(weak,nonatomic)id<HWMNewPrivateKeyViewControllerDelegate>delegate;
@end


