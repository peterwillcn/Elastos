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
#import "HWMDIDManager.h"
#import "JWTBase64Coder.h"
//#import "ELAProposalPayloadModel.h"

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
    //xxl 2.2 flow
    }else if (self.VCType == ReviewProposalType){
        self.title=NSLocalizedString(@"审查提案", nil);
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
    }else if (self.VCType==ReviewProposalType){
        //xxl 2.2 flow TODO for UI 
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
    self.pwdView=nil;
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
        NSNumber *Type;
         
         if ([model.Type isEqualToString:@"Imprest"]) {
             Type=@(0);
         }else if ([model.Type isEqualToString:@"NormalPayment"]) {
             Type=@(1);
             
         }else{
             Type=@(2);
         }
        
        NSDictionary *dic=@{@"Type":Type,@"Stage":[model.Stage numberValue],@"Amount":model.Amount};
        [BArray addObject:dic];
    }
    NSDictionary *playLoadDic=@{@"Type":Type,@"CategoryData":self.PayLoadDic[@"data"][@"categorydata"],@"OwnerPublicKey":self.PayLoadDic[@"data"][@"ownerpublickey"],@"DraftHash":self.PayLoadDic[@"data"][@"drafthash"],@"Budgets":BArray,@"Recipient":self.PayLoadDic[@"data"][@"recipient"]};
    
    NSString *playloadDicString = [playLoadDic jsonStringEncoded];
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,playloadDicString,PWDString] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"adviceTheSignature"];
   
    NSString*isSucc= [[ELWalletManager share]adviceTheSignature:mommand];
    if(![isSucc isEqualToString:@"-1"]){
        if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:PWDString withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO]){
        NSString *playString=[[FLTools share]DicToString:[self GenerateTheRequestFileWithString:isSucc]];
            
        NSString *jwtString=[self throuJWTStringWithplayString:playString];
        NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
        if (![REString isEqualToString:@"-1"]) {
            NSDictionary *dic=@{@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]};
            [self updaeJWTInfoWithDic:dic];
        }else{
             [self showSendSuccessOrFial:SignatureFailureType];
        }
        }else{
             [self showSendSuccessOrFial:SignatureFailureType];
        }
    }else{
         [self showSendSuccessOrFial:SignatureFailureType];
    }
}
-(NSDictionary*)GenerateTheRequestFileWithString:(NSString*)String{
    NSDictionary *FLDic=@{
        @"command":@"createsuggestion",
        @"type":@"signature",
        @"iss":self.currentWallet.didString,
        @"iat": self.PayLoadDic[@"iat"],
        @"exp": self.PayLoadDic[@"exp"],
        @"aud": self.PayLoadDic[@"iss"],
        @"req": self.jwtString,
        @"data":String};
    return FLDic;
}
-(NSDictionary*)proposalhashRequestFileWithString:(NSString*)String{
    
    String = [String stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSDictionary *FLDic=@{
        @"command":@"createproposal",
        @"type":@"proposalhash",
        @"iss":self.currentWallet.didString,
        @"iat": self.PayLoadDic[@"iat"],
        @"exp": self.PayLoadDic[@"exp"],
        @"aud": self.PayLoadDic[@"iss"],
        @"req": self.jwtString,
        @"data":String};
    return FLDic;
}
-(void)updaeJWTInfoWithDic:(NSDictionary*)pare{
    
    [HttpUrl NetPOSTHost:self.PayLoadDic[@"callbackurl"] url:@"" header:nil body:pare showHUD:NO WithSuccessBlock:^(id data) {
        NSLog(@"%@",data);
        [self showSendSuccessOrFial:SignatureSuccessType];
      
    } WithFailBlock:^(id data) {
        [self showSendSuccessOrFial:SignatureFailureType];
        
    }];
    
}
-(NSString*)throuJWTStringWithplayString:(NSString*)playString{
    NSString *jwtString;
    NSDictionary * headers = @{@"alg": @"ES256",@"typ": @"JWT"};
    NSString *headerString=[[FLTools share]DicToString:headers];
    headerString=[JWTBase64Coder base64UrlEncodedStringWithData:[headerString dataUsingEncoding:NSUTF8StringEncoding]];
    playString=[JWTBase64Coder base64UrlEncodedStringWithData:[playString dataUsingEncoding:NSUTF8StringEncoding]];
    return jwtString=[NSString stringWithFormat:@"%@.%@",headerString,playString];
    
}

-(HWMTransactionDetailsView *)ShowPoPWDView{
    if (!_ShowPoPWDView) {
        _ShowPoPWDView=[[HWMTransactionDetailsView alloc]init];
        _ShowPoPWDView.delegate=self;
        _ShowPoPWDView.DetailsType=didInfoType;
        [_ShowPoPWDView  TransactionDetailsWithFee:@"0.0001" withTransactionDetailsAumont:nil];
        
    }
    return _ShowPoPWDView;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{
    
    invokedUrlCommand *mommand = [[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID, pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"exportWalletWithMnemonic"];
    
    PluginResult *result = [[ELWalletManager share]VerifyPayPassword:mommand];
    // NSString *status=[NSString stringWithFormat:@"%@",result.status];
    NSNumber *number = result.status;
    
    if( [number intValue] != CommandStatus_OK)
    {
        
        NSString *errCode=[NSString stringWithFormat:@"%@", result.message[@"error"][@"message"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return;;
    }
    
    NSNumber *Type;
    
    if ([self.PayLoadDic[@"data"][@"proposaltype"] isEqualToString:@"normal"]) {
        Type=@(0);
    }else{
        Type=@(1);
        
    }
    NSMutableArray *BArray=[[NSMutableArray alloc]init];
    
    for (HWMBudgetsModel *model in self.BudgetsArray) {
        NSNumber *Type;
        
        if ([model.Type isEqualToString:@"Imprest"])
        {
            Type = [NSNumber numberWithInt:0];
            
        }
        else if ([model.Type isEqualToString:@"NormalPayment"])
        {
            Type = [NSNumber numberWithInt:1];
            
        }
        else if ([model.Type isEqualToString:@"FinalPayment"])
        {
            Type = [NSNumber numberWithInt:2];

        }
      
        NSNumber *number = [NSNumber numberWithInt:[model.Stage intValue]];
        NSDictionary *dic=@{@"Type":Type,@"Stage":number,@"Amount":model.Amount};
        [BArray addObject:dic];
    }
//    did:did:elastos:iXoHtA7V25QSCwo8QpdWZBmMhSTEscoPU
    
    NSString *signature = self.PayLoadDic[@"data"][@"signature"];
    NSString *CategoryData = self.PayLoadDic[@"data"][@"categoryData"];
    if(!CategoryData)
    {
        CategoryData = @"";
    }
    
    
//    signature = [signature stringByReplacingOccurrencesOfString:@"-" withString:@""];
//    signature = [signature stringByReplacingOccurrencesOfString:@"_" withString:@""];
    NSString *didString = self.PayLoadDic[@"data"][@"did"];//[HWMDIDManager shareDIDManager].DIDString;
    didString = [didString stringByReplacingOccurrencesOfString:@"did:elastos:" withString:@""];
    NSDictionary *playLoadDic = @{@"Type":Type,@"CategoryData":CategoryData,@"OwnerPublicKey":self.PayLoadDic[@"data"][@"ownerpublickey"],@"DraftHash":self.PayLoadDic[@"data"][@"drafthash"],@"Budgets":BArray,@"Recipient":self.PayLoadDic[@"data"][@"recipient"], @"CRCouncilMemberDID":didString, @"Signature":signature};
    
//    ELAProposalPayloadModel *model = [ELAProposalPayloadModel mj_objectWithKeyValues:playLoadDic];
//    NSDictionary *statusDict = model.keyValues;
//    self.PayLoadDic[@"data"][@"categorydata"],
//    NSString *playloadDicString = [playLoadDic jsonStringEncoded];
    mommand = [[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,playLoadDic, pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"createProposalTransaction"];
    
    PluginResult *pluginResult = [[ELWalletManager share] proposaSignTransaction:mommand];
    if(pluginResult)
    {
        NSDictionary *resultDic = pluginResult.message[@"success"];
        NSString *signTransaction = resultDic[@"SignTransaction"];
        NSString *calculateProposalHash = resultDic[@"calculateProposalHash"];
        NSDictionary *callDic = [self callBack:calculateProposalHash pwd:pwd];
        if(callDic)
        {
//            NSMutableDictionary *resultCallDic = [[NSMutableDictionary alloc] initWithDictionary:callDic];
//            [resultCallDic setValue:calculateProposalHash forKey:@"data"];
            [self closepwdView];
            [self updaeJWTInfoWithDic:callDic];
        }
        
    }
    
}








- (NSDictionary *)callBack:(NSString *)payString pwd:(NSString *)PWDString
{
    if(payString && ![payString isEqualToString:@""])
    {
           if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:PWDString withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO]){
           NSString *playString=[[FLTools share]DicToString:[self proposalhashRequestFileWithString:payString]];
               
           NSString *jwtString=[self throuJWTStringWithplayString:playString];
           NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
           if (![REString isEqualToString:@"-1"]) {
               NSDictionary *dic=@{@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]};
               return dic;
           }else{
                [self showSendSuccessOrFial:SignatureFailureType];
           }
           }else{
                [self showSendSuccessOrFial:SignatureFailureType];
           }
       }else{
            [self showSendSuccessOrFial:SignatureFailureType];
       }
    return nil;
}
-(void)showSendSuccessOrFial:(SendSuccessType)type{
    UIView *mainView=[self mainWindow];
    self.sendSuccessPopuV.type=type;
    [self.view addSubview:self.sendSuccessPopuV];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self closepwdView];
        [self.sendSuccessPopuV removeAllSubviews];
        self.sendSuccessPopuV=nil;
    });
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
