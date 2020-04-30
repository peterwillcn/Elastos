//
//  HWMSignTheWalletListViewController.h
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import <UIKit/UIKit.h>


@protocol HWMSignTheWalletListViewControllerDelegate <NSObject>

-(void)CallbackWithWalletID:(NSString*_Nullable)wallet withXPK:(NSString*_Nullable)XPK withPWD:(NSString*_Nonnull)PWD;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HWMSignTheWalletListViewController : UIViewController
/*
 *<# #>
 */
@property(weak,nonatomic)id<HWMSignTheWalletListViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
