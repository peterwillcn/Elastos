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
@property(strong,nonatomic) NSMutableArray *BudgetsArray;
@property(strong,nonatomic) NSMutableArray *cellDataBudgetsArray;


//xxl 2.3
@property(strong,nonatomic) NSMutableArray *VoteingProposalArray;
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
    self.table.alpha=0.f;
    self.signatureButton.userInteractionEnabled=NO;
    [[HMWCommView share]makeBordersWithView:self.signatureButton];
    [self.signatureButton setTitle:NSLocalizedString(@"签名", nil) forState:UIControlStateNormal];
    
    if(self.VCType == SuggestionType || self.VCType == TheProposalType){ //xxl 2.2
        [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadCRAdviceDetailsWithID:self.PayLoadDic[@"sid"] withComplete:^(id  _Nonnull data) {
            HWMadviceViewModel*adviceViewM =[[HWMadviceViewModel alloc]init];
            [adviceViewM detailsProposalModelDataJosn:data[@"data"] completion:^(HWMadviceModel * _Nonnull model) {
                self.advicemodel=model;
                self.table.userInteractionEnabled=YES;
                self.table.alpha=1.f;
                [self.table reloadData];
                if (self.BudgetsArray.count==0) {
                    [self.suggestionArray addObject:self.defSendArray];
                }else{
                    [self.suggestionArray addObject:self.defArray];
                }
                self. signatureButton.userInteractionEnabled=YES;
            }];
        }];
        
    }else if(self.VCType == TheProposalType){
        
        //xxl 2.3 TODO
        [self setVoteforProposalInfo];
        self. signatureButton.userInteractionEnabled=YES;
        
    }
    else{
        self. signatureButton.userInteractionEnabled=YES;
    }
    
    
    [self.suggestionArray addObjectsFromArray:self.defArray];
    [self makeUI];
}

//xxl 2.3
-(void)setVoteforProposalInfo{
    
    //get proposal info from proposal hash
    
    [self.VoteingProposalArray removeAllObjects];
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]searchReloadCRSuggestionDataSourceWithType:NOTIFICATIONType withStartIndex:0 withNumbers:100 withSearchContent:@"" withComplete:^(id  _Nonnull data) {
        
        
        //get the voting list
        NSLog(@"data is %@",data[@"data"][@"list"]);
        self.VoteingProposalArray = data[@"data"][@"list"];
    
    }];
    
}



-(HWMadviceModel *)advicemodel{
    if (!_advicemodel) {
        _advicemodel =[[HWMadviceModel alloc]init];
    }
    return _advicemodel;
}
-(NSMutableArray *)cellDataBudgetsArray{
    if (!_cellDataBudgetsArray) {
        _cellDataBudgetsArray =[[NSMutableArray  alloc]init];
        NSString *allAmount=@"0";
        for (HWMBudgetsModel *model in self.BudgetsArray) {
            HWMBudgetsModel *fmodel=[[HWMBudgetsModel alloc]init];
            fmodel.Amount=model.Amount;
            fmodel.Stage=model.Stage;
            fmodel.titleString=model.titleString;
            fmodel.Type=model.Type;
            allAmount=[[FLTools share]CRVotingDecimalNumberByAdding:allAmount withCRMermVoting:model.Amount];
            if ([model.Type isEqualToString:@"Imprest"]) {
                fmodel.titleString =NSLocalizedString(@"预付款",nil );
            }else if ([model.Type isEqualToString:@"NormalPayment"]){
                fmodel.titleString =[[FLTools share]StageOfProcessing:model.Stage];
            }else if([model.Type isEqualToString:@"FinalPayment"]){
                fmodel.titleString =NSLocalizedString(@"尾款",nil );
            }
            fmodel.Amount=[NSString stringWithFormat:@"%@ ELA",[[FLTools share]elaScaleConversionWith:model.Amount]];
            [ _cellDataBudgetsArray addObject:fmodel];
        }
        HWMBudgetsModel  *model=[[HWMBudgetsModel  alloc]init];
        model.titleString =NSLocalizedString(@"合计",nil );
        model.Amount=[NSString stringWithFormat:@"%@ ELA",[[FLTools share]elaScaleConversionWith:allAmount]];
        [ _cellDataBudgetsArray insertObject:model atIndex:0];
    }
    return _cellDataBudgetsArray;
}

