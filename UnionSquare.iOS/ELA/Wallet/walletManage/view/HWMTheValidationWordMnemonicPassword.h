//
//  HWMTheValidationWordMnemonicPassword.h
//  elastos wallet
//
//  Created by  on 2019/8/21.
//

#import <UIKit/UIKit.h>

@protocol HWMTheValidationWordMnemonicPasswordDelegate <NSObject>

-(void)closeView;
-(void)MandatoryDeleteWithPWD:(NSString*)PWD;

@end

@interface HWMTheValidationWordMnemonicPassword : UIView

/*
 *<# #>
 */
@property(strong,nonatomic)id<HWMTheValidationWordMnemonicPasswordDelegate> delegate;
@end
