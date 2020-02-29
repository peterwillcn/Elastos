//
//  HWMImportTheMnemonicWordViewController.h
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import <UIKit/UIKit.h>

@protocol HWMImportTheMnemonicWordViewControllerDelegate <NSObject>
-(void)ImportTheMnemonicWordViewWithMnemonic:(NSString*_Nullable)Mnemonic withPWD:(NSString*)PWD withPhrasePassword:(NSString*)phrasePassword;


@end
NS_ASSUME_NONNULL_BEGIN

@interface HWMImportTheMnemonicWordViewController : UIViewController
/*
 *
 */
@property(strong,nonatomic)id<HWMImportTheMnemonicWordViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
