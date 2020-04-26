//
//  HWMDIDAuthorizationViewController.m
//  elastos wallet
//
//  Created by  on 2020/3/16.
//

#import "HWMDIDAuthorizationViewController.h"
#import "ELWalletManager.h"
#import "HWMDIDManager.h"
#import "NSImage+WebCache.h"
#import "HMWpwdPopupView.h"
#import "NSString+YYAdd.h"
#import "JWT.h"
#import "HttpUrl.h"
#import "HWMDIDAuthorizationTableViewCell.h"
#import "HWMDIDAuthorizationHeadView.h"

static NSString *cellDIDString=@"HWMDIDAuthorizationTableViewCell";

UINib *_nib;
@interface HWMDIDAuthorizationViewController ()<HMWpwdPopupViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *AgreedToButton;
@property (weak, nonatomic) IBOutlet UIButton *RefusedToButon;
@property (weak, nonatomic) IBOutlet UITableView *tabel;
@property(strong,nonatomic)NSMutableArray *dataSourceArray;
@property(strong,nonatomic)NSMutableDictionary *infoDic;
@property(copy,nonatomic)NSArray *allInfoListArray;
@property(strong,nonatomic)HMWpwdPopupView *pwdPView;
@property(strong,nonatomic)HWMDIDAuthorizationHeadView *headView;
@property(strong,nonatomic)HWMDIDInfoModel *updateModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOffset;

@end

@implementation HWMDIDAuthorizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"vote_rule_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    [self setBackgroundImg:@""];
    [self makeUI];
    
}
-(void)makeUI{
    [self.AgreedToButton setTitle:NSLocalizedString(@"同意", nil) forState:UIControlStateNormal];
    [self.RefusedToButon setTitle:NSLocalizedString(@"拒绝", nil) forState:UIControlStateNormal];
    [[HMWCommView share]makeBordersWithView:self.AgreedToButton];
    [[HMWCommView share]makeBordersWithView:self.RefusedToButon];
    _nib=[UINib nibWithNibName:cellDIDString bundle:nil];
    [self.tabel registerNib:_nib forCellReuseIdentifier:cellDIDString];
    self.tabel.rowHeight=50.f;
    self.tabel.delegate=self;
    self.tabel.dataSource=self;
    self.tabel.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tabel.separatorInset = UIEdgeInsetsZero;
    CGFloat height=300;
    self.topOffset.constant=300;
    if (self.readModel) {
         self.topOffset.constant=260;
        height=260;
    }
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(self.topOffset.constant));
    }];
//    UIView *headV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, height)];
//    [headV addSubview:self.headView];
//    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.right.equalTo(headV);
//    }];
//    self.tabel.tableHeaderView=headV;
}
-(HWMDIDAuthorizationHeadView *)headView{
    if (!_headView) {
        _headView =[[HWMDIDAuthorizationHeadView alloc]init];
        if (self.MemberOfTheUpdate) {
            _headView.readModel=self.readModel;
        }else{
            _headView.infoDic=self.CRInfoDic;
        }
    }
    return _headView;
}
-(NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray =[[NSMutableArray alloc]initWithArray:self.allInfoListArray];
    }
    return _dataSourceArray;
}
-(NSArray *)allInfoListArray{
    if (!_allInfoListArray) {
        _allInfoListArray
        =@[@{@"text":NSLocalizedString(@"性别",nil),@"index":@"1",@"type":@"2",@"state":@"1"},@{@"text":NSLocalizedString(@"出生日期",nil),@"index":@"2",@"type":@"2",@"state":@"1"},@{@"text":NSLocalizedString(@"头像地址",nil),@"index":@"3",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"邮箱1",nil),@"index":@"4",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"个人简介",nil),@"index":@"7",@"type":@"4",@"state":@"1"},@{@"text":NSLocalizedString(@"个人主页",nil),@"index":@"8",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"Facebook账号",nil),@"index":@"9",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"Twitter账号",nil),@"index":@"10",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"微博账号",nul),@"index":@"11",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"微信账号",null),@"index":@"12",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"谷歌账号",null),@"index":@"13",@"type":@"1",@"state":@"1"}];
    }
    return _allInfoListArray;
    
}
-(NSMutableDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"type":@"credaccess",@"iss":self.DIDString,@"iat":self.CRInfoDic[@"iat"],@"exp":self.CRInfoDic[@"exp"],@"aud":self.CRInfoDic[@"iss"],@"req":self.JWTString,@"presentation":@""}];
    }
    return _infoDic;
}
-(NSString*)throuJWTStringWithplayString:(NSString*)playString{
    NSString *jwtString;
    NSDictionary * headers = @{@"alg": @"ES256",@"typ": @"JWT"};
    NSString *headerString=[[FLTools share]DicToString:headers];
    headerString=[JWTBase64Coder base64UrlEncodedStringWithData:[headerString dataUsingEncoding:NSUTF8StringEncoding]];
    playString=[JWTBase64Coder base64UrlEncodedStringWithData:[playString dataUsingEncoding:NSUTF8StringEncoding]];
    return jwtString=[NSString stringWithFormat:@"%@.%@",headerString,playString];
    
}