-(void)makeUI{
    [self.table registerNib:[UINib nibWithNibName:SuggestionCell bundle:nil] forCellReuseIdentifier:SuggestionCell];
    [self.table registerNib:[UINib nibWithNibName:AbstractVCell bundle:nil] forCellReuseIdentifier:AbstractVCell];
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
-(NSArray *)defArray{
    if (!_defArray) {
        _defArray=@[@"标题",NSLocalizedString(@"类型",nil),NSLocalizedString(@"建议哈希",nil),NSLocalizedString(@"发起人DID",nil),NSLocalizedString(@"提案经费账户",nil),NSLocalizedString(@"提案经费额度",nil),NSLocalizedString(@"摘要",nil)];
    }
    return _defArray;
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
    }else if (self.VCType==ReviewProposalType || self.VCType==VoteforProposalType){ //xxl 2.3 todo UI
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
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
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
        cell.constLabel.text=self.PayLoadDic[@"data"][@"recipient"];
        
    }else if ([typStirng isEqualToString:NSLocalizedString(@"提案经费额度",nil)]){
        if (indexPath.row==0) {
            HWMSuggestionSionTableViewCell *Sioncell=[tableView dequeueReusableCellWithIdentifier:SuggestionSionCell];
            Sioncell.selectionStyle= UITableViewCellSelectionStyleNone;
            Sioncell.titleLable.text=typStirng;
            return Sioncell;
        }else{
            HWMSuggestionTableViewCell *SuggesCell=[tableView dequeueReusableCellWithIdentifier:SuggestionCell];
            SuggesCell.selectionStyle= UITableViewCellSelectionStyleNone;
            HWMBudgetsModel *model=self.cellDataBudgetsArray[indexPath.row-1];
            SuggesCell.contenLabel.text=model.Amount;
            SuggesCell.titleLabel.text=model.titleString;
            return SuggesCell;
        }
    }else if ([typStirng isEqualToString:NSLocalizedString(@"摘要",nil)]){
        cell.constLabel.text=self.advicemodel.abs;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"标题",nil)]){
//        cell.titleLabel.text=self.advicemodel.title;
        cell.userInteractionEnabled=YES;
        cell.titleLabel.userInteractionEnabled=YES;
             cell.titleLabel.lineBreakMode= NSLineBreakByTruncatingHead;
        cell.constLabel.text=self.advicemodel.baseInfoString;
        cell.constLabel.textColor=RGBA(255, 255, 255, 0.5);
        [self labletextNumberLineWithLable:cell.titleLabel];
       
    }
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *typStirng=self.suggestionArray[section];
    if([typStirng isEqualToString:NSLocalizedString(@"提案经费额度",nil)]){
        return self.cellDataBudgetsArray.count+1;
    }
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
    self.pwdView=nil;
}
-(void)makeSureWithPWD:(NSString*_Nonnull)PWDString{
    NSNumber *Type;
    [[FLTools share]showLoadingView];
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
    NSString *playloadDicString=[playLoadDic jsonStringEncoded];
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
        @"iat":self.PayLoadDic[@"iat"],
        @"exp":self.PayLoadDic[@"exp"],
        @"aud":self.PayLoadDic[@"iss"],
        @"req":self.jwtString ,
        @"data":String
    };
    return FLDic;
}
-(NSDictionary*)proposalhashRequestFileWithString:(NSString*)String{
    
    
    NSLog(@"proposalhashRequestFileWithString rep %@",self.jwtString);
    
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

-(NSDictionary*)proposalReivewhashRequestFileWithString:(NSString*)String{
    
    
    NSLog(@"proposalReivewhashRequestFileWithString rep %@",self.jwtString);
    
    
    String = [String stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSDictionary *FLDic=@{
        @"command":@"reviewproposal",
        @"type":@"txidproposalreview",
        @"iss":self.currentWallet.didString,
        @"iat": self.PayLoadDic[@"iat"],
        @"exp": self.PayLoadDic[@"exp"],
        @"aud": self.PayLoadDic[@"iss"],
        @"req": self.jwtString,
        @"data":String};
    return FLDic;
}

-(void)updaeJWTInfoWithDic:(NSDictionary*)pare{
    
    
    NSLog(@"calback url %@",self.PayLoadDic[@"callbackurl"]);
    NSLog(@"pare %@",pare);
    
    [HttpUrl NetPOSTHost:self.PayLoadDic[@"callbackurl"] url:@"" header:nil body:pare showHUD:NO WithSuccessBlock:^(id data) {
        [self showSendSuccessOrFial:SignatureSuccessType];
    } WithFailBlock:^(id data) {
        
        NSLog(@"error --- @%",data);
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
    
    if(self.VCType == TheProposalType){
        [self createProposal:pwd];
    }else if(self.VCType == ReviewProposalType){
        [self reviewProposal:pwd];
    }else if(self.VCType == VoteforProposalType){ //xxl 2.3 todo
        //[self voteForProposal:pwd pwd:@"100000000" amount:@(0)];
        [self voteForProposal:pwd pwd:@"100000000"];
        //[self voteForProposal:pwd pwd:@"100000000",0];
    }
    
}

/***
 *voteType  0 CRCProposal 1
 
 */
-(void)voteForProposal:(NSString*) pwd pwd:(NSString*)amount{
    
    //
    NSLog(@"voteForProposal is %@",self.PayLoadDic);
    
    [self showLoading];
    invokedUrlCommand *mommand = [[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID, pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"exportWalletWithMnemonic"];
    PluginResult *result = [[ELWalletManager share]VerifyPayPassword:mommand];
    NSNumber *number = result.status;
    
    if( [number intValue] != CommandStatus_OK){
        NSString *errCode=[NSString stringWithFormat:@"%@", result.message[@"error"][@"message"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return;
    }

    NSDictionary *playLoadDic = @{
        @"ProposalHash":self.PayLoadDic[@"data"][@"proposalHash"],
        @"Amount":amount,
        @"VotingProposal":self.VoteingProposalArray
    };
    
    mommand = [[invokedUrlCommand alloc]initWithArguments:
               @[self.currentWallet.masterWalletID,playLoadDic, pwd]
                                               callbackId:self.currentWallet.walletID
                                                className:@"Wallet"
                                               methodName:@"createProposalForVoteTransaction"];
    
    PluginResult *pluginResult = [[ELWalletManager share] proposalVoteForTransaction:mommand];
    
    NSLog(@"pluginResult is %@",pluginResult);
    
}

-(void)createProposal:(NSString*)pwd{
    
    [self showLoading];
    invokedUrlCommand *mommand = [[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID, pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"exportWalletWithMnemonic"];
    PluginResult *result = [[ELWalletManager share]VerifyPayPassword:mommand];
    NSNumber *number = result.status;
    
    if( [number intValue] != CommandStatus_OK)
    {
        NSString *errCode=[NSString stringWithFormat:@"%@", result.message[@"error"][@"message"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return;
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
        NSDictionary *dic=@{@"Type":Type,@"Stage":[model.Stage numberValue],@"Amount":model.Amount};
        [BArray addObject:dic];
    }
    NSString *signature = self.PayLoadDic[@"data"][@"signature"];
    NSString *CategoryData = self.PayLoadDic[@"data"][@"categoryData"];
    if(!CategoryData)
    {
        CategoryData = @"";
    }
    NSString *didString = self.PayLoadDic[@"data"][@"did"];//[HWMDIDManager shareDIDManager].DIDString;
    didString = [didString stringByReplacingOccurrencesOfString:@"did:elastos:" withString:@""];
    NSDictionary *playLoadDic = @{@"Type":Type,@"CategoryData":CategoryData,@"OwnerPublicKey":self.PayLoadDic[@"data"][@"ownerpublickey"],@"DraftHash":self.PayLoadDic[@"data"][@"drafthash"],@"Budgets":BArray,@"Recipient":self.PayLoadDic[@"data"][@"recipient"], @"CRCouncilMemberDID":didString, @"Signature":signature};
    mommand = [[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID,playLoadDic, pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"createProposalTransaction"];
    
    PluginResult *pluginResult = [[ELWalletManager share] proposaSignTransaction:mommand];
    if(pluginResult){
        NSDictionary *resultDic = pluginResult.message[@"success"];
        NSString *calculateProposalHash = resultDic[@"calculateProposalHash"];
        NSDictionary *callDic = [self callBack:calculateProposalHash pwd:pwd];
        if(callDic){
            [self updaeJWTInfoWithDic:callDic];
        }else{
            [self showSendSuccessOrFial:SignatureFailureType];
        }
    }
    
}
-(void)reviewProposal:(NSString*)pwd{
    [self showLoading];
    invokedUrlCommand *mommand = [[invokedUrlCommand alloc]initWithArguments:@[self.currentWallet.masterWalletID, pwd] callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"exportWalletWithMnemonic"];
    PluginResult *result = [[ELWalletManager share]VerifyPayPassword:mommand];
    NSNumber *number = result.status;
    
    if( [number intValue] != CommandStatus_OK){
        NSString *errCode=[NSString stringWithFormat:@"%@", result.message[@"error"][@"message"]];
        [[FLTools share]showErrorInfo:NSLocalizedString(errCode, nil)];
        return;
    }
    NSNumber *NVoteResult;
    
    if ([self.PayLoadDic[@"data"][@"voteResult"] isEqualToString:@"approve"]) {
        NVoteResult=@(0);
    }else if([self.PayLoadDic[@"data"][@"voteResult"] isEqualToString:@"reject"]){
        NVoteResult=@(1);
    }else{
        NVoteResult=@(2);
    }
    
    NSDictionary *playLoadDic = @{
        @"ProposalHash":self.PayLoadDic[@"data"][@"proposalHash"],
        @"VoteResult":NVoteResult,
        @"OpinionHash":self.PayLoadDic[@"data"][@"opinionHash"],
        @"DID":[self.PayLoadDic[@"data"][@"did"] stringByReplacingOccurrencesOfString:@"did:elastos:" withString:@""]
    };
    
    mommand = [[invokedUrlCommand alloc]initWithArguments:
               @[self.currentWallet.masterWalletID,playLoadDic, pwd]
                                               callbackId:self.currentWallet.walletID
                                                className:@"Wallet"
                                               methodName:@"createProposalReviewTransaction"];
    
    PluginResult *pluginResult = [[ELWalletManager share] proposalReviewTransaction:mommand];
    
    if(pluginResult){
        NSDictionary *resultDic = pluginResult.message[@"success"];
        //[self updaeJWTInfoWithDic:txidDic];
        NSDictionary *callDic = [self callBack:resultDic[@"txid"] pwd:pwd];
        if(callDic)
        {
            [self updaeJWTInfoWithDic:callDic];
        }else {
            [self showSendSuccessOrFial:SignatureFailureType];
        }
    }else{
        [self showSendSuccessOrFial:SignatureFailureType];
    }
    
    
}


- (NSDictionary *)callBack:(NSString *)payString pwd:(NSString *)PWDString
{
    if(payString && ![payString isEqualToString:@""])
    {
        if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:PWDString withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO]){
            
            NSString *playString = @"";
            
            if(self.VCType == TheProposalType){
                playString=[[FLTools share]DicToString:[self proposalhashRequestFileWithString:payString]];
            }else if(self.VCType == ReviewProposalType){
                playString=[[FLTools share]DicToString:[self proposalReivewhashRequestFileWithString:payString]];
            }
            
            NSString *jwtString=[self throuJWTStringWithplayString:playString];
            NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
            if (![REString isEqualToString:@"-1"]) {
                NSDictionary *dic=@{@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]};
                return dic;
            }
        }
        return nil;
    }
}

-(void)showSendSuccessOrFial:(SendSuccessType)type{
    [self closeTransactionDetailsView];
    [self closepwdView];
    [[FLTools share]hideLoadingView];
    self.sendSuccessPopuV.type=type;
    [self.view addSubview:self.sendSuccessPopuV];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeAllSubviews];
        self.sendSuccessPopuV=nil;
        [self.navigationController popViewControllerAnimated:YES];
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
    
    NSArray *bArray=PayLoadDic[@"data"][@"budgets"];
    id json=[bArray jsonStringEncoded];
    bArray=[NSArray modelArrayWithClass:[HWMBudgetsModel class] json:json];
    [self.BudgetsArray  addObjectsFromArray:bArray];
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
        return 50+30;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"发起人DID",nil)]){
        return 80;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"提案经费账户",nil)]){
        return 50;
    }else if ([typStirng isEqualToString:NSLocalizedString(@"提案经费额度",nil)]){
        if (indexPath.row==0) {
            return 50;
        }else{
            return 30;
        }
    }else if ([typStirng isEqualToString:NSLocalizedString(@"摘要",nil)]){
        return self.advicemodel.absCell+50;
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
-(NSMutableArray *)BudgetsArray{
    if (!_BudgetsArray) {
        _BudgetsArray=[[NSMutableArray alloc]init];
    }
    return _BudgetsArray;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hiddLoading];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hiddLoading];
}
-(void)labletextNumberLineWithLable:(UILabel*)titleLabel{
    NSNumber *count  = @((self.advicemodel.baseInfoCell) / titleLabel.font.lineHeight);
    int lineNumber=[count intValue];
    if ( lineNumber>3) {
        titleLabel.numberOfLines=3;
      
    }

    
}

@end
