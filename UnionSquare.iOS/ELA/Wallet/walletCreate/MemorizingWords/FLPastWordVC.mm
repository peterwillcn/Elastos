//
//  FLPastWordVC.m
//  FLWALLET
//
//  Created by  on 2018/8/15.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLPastWordVC.h"
#import "FLSelectWordView.h"
#import "Masonry.h"
#import "FLSetMenmoryWordPassView.h"
#import "HMWverifyTheMnemonicWordViewController.h"
#import "ELWalletManager.h"
#import "HMWFMDBManager.h"
#import "FMDBWalletModel.h"
#import "sideChainInfoModel.h"
#import "DAConfig.h"
#import "HWMSignThePurseViewController.h"


@interface FLPastWordVC ()<FLSetMenmoryWordPassViewDelegate,HMWverifyTheMnemonicWordVCDelegate>
@property (nonatomic, strong)UITextView *textView;
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UIView *nextView;
@property (nonatomic, strong)FLSelectWordView *view2;
@property (nonatomic, strong)NSMutableString *textWord;
@property (nonatomic, strong)UILabel *lab1;
@property (nonatomic, strong)UILabel *lab2;

@property (nonatomic, copy)NSString *mnemonic;

@property(nonatomic,strong)FLSetMenmoryWordPassView *setPassWordView;
/*
 *<# #>
 */
@property(strong,nonatomic)UILabel *theMnemonicWordLabel;


@end


@implementation FLPastWordVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self defultWhite];
}
-(UILabel *)theMnemonicWordLabel{
    if (!_theMnemonicWordLabel) {
        _theMnemonicWordLabel =[[UILabel alloc]init];
    _theMnemonicWordLabel.textColor=[UIColor whiteColor];
        NSString *languageString=[DAConfig userLanguage];
        if ([languageString  containsString:@"en"]) {
      _theMnemonicWordLabel.numberOfLines=0; _theMnemonicWordLabel.textAlignment=NSTextAlignmentLeft;
            
        }else if ([languageString  containsString:@"zh"]){
        _theMnemonicWordLabel.numberOfLines=2; _theMnemonicWordLabel.textAlignment=NSTextAlignmentCenter;
        }else{
        _theMnemonicWordLabel.numberOfLines=2; _theMnemonicWordLabel.textAlignment=NSTextAlignmentCenter;
        }
        _theMnemonicWordLabel.font=[UIFont systemFontOfSize:13];
    }
    return _theMnemonicWordLabel ;
}
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
     self.theMnemonicWordLabel.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.theMnemonicWordLabel.lineBreakMode];
    [paragraphStyle setAlignment:self.theMnemonicWordLabel.textAlignment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.theMnemonicWordLabel.attributedText = attributedString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
    self.title = NSLocalizedString(@"备份助记词", nil);
    self.textWord = [[NSMutableString alloc]initWithString:@""];
    self.view.backgroundColor=[UIColor whiteColor];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"walllet_copy_word"]];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(101);
        make.centerX.equalTo(self.view);
    }];
__weak __typeof__(self) weakSelf = self;
    NSInteger leftSpace = 20;
    UILabel *la1 = [UIView FLLab_TextColor:[UIColor whiteColor] Fort:15];
    la1.textAlignment = NSTextAlignmentCenter;
    la1.numberOfLines = 2;
    la1.text =NSLocalizedString(@"抄写下您的钱包助记词", nil);
    [self.view addSubview:la1];
    [la1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).offset(20);
        make.left.mas_equalTo(leftSpace);
        make.right.mas_equalTo(-leftSpace);

    }];
    self.lab1 = la1;
    
    UILabel *la2 = [UIView FLLab_TextColor:[UIColor whiteColor] Fort:12];
    la2.textAlignment = NSTextAlignmentCenter;
    la2.numberOfLines = 2;
    la2.text = @"";
    [self.view addSubview:la2];
    [la2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(la1.mas_bottom).offset(4);
        make.left.mas_equalTo(leftSpace);
        make.right.mas_equalTo(-leftSpace);
        
    }];
   
    self.lab2 = la2;

    self.textView = [[UITextView alloc]init];
