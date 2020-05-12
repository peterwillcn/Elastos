//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import "HWMSuggestionViewController.h"
#import "HWMSuggestionTableViewCell.h"
#import "HWMSuggestionSionTableViewCell.h"
#import "HWMSecureAuthenticationPasswordView.h"
#import "HWMTransactionDetailsView.h"
#import "HMWSendSuccessPopuView.h"

static NSString *SuggestionCell=@"HWMSuggestionTableViewCell";
static NSString *SuggestionSionCell=@"HWMSuggestionSionTableViewCell";
@interface HWMSuggestionViewController ()<UITableViewDelegate,UITableViewDataSource,HWMSecureAuthenticationPasswordViewDelegate,HWMTransactionDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *signatureButton;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property(strong,nonatomic) NSMutableArray *suggestionArray;

@property(strong,nonatomic)HWMSecureAuthenticationPasswordView *pwdView;
@property(strong,nonatomic)HWMTransactionDetailsView *ShowPoPWDView;

@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;

@end

@implementation HWMSuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    if (self.VCType==SuggestionType) {
        self.title=NSLocalizedString(@"发起建议", nil);
    }else if (self.VCType==TheProposalType){
        self.title=NSLocalizedString(@"发起提案", nil);
    }
    [[HMWCommView share]makeBordersWithView:self.signatureButton];
    [self.signatureButton setTitle:NSLocalizedString(@"签名", nil) forState:UIControlStateNormal];
}
-(void)makeUI{
    [self.table registerNib:[UINib nibWithNibName:SuggestionCell bundle:nil] forCellReuseIdentifier:SuggestionCell];
    [self.table registerNib:[UINib nibWithNibName:SuggestionSionCell bundle:nil] forCellReuseIdentifier:SuggestionSionCell];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate =self;
    self.table.dataSource =self;
    [self.view addSubview:self.table];
    
}
-(NSMutableArray *)suggestionArray{
    if (!_suggestionArray) {
        _suggestionArray =[[NSMutableArray alloc]init];
    }
    return _suggestionArray;
}
- (IBAction)signatureEvent:(id)sender {
    UIView *mainView =[self mainWindow];
    if (self.VCType==SuggestionType) {
        [mainView addSubview:self.pwdView];
        [self.pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }else if (self.VCType==TheProposalType){
        [mainView addSubview:self.ShowPoPWDView];
        [self.ShowPoPWDView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(mainView);
        }];
    }
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        HWMSuggestionSionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SuggestionSionCell];
        return cell;
    }
    HWMSuggestionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SuggestionCell];
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(void)setVCType:(SuggestionVCType)VCType{
    _VCType=VCType;
}
-(HWMSecureAuthenticationPasswordView *)pwdView{
    
    if (!_pwdView) {
        _pwdView=[[HWMSecureAuthenticationPasswordView alloc]init];
        _pwdView.delegate=self;
    }
    return _pwdView;
}
-(void)closepwdView{
    [self.pwdView removeFromSuperview];
    self.pwdView.alpha=0.f;
}
-(void)makeSureWithPWD:(NSString*_Nonnull)PWDString{
    
}
-(HWMTransactionDetailsView *)ShowPoPWDView{
    if (!_ShowPoPWDView) {
        _ShowPoPWDView=[[HWMTransactionDetailsView alloc]init];
        _ShowPoPWDView.delegate=self;
        _ShowPoPWDView.DetailsType=didInfoType;
        
    }
    return _ShowPoPWDView;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{
    
}
-(void)closeTransactionDetailsView{
    [self.ShowPoPWDView removeFromSuperview];
    self.ShowPoPWDView =nil;
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV=[[HMWSendSuccessPopuView alloc]init];
    }
    return _sendSuccessPopuV;
}
@end
