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
#import "HWMCRSuggestionNetWorkManger.h"
#import "HWMadviceViewModel.h"
#import "HWMadviceModel.h"
#import "HWMAbstractTableViewCell.h"
#import "HWMBudgetsModel.h"
#import "ELWalletManager.h"

static NSString *SuggestionCell=@"HWMSuggestionTableViewCell";
static NSString *SuggestionSionCell=@"HWMSuggestionSionTableViewCell";
static NSString *AbstractVCell=@"HWMAbstractTableViewCell";

@interface HWMSuggestionViewController ()<UITableViewDelegate,UITableViewDataSource,HWMSecureAuthenticationPasswordViewDelegate,HWMTransactionDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *signatureButton;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property(strong,nonatomic) NSMutableArray *suggestionArray;
@property(copy,nonatomic) NSArray *defArray;
@property(copy,nonatomic) NSArray *defSendArray;
@property(strong,nonatomic)HWMSecureAuthenticationPasswordView *pwdView;
@property(strong,nonatomic)HWMTransactionDetailsView *ShowPoPWDView;

@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@property(strong,nonatomic)HWMadviceModel *advicemodel;
@property(copy,nonatomic) NSArray *BudgetsArray;

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
    
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadCRAdviceDetailsWithID:self.PayLoadDic[@"sid"] withComplete:^(id  _Nonnull data) {
        HWMadviceViewModel*adviceViewM =[[HWMadviceViewModel alloc]init];
        [adviceViewM detailsProposalModelDataJosn:data[@"data"] completion:^(HWMadviceModel * _Nonnull model) {
            self.advicemodel=model;
            [self.table reloadData];
        }];
    }];
    [self.suggestionArray addObjectsFromArray:self.defArray];
    [self makeUI];
}
-(HWMadviceModel *)advicemodel{
    if (!_advicemodel) {
        _advicemodel =[[HWMadviceModel alloc]init];
    }
    return _advicemodel;
}
-(void)makeUI{
    //    [self.table registerNib:[UINib nibWithNibName:SuggestionCell bundle:nil] forCellReuseIdentifier:SuggestionCell];
    [self.table registerNib:[UINib nibWithNibName:AbstractVCell bundle:nil] forCellReuseIdentifier:AbstractVCell];
    //    [self.table registerNib:[UINib nibWithNibName:SuggestionSionCell bundle:nil] forCellReuseIdentifier:SuggestionSionCell];
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
-(NSArray *)defArray{
    if (!_defArray) {
        _defArray=@[@"标题",NSLocalizedString(@"类型",nil),NSLocalizedString(@"建议哈希",nil),NSLocalizedString(@"发起人DID",nil),NSLocalizedString(@"提案经费账户",nil),NSLocalizedString(@"提案经费额度",nil),NSLocalizedString(@"摘要",nil)];
    }
    return _defArray;;
}
-(NSArray *)defSendArray{
    if (!_defSendArray) {
        _defSendArray=@[@"标题",NSLocalizedString(@"类型",nil),NSLocalizedString(@"建议哈希",nil),NSLocalizedString(@"发起人DID",nil),NSLocalizedString(@"摘要",nil)];
    }
    return _defSendArray;
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
    
    NSString *typStirng=self.suggestionArray[indexPath.section];
    HWMAbstractTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:AbstractVCell];
    cell.titleLabel.text=typStirng;
    cell.titleLabel.textColor=[UIColor whiteColor];
    cell.constLabel.textColor=[UIColor whiteColor];
    if ([typStirng isEqualToString:NSLocalizedString(@"类型",nil)]) {
        if ([self.PayLoadDic[@"data"][@"proposaltype"] isEqualToString:@"normal"]) {
            cell.constLabel.text=NSLocalizedString(@"普通",nil);
        }else{
            cell.constLabel.text=@"ELIP";
        }
    }else if ([typStirng isEqualToString:NSLocalizedString(@"建议哈希",nil)]){
        cell.constLabel.text=self.PayLoadDic[@"data"][@"drafthash"];
    }else if ([typStirng isEqualToString:NSLocalizedString(@"发起人DID",nil)]){
        cell.constLabel.text=self.PayLoadDic[@"iss"];
    }else if ([typStirng isEqualToString:NSLocalizedString(@"提案经费账户",nil)]){
    }else if ([typStirng isEqualToString:NSLocalizedString(@"提案经费额度",nil)]){
    }else if ([typStirng isEqualToString:NSLocalizedString(@"摘要",nil)]){
        cell.constLabel.text=self.advicemodel.abs;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"标题",nil)]){
        cell.titleLabel.text=self.advicemodel.title;
        cell.constLabel.text=self.advicemodel.baseInfoString;
        cell.constLabel.textColor=RGBA(255, 255, 255, 0.5);
    }
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.suggestionArray.count;
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
    NSNumber *Type;
    if ([self.PayLoadDic[@"data"][@"proposaltype"] isEqualToString:@"normal"]) {
        Type=@(0);
    }else{
        Type=@(1);
        
    }
    NSMutableArray *BArray=[[NSMutableArray alloc]init];
    for (HWMBudgetsModel *model in self.BudgetsArray) {
        NSDictionary *dic=@{@"Type":model.Type,@"Stage":model.Stage,@"type":model.Type};
        [BArray addObject:dic];
    }
    NSDictionary *playLoadDic=@{@"Type":Type,@"CategoryData":@"",@"OwnerPublicKey":self.PayLoadDic[@"data"][@"ownerpublickey"],@"DraftHash":self.PayLoadDic[@"data"][@"drafthash"],@"Budgets":BArray,@"Recipient":self.PayLoadDic[@"data"][@"recipient"]};
    NSString *playloadDicString=[playLoadDic jsonStringEncoded];
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,playloadDicString] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"adviceTheSignature"];
    BOOL isSucc= [[ELWalletManager share]adviceTheSignature:mommand];
    
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
-(void)setPayLoadDic:(NSDictionary *)PayLoadDic{
    
    self.BudgetsArray=PayLoadDic[@"data"][@"budgets"];
    id json=[self.BudgetsArray jsonStringEncoded];
    self.BudgetsArray=[NSArray modelArrayWithClass:[HWMBudgetsModel class] json:json];
    _PayLoadDic=PayLoadDic;
}
-(void)setJwtString:(NSString *)jwtString{
    _jwtString=jwtString;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *typStirng=self.suggestionArray[indexPath.section];
    
    if ([typStirng isEqualToString:NSLocalizedString(@"类型",nil)]) {
        return 50;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"建议哈希",nil)]){
        return 50;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"发起人DID",nil)]){
        return 100;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"提案经费账户",nil)]){
        return 50;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"提案经费额度",nil)]){
        return 50;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"摘要",nil)]){
        return self.advicemodel.absCell+30;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"标题",nil)]){
        return  self.advicemodel.baseInfoCell+50;
    }
    return 40;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (NSArray *)BudgetsArray{
    if (!_BudgetsArray) {
        _BudgetsArray =[[NSArray alloc]init];
        
    }
    return _BudgetsArray;
}

@end