//    self.mnemonic = [self aes256_decrypt:self.Wallet.mnemonic withKey:FLFLPriviteKey];
//    self.textView.text = self.Wallet.mnemonic;
//    self.textView.textColor = [UIColor whiteColor];
//
//    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.userInteractionEnabled = NO;
    self.textView.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(la1.mas_bottom).offset(30);
        make.left.mas_equalTo(leftSpace);
        make.right.mas_equalTo(-leftSpace);
        make.height.mas_equalTo(150);
    }];
    [self.textView setBackgroundColor:[UIColor clearColor] boldColor:[UIColor whiteColor] corner:0];


    self.nextView = [[UIView alloc]init];
    [self.view addSubview:self.nextView];
    [self.nextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(weakSelf.textView.mas_bottom).offset(20);

    }];

    
    self.setPassWordView = [[NSBundle mainBundle]loadNibNamed:@"FLSetMenmoryWordPassView" owner:self options:nil].lastObject;
    self.setPassWordView.delegate=self;
    self.setPassWordView.VC=self;
    [self.view  addSubview:self.setPassWordView];

    [self.setPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
        make.height.mas_equalTo(230);

    }];
    [self setText:self.Wallet.mnemonic lineSpacing:13];
    [self.textView addSubview:self.theMnemonicWordLabel];
    [self.theMnemonicWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_top).offset(20);
        make.centerX.equalTo(self.nextView.mas_centerX);
        make.size.mas_offset(CGSizeMake(AppWidth-2*leftSpace-20, 110));
    }];

}

-(void)showView2{
__weak __typeof__(self) weakSelf = self;
    self.textView.text = @"";
    self.lab2.text = @"请按顺序点击助记词，以确认你的备份助记词正确";
    self.lab1.text = NSLocalizedString(@"确认你的钱包助记词", nil);
    NSArray *arr = [self.mnemonic componentsSeparatedByString:@" "];
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<arr.count; i++) {
        WordModel *m = [[WordModel alloc]init];
        m.word = arr[i];
        m.state = 0;
        [array addObject:m];
    }

    self.view2.dataSource = array;
    self.view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.view2];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
        make.top.mas_equalTo(weakSelf.textView.mas_bottom).offset(20);
    }];
//    self.nextView.hidden = YES;
}
-(void)compareTextView{
    
    BOOL ret = [self.textView.text isEqualToString:[self.mnemonic stringByAppendingString:@" "]];
    if (ret) {
        
         [[FLTools share]showErrorInfo:NSLocalizedString(@"你备份的助记词顺序验证正确", nil)];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//        if (self.delegate) {
//            [self.delegate backTheWallet:self.Wallet];
//        }
       
    }else{
         [[FLTools share]showErrorInfo:NSLocalizedString(@"你备份的助记词顺序验证错误,请从新校验", nil)];
        NSArray *arr = [self.mnemonic componentsSeparatedByString:@" "];
        self.textWord  = [NSMutableString string];
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
-(FLSelectWordView *)view2{
   __weak __typeof__(self) weakSelf = self;
    if (!_view2) {
        _view2  = [[FLSelectWordView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 200)];
        _view2.callBack = ^(WordModel *model) {
            
            NSString *str = [model.word stringByAppendingString:@" "];
            [weakSelf.textWord appendString:str];
            weakSelf.textView.text = weakSelf.textWord;
        };
        _view2.sureBtnClick = ^{
            [weakSelf compareTextView];
        };
    }
    return _view2;
}
-(void)theNextStepDWithPWD:(NSString *)pwd{
      self.Wallet.mnemonicPWD=pwd;
    if (self.Wallet.masterWalletID.length==6) {
        HMWverifyTheMnemonicWordViewController *verifyTheMnemonicWordVC=[[HMWverifyTheMnemonicWordViewController alloc]init];
        verifyTheMnemonicWordVC.Wallet=self.Wallet;
        verifyTheMnemonicWordVC.FormeType=@"1";
        verifyTheMnemonicWordVC.delegate=self;
        [self.navigationController pushViewController:verifyTheMnemonicWordVC animated:YES];
    }else{
    
            [self creatWallet];
        
    }
    
    
}
-(void)creatWallet{
    self.Wallet.walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    
    self.Wallet.masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:self.Wallet.walletID];
    
    
    HMWverifyTheMnemonicWordViewController *verifyTheMnemonicWordVC=[[HMWverifyTheMnemonicWordViewController alloc]init];
    verifyTheMnemonicWordVC.Wallet=self.Wallet;
    verifyTheMnemonicWordVC.FormeType=@"1";
    verifyTheMnemonicWordVC.createType=self.createType;
    verifyTheMnemonicWordVC.delegate=self;
    [self.navigationController pushViewController:verifyTheMnemonicWordVC animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
-(void)setCreateType:(NSInteger)createType{
    _createType=createType;
    
}
-(void)backTheWallet:(FLWallet *)wallet{
    if (self.delegate) {
        [self.delegate backTheWallet:wallet];
    }
    
}
@end
