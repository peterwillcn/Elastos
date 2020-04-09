//
//  HWMAddPersonalProfileViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/28.
//

#import "HWMAddPersonalProfileViewController.h"
#import "HWMAddSocialAccountViewController.h"
#import "HMWFMDBManager.h"
static NSString *placeHText=@"请输入个人简介（不超过800个字符）";
@interface HWMAddPersonalProfileViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textInfoLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight;
@property (weak, nonatomic) IBOutlet UILabel *infoTextLengthLabel;

@end

@implementation HWMAddPersonalProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    //    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
    self.textInfoLabel.text=NSLocalizedString(@"温馨提示：本页内容均为非必填项。", nil);
    self.infoTextView.delegate=self; self.infoTextView.layer.cornerRadius=5.f;
    self.infoTextView.layer.borderWidth=1.f;
    self.infoTextView.layer.borderColor=RGBA(255, 255, 255, 0.5).CGColor;
    [self.nextButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.nextButton];
    placeHText=NSLocalizedString(@"请输入个人简介（不超过800个字符）", nil);
    if (self.isEidet) {
        self.title=NSLocalizedString(@"编辑个人简介", nil);
        [self.nextButton setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
        self.infoHeight.constant=0.f;
        self.textInfoLabel.alpha=0.f;
        if (self.model.introduction.length>0) {
            self.textInfoLabel.text=self.model.introduction;
            self.infoTextLengthLabel.text=[NSString stringWithFormat:@"%lu/800",(unsigned long)self.model.introduction.length];
        }else{
            self.textInfoLabel.text=@"";
        }
    }else{
        self.title=NSLocalizedString(@"添加个人简介", nil);
        if (self.model.introduction.length>0) {
            self.infoTextView.text=self.model.introduction;
           
        }
        self.infoTextLengthLabel.text=[NSString stringWithFormat:@"%lu/800",(unsigned long)self.model.introduction.length];
    }
}
-(UIButton *)skipButton{
    if (!_skipButton) {
        _skipButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_skipButton setTitle:NSLocalizedString(@"跳过", nil) forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_skipButton addTarget:self action:@selector(skipVCEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}
-(void)skipVCEvent{
    [self.view endEditing:YES];
    if (self.model.introduction.length>0) {
        if (self.block) {
            self.block(self.model);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
- (IBAction)nextAndSkipVC:(id)sender {
    [self skipVCEvent];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([self.infoTextView.text isEqualToString:placeHText]) {
        self.infoTextView.text=@"";
        self.infoTextView.textColor=[UIColor whiteColor];
    }
    
    
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([self.infoTextView.text isEqualToString:placeHText]||self.infoTextView.text.length==0) {
        self.infoTextView.text=placeHText;
        self.infoTextView.textColor=RGBA(255, 255, 255, 0.5);
    }else{
        self.model.introduction=self.infoTextView.text;
    }
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    if (textView.text.length+text.length>800) {
        NSString *subString=[NSString stringWithFormat:@"%@%@",textView.text,text];
        textView.text=[subString substringToIndex:800];
        self.infoTextLengthLabel.text=[NSString stringWithFormat:@"%lu/800",(unsigned long)textView.text.length];
        self.model.introduction=self.infoTextLengthLabel.text;
        return NO;
    }
    
    self.infoTextLengthLabel.text=[NSString stringWithFormat:@"%lu/800",(unsigned long)textView.text.length+text.length];
    self.model.introduction=self.infoTextLengthLabel.text;
    
    return YES;
}
-(void)setModel:(HWMDIDInfoModel *)model{
    _model=model;
}
-(void)setIsEidet:(Boolean)isEidet{
    _isEidet=isEidet;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    
}

@end
