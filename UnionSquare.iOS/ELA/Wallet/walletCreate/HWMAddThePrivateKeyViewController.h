//
//  HWMAddThePrivateKeyViewController.h
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import <UIKit/UIKit.h>

@protocol HWMAddThePrivateKeyViewControllerDelegate <NSObject>

-(void)backWithWord:(NSString*_Nullable)word withPWD:(NSString*_Nonnull)PWD withPhrasePassword:(NSString*)phrasePassword;
-(void)CallbackWithWalletID:(NSString *_Nullable)wallet withXPK:(NSString *_Nullable)XPK withPWD:(NSString * _Nonnull)PWD;
-(void)ImportTheMnemonicWordViewWithMnemonic:(NSString*_Nullable)Mnemonic withPWD:(NSString*_Nonnull)PWD withPhrasePassword:(NSString*)phrasePassword;
@end
@interface HWMAddThePrivateKeyViewController : UIViewController
/*
 *<# #>
 */
@property(weak,nonatomic)id<HWMAddThePrivateKeyViewControllerDelegate> _Nullable delegate;
@end

