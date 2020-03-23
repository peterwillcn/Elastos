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
_nib=[UINib nibWithNibName:cellDIDString bundle:nil];
    [self.tabel registerNib:_nib forCellReuseIdentifier:cellDIDString];
    self.tabel.rowHeight=50.f;
    self.tabel.delegate=self;
    self.tabel.dataSource=self;
    self.tabel.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tabel.separatorInset = UIEdgeInsetsZero;
    UIView *headV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 300)];
    [headV addSubview:self.headView];
    self.tabel.tableHeaderView=headV;
    
}
-(HWMDIDAuthorizationHeadView *)headView{
    if (!_headView) {
        _headView =[[HWMDIDAuthorizationHeadView alloc]init];
        _headView.infoDic=self.CRInfoDic;
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
        =@[@{@"text":NSLocalizedString(@"昵称", nil),@"index":@"0",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"性别",nil),@"index":@"1",@"type":@"2",@"state":@"1"},@{@"text":NSLocalizedString(@"出生日期",nil),@"index":@"2",@"type":@"2",@"state":@"1"},@{@"text":NSLocalizedString(@"头像地址",nil),@"index":@"3",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"邮箱",nil),@"index":@"4",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"手机号", nil) ,@"index":@"5",@"type":@"3",@"state":@"1"},@{@"text":NSLocalizedString(@"国家/地区", nil),@"index":@"6",@"type":@"2",@"state":@"1"},@{@"text":NSLocalizedString(@"个人简介",nil),@"index":@"7",@"type":@"4",@"state":@"1"},@{@"text":NSLocalizedString(@"个人主页",nil),@"index":@"8",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"Facebook账号",nil),@"index":@"9",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"Twitter账号",nil),@"index":@"10",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"微博账号",nul),@"index":@"11",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"微信账号",null),@"index":@"12",@"type":@"1",@"state":@"1"},@{@"text":NSLocalizedString(@"Google账号",null),@"index":@"13",@"type":@"1",@"state":@"1"}];
    }
    return _allInfoListArray;

}
-(NSMutableDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic=[[NSMutableDictionary alloc]initWithDictionary:@{@"type":@"credaccess",@"iss":self.DIDString,@"iat":self.CRInfoDic[@"iat"],@"exp":self.CRInfoDic[@"exp"],@"aud":self.CRInfoDic[@"iss"],@"req":self.JWTString,@"presentation":@""}];
    }
    return _infoDic;
}
-(NSString*)throuJWTString{
    NSString *jwtString;
    NSDictionary * headers = @{@"alg": @"ES256",@"typ": @"JWT"};
NSString *headerString=[[FLTools share]DicToString:headers];
   headerString=[JWTBase64Coder base64UrlEncodedStringWithData:[headerString dataUsingEncoding:NSUTF8StringEncoding]];
   NSString *playString=[[FLTools share]DicToString:self.infoDic];
   
    playString=[JWTBase64Coder base64UrlEncodedStringWithData:[playString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return jwtString=[NSString stringWithFormat:@"%@.%@",headerString,playString];
    
}


-(void)goBack{
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
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[self.mastWalletID,pwd] callbackId:self.mastWalletID className:@"Wallet" methodName:@"ExportxPrivateKey"];
               NSString *PrivateKeyString=[[ELWalletManager share]ExportxPrivateKey:mommand];
               if (PrivateKeyString.length>0) {
                   [self cancelThePWDPageView];
                   if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.DIDString WithPrivatekeyString:PrivateKeyString WithmastWalletID:self.mastWalletID]){
                       NSString *jwtString=[self throuJWTString];
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
        [self cancelThePWDPageView];
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
        
        
        
    };
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSourceArray.count;
}
-(void)cancelThePWDPageView{
    [self.pwdPView removeFromSuperview];
    self.pwdPView=nil;
    
}

@end
