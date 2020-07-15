//
//  HWMImportTheMnemonicWordViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import "HWMImportTheMnemonicWordViewController.h"
#import "HMWImTheMnemonicWordView.h"
#import "HWMSignThePurseViewController.h"

@interface HWMImportTheMnemonicWordViewController ()<HMWImTheMnemonicWordViewDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)HMWImTheMnemonicWordView *ImTheMnemonicWordV;

@end

@implementation HWMImportTheMnemonicWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title = NSLocalizedString(@"导入助记词", nil);
    [self.view addSubview:self.ImTheMnemonicWordV];
    [self.ImTheMnemonicWordV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}
- (HMWImTheMnemonicWordView *)ImTheMnemonicWordV{
    if (!_ImTheMnemonicWordV) {
        _ImTheMnemonicWordV=[[HMWImTheMnemonicWordView alloc]init];
        _ImTheMnemonicWordV.delegate=self;
        _ImTheMnemonicWordV.typeString=@"1";
    }
    return _ImTheMnemonicWordV;
}

-(void)ImTheMnemonicWordViewCompWithWallet:(FLWallet*)wallet{
    if (self.delegate) {
        [self.delegate ImportTheMnemonicWordViewWithMnemonic:wallet.mnemonic withPWD:wallet.passWord withPhrasePassword:wallet.mnemonicPWD];
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HWMSignThePurseViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    
}


@end
