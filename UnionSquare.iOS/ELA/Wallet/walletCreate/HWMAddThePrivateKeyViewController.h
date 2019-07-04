//
//  HWMAddThePrivateKeyViewController.h
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/3.
//

#import <UIKit/UIKit.h>

@protocol HWMAddThePrivateKeyViewControllerDelegate <NSObject>

-(void)backWithWord:(NSString*_Nullable)word withPWD:(NSString*_Nonnull)PWD;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HWMAddThePrivateKeyViewController : UIViewController
/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMAddThePrivateKeyViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