-(void)goBack{
    [self hiddLoading];
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)copyDIDStringEvent:(id)sender {
    if (self.DIDString.length>0) {
        [[FLTools share]showErrorInfo:NSLocalizedString(@"已复制到剪切板。", nil)];
        [[FLTools share]copiedToTheClipboardWithString:self.DIDString];
    }
}

- (IBAction)AgreedToEvent:(id)sender {
    
    UIView *mainView =[self mainWindow];
    [mainView addSubview:self.pwdPView];
    [self.pwdPView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
}
- (IBAction)RefusedToEvent:(id)sender {
    [self goBack];
}
-(void)setMastWalletID:(NSString *)mastWalletID{
    _mastWalletID=mastWalletID;
}
-(void)setDIDString:(NSString *)DIDString{
    _DIDString=DIDString;
}
-(void)setCRInfoDic:(NSDictionary *)CRInfoDic{
    _CRInfoDic=CRInfoDic;
}
-(HMWpwdPopupView *)pwdPView{
    if (!_pwdPView) {
        _pwdPView=[[HMWpwdPopupView alloc]init];
        _pwdPView.backgroundColor=RGBA(0,0,0,0.2);
        _pwdPView.delegate=self;
    }
    return _pwdPView;
}
-(void)makeSureWithPWD:(NSString*)pwd{
    [self showLoading];
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.mastWalletID,pwd] callbackId:self.mastWalletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
    NSString *PrivateKeyString=[[ELWalletManager share]ExportxPrivateKey:mommand];
    if (PrivateKeyString.length==0) {
        [self hiddLoading];
        return;
    }
    if (self.MemberOfTheUpdate) {
        [[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.DIDString WithPrivatekeyString:PrivateKeyString WithmastWalletID:self.mastWalletID needCreatDIDString:NO];
        [ self  POSTJWTInfoWithDic];
    }else{
        
        if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.DIDString WithPrivatekeyString:PrivateKeyString WithmastWalletID:self.mastWalletID needCreatDIDString:NO]){
            NSString *playString=[[FLTools share]DicToString:self.infoDic];
            NSString *jwtString=[self throuJWTStringWithplayString:playString];
            NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
            if (![REString isEqualToString:@"-1"]) {
                NSDictionary *dic=@{@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]};
                [self updaeJWTInfoWithDic:dic];
            }
        }
    }
}
-(void)updaeJWTInfoWithDic:(NSDictionary*)pare{
    [HttpUrl NetPOSTHost:self.CRInfoDic[@"callbackurl"] url:@"" header:nil body:pare showHUD:NO WithSuccessBlock:^(id data) {
        [self hiddLoading];
        [self cancelThePWDPageView];
        [self goBack];
        [[FLTools share]showErrorInfo:@"授权成功"];
    } WithFailBlock:^(id data) {
        
        
    }];
    
}
-(void)POSTJWTInfoWithDic{
    NSString *infoString=[[HWMDIDManager shareDIDManager]generateDIDCredentialString];
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[[FLTools share]dictionaryWithJsonString:infoString]];
    self.updateModel.nickname=@"";
    self.updateModel.phoneCode=@"";
    self.updateModel.nation=@"";
    self.updateModel.editTime=@"";
    NSString *updaModelString=[self.updateModel modelToJSONString];
    NSDictionary *upDic=[[FLTools share]dictionaryWithJsonString:updaModelString];
    NSMutableDictionary *updaModelDic=[NSMutableDictionary dictionaryWithDictionary:upDic];
    [updaModelDic setValue:dic[@"credentialSubject"][@"id"] forKey:@"id"];
    [dic setValue:updaModelDic forKey:@"credentialSubject"];
    infoString=[[FLTools share]DicToString:dic];
    NSString *jwtString=[self throuJWTStringWithplayString:infoString];
    
    NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
    NSString *httpIP=[[FLTools share]http_IpFast];
    [HttpUrl NetPOSTHost:httpIP url:@"/api/dposnoderpc/check/jwtsave" header:@{} body:@{@"did":self.DIDString,@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]} showHUD:NO WithSuccessBlock:^(id data) {
        [self hiddLoading];
        
        [self cancelThePWDPageView];
        [[FLTools share]showErrorInfo:@"更新成功"];
        [self goBack];
      
    } WithFailBlock:^(id data) {
        
    }];
    
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HWMDIDAuthorizationTableViewCell *cell=[_nib instantiateWithOwner:nil options:nil][0];
    __weak __typeof__ (self) weakSelf = self;
    cell.dic=[NSMutableDictionary dictionaryWithDictionary:self.dataSourceArray[indexPath.row]];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    cell.selectBlock = ^(NSDictionary * _Nullable dic) {
        NSInteger index=[dic[@"index"] integerValue];
        weakSelf.dataSourceArray[index]=dic;
        [weakSelf updatePOSTModeInfoWithDic:dic];
        
    };
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.MemberOfTheUpdate) {
        return  self.dataSourceArray.count;
    }
    return 0;
}
-(void)cancelThePWDPageView{
    [self.pwdPView removeFromSuperview];
    self.pwdPView=nil;
    
}
-(HWMDIDInfoModel *)updateModel{
    if (!_updateModel) {
        _updateModel=self.readModel;
    }
    return _updateModel;
}
-(void)updatePOSTModeInfoWithDic:(NSDictionary*)dic{
    NSString *textString=dic[@"text"];
    NSString *state=dic[@"state"];
    self.updateModel.nickname=@"";
    self.updateModel.phone=@"";
    self.updateModel.phoneCode=@"";
    //    if ([textString isEqualToString:NSLocalizedString(@"昵称", nil)]&&self.readModel.nickname.length>0){
    //        if ([state isEqualToString:@"1"]) {
    //            self.updateModel.nickname=self.readModel.nickname;
    //        }else{
    //            self.updateModel.nickname=@"";
    //        }
    //
    //    }else
    if ([textString isEqualToString:NSLocalizedString(@"性别", nil)]&&self.readModel.gender.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.gender=self.readModel.gender;
        }else{
            self.updateModel.gender=@"";
        }
    }else if ([textString isEqualToString:NSLocalizedString(@"出生日期", nil)]&&self.readModel.birthday.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.birthday=self.readModel.birthday;
        }else{
            self.updateModel.birthday=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"头像地址", nil)]&&self.readModel.avatar.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.avatar=self.readModel.avatar;
        }else{
            self.updateModel.avatar=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"邮箱", nil)]&&self.readModel.email.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.email=self.readModel.email;
        }else{
            self.updateModel.email=@"";
        }
        
    }
    //    else if ([textString isEqualToString:NSLocalizedString(@"手机号", nil)]&&self.readModel.phone.length>0) {
    //        if ([state isEqualToString:@"1"]) {
    //            self.updateModel.phone=self.readModel.phone;
    //            self.updateModel.phoneCode=self.readModel.phoneCode;
    //        }else{
    //            self.updateModel.phone=@"";
    //            self.updateModel.phoneCode=@"";
    //        }
    //
    //
    //    }
    else if ([textString isEqualToString:NSLocalizedString(@"国家/地区", nil)]&&self.readModel.nation.length>0) {
        
        if ([state isEqualToString:@"1"]) {
            self.updateModel.nation=self.readModel.nation;
            
        }else{
            self.updateModel.nation=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"个人简介", nil)]&&self.readModel.introduction.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.introduction=self.readModel.introduction;
            
        }else{
            self.updateModel.introduction=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"个人主页", nil)]&&self.readModel.homePage.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.homePage=self.readModel.homePage;
            
        }else{
            self.updateModel.homePage=@"";
        }
        
        
    }else if ([textString isEqualToString:NSLocalizedString(@"Facebook账号", nil)]&&self.readModel.facebook.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.facebook=self.readModel.facebook;
            
        }else{
            self.updateModel.facebook=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"Twitter账号", nil)]&&self.readModel.twitter.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.twitter=self.readModel.twitter;
            
        }else{
            self.updateModel.twitter=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"微博账号", nil)]&&self.readModel.weibo.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.weibo=self.readModel.weibo;
            
        }else{
            self.updateModel.weibo=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"微信账号", nil)]&&self.readModel.wechat.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.wechat=self.readModel.wechat;
            
        }else{
            self.updateModel.wechat=@"";
        }
        
    }else if ([textString isEqualToString:NSLocalizedString(@"谷歌账号", nil)]&&self.readModel.googleAccount.length>0) {
        if ([state isEqualToString:@"1"]) {
            self.updateModel.googleAccount=self.readModel.googleAccount;
            
        }else{
            self.updateModel.googleAccount=@"";
        }
    }
    
    
    
}

-(void)setReadModel:(HWMDIDInfoModel *)readModel{
    _readModel=readModel;
}
@end
