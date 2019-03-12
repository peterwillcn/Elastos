//
//  HMWverifyTheMnemonicWordViewController.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/7.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWverifyTheMnemonicWordViewController.h"
#import "FLSelectWordView.h"
#import "AppDelegate.h"
#import "FLFLTabBarVC.h"
#import "FLPrepareVC.h"

@interface HMWverifyTheMnemonicWordViewController ()<UITextViewDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)FLSelectWordView *view2;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (nonatomic, copy)NSString *textWord;
@property (weak, nonatomic) IBOutlet UILabel *showInfoTextLabel;
@end

@implementation HMWverifyTheMnemonicWordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@"wallet_bg"];
        [self defultWhite];
    self.title =NSLocalizedString(@"验证助记词", nil);
    self.mnemonic=self.Wallet.mnemonic;
    self.showInfoTextLabel.text=NSLocalizedString(@"请按照顺序点击您的助记词", nil);
    [[HMWCommView share]makeBordersWithView:self.BGView];
    [self.view addSubview:self.view2];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.BGView.mas_bottom).offset(40);
        
    }];
self.textView.delegate=self;
}

-(FLSelectWordView *)view2{
    if (!_view2) {
        _view2  = [[FLSelectWordView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 200)];
        
        NSArray *arr=[self.mnemonic componentsSeparatedByString:@" "];
//        [[FLTools share] stringToArray:self.Wallet.mnemonic];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            WordModel *m = [[WordModel alloc]init];
            m.word = arr[i];
            m.state = 0;
            [array addObject:m];
        }
        
        self.view2.dataSource = array;
//     _view2.dataSource=[]
    __weak __typeof__(self) weakSelf = self;
        _view2.callBack = ^(WordModel *model) {
            
            NSString *str = [model.word stringByAppendingString:@" "];
            if (weakSelf.textWord.length>0) {
                 weakSelf.textWord=[NSString stringWithFormat:@"%@%@",weakSelf.textWord,str];
            }else{
                weakSelf.textWord=str;
                
            }
           
//            [weakSelf.textWord appendString:str];
//            NSLog()
            weakSelf.textView.text = weakSelf.textWord;
        };
        _view2.sureBtnClick = ^{
            [weakSelf compareTextView];
        };
    }
    return _view2;
}
-(void)compareTextView{
    
    BOOL ret = [self.textView.text isEqualToString:[self.mnemonic stringByAppendingString:@" "]];
    if (ret) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"备份成功", nil)];
//        [[FLTools share]copiedToTheClipboardWithString:self.textView.text];
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *rootViewController1 = appdelegate.window.rootViewController;
        if ([rootViewController1.childViewControllers.firstObject isKindOfClass:[FLPrepareVC class]]) {
            
              FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
            appdelegate.window.rootViewController=tabVC;
        }else{
          [[NSNotificationCenter defaultCenter]postNotificationName:updataCreateWallet object:nil ];
      [self.navigationController popToRootViewControllerAnimated:YES];
            
        }
        
    }else{
        [[FLTools share]showErrorInfo:NSLocalizedString(@"你备份的助记词顺序验证错误,请从新校验", nil)];
        NSArray *arr = [self.Wallet.mnemonic componentsSeparatedByString:@" "];
        self.textWord  =@"";
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            WordModel *m = [[WordModel alloc]init];
            m.word = arr[i];
            m.state = 0;
            [array addObject:m];
        }
        self.textView.text = @"";
        self.view2.dataSource = array;
        
    }
}
-(void)setWallet:(FLWallet *)Wallet{
    _Wallet=Wallet;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    [self deleateSelectIndexWordWithshouldChangeText:range];
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    self.textWord=self.textView.text;
}
-(void)deleateSelectIndexWordWithshouldChangeText:(NSRange)range{
    if (self.textWord.length!=0) {
        NSString *cancleWord=[self.textView.text  substringWithRange:range];
        [self.view2 canlceSelectWordModelWithWord:cancleWord];
    }

    
    
}
@end
