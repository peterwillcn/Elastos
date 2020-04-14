//
//  HMWImportTheWalletViewController.m
//  ELA
//
//  Created by  on 2019/1/4.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWImportTheWalletViewController.h"
#import "HMWImTheMnemonicWordView.h"
#import "HMWImKeystoreView.h"
#import "ELWalletManager.h"
#import "AppDelegate.h"
#import "FLFLTabBarVC.h"
#import "FLPrepareVC.h"
#import "BaseNavigationVC.h"
#import "FirstViewController.h"
#import "HMWFMDBManager.h"
#import "FMDBWalletModel.h"
#import "sideChainInfoModel.h"



@interface HMWImportTheWalletViewController ()<HMWImTheMnemonicWordViewDelegate,HMWImKeystoreViewDeleagte>
/*
 *<# #>
 */
@property(strong,nonatomic)HMWImTheMnemonicWordView *imTheMnemonicWordV;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWImKeystoreView *imKeystoreV;
@property (weak, nonatomic) IBOutlet UISegmentedControl *wordMnemonicOrKeystoreSegmentedCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOffSet;

@end

@implementation HMWImportTheWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"导入钱包", nil);
    [self.view addSubview:self.imKeystoreV];
    self.imKeystoreV.alpha=0.f;
    CGFloat topOff=100;
    if (AppHeight>812) {
        topOff=125;
        self.topOffSet.constant=95;
    }
    [self.imKeystoreV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(topOff);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self.view insertSubview:self.imTheMnemonicWordV aboveSubview:self.imKeystoreV];
    [self.view addSubview:self.imTheMnemonicWordV];
    
    [self.imTheMnemonicWordV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(topOff);
        make.left.right.bottom.equalTo(self.view);
    }];
//  
    [self.wordMnemonicOrKeystoreSegmentedCon addTarget:self action:@selector(wordMnemonicOrKeystoreEvent) forControlEvents:UIControlEventValueChanged];
    [[HMWCommView share]makeBordersWithView:self.wordMnemonicOrKeystoreSegmentedCon];
    [self.wordMnemonicOrKeystoreSegmentedCon setTitle:NSLocalizedString(@"助记词", nil) forSegmentAtIndex:0];
    UIColor *greenColor = [UIColor whiteColor];
    NSDictionary *colorAttr = [NSDictionary dictionaryWithObject:greenColor forKey:NSForegroundColorAttributeName];
    [self.wordMnemonicOrKeystoreSegmentedCon setTitleTextAttributes:colorAttr forState:UIControlStateNormal];
    
    
}
-(void)wordMnemonicOrKeystoreEvent{
    NSInteger selIndex=self.wordMnemonicOrKeystoreSegmentedCon.selectedSegmentIndex;
    
    switch (selIndex) {
        case 0:
        {
            self.imTheMnemonicWordV.alpha=1.f;
              self.imKeystoreV.alpha=0.f;
          
            break;
            
        }
        case 1:
        {
            self.imTheMnemonicWordV.alpha=0.f;
            self.imKeystoreV.alpha=1.f;
            break;
            
        }
            
        default:
            break;
    }
    
    
}

    



-(HMWImKeystoreView *)imKeystoreV{
    if (!_imKeystoreV) {
        _imKeystoreV=[[HMWImKeystoreView alloc]init];
        _imKeystoreV.delegate=self;
        _imKeystoreV.VC=self;
    }
         return _imKeystoreV;
}
-(HMWImTheMnemonicWordView *)imTheMnemonicWordV{
    if (!_imTheMnemonicWordV) {
        _imTheMnemonicWordV =[[HMWImTheMnemonicWordView alloc]init];
        _imTheMnemonicWordV.delegate=self;
        _imTheMnemonicWordV.VC=self;
//        [[HMWCommView share]makeBordersWithView:_imTheMnemonicWordV];
        
    }
    
    return _imTheMnemonicWordV;
}
#pragma mark ---------HMWImTheMnemonicWordViewDelegate----------
- (void)ImTheMnemonicWordViewCompWithWallet:(FLWallet *)wallet{
    
    NSString *isSingleAddress=@"NO";
    if(wallet.isSingleAddress){
        
        isSingleAddress=@"YES";
        
    }
     NSString *temp;
    if ([[FLTools share]changeisEnglish:wallet.mnemonic]) {
        temp = [wallet.mnemonic stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSArray *components = [wallet.mnemonic componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
        
        temp = [components componentsJoinedByString:@" "];
       

    }else{
        temp = [wallet.mnemonic stringByReplacingOccurrencesOfString:@" " withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        temp=[[FLTools share]formattermnemonicWord:temp];
    }
  wallet.walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];


//
    wallet.masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:wallet.walletID];
    
    
    
     invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[wallet.masterWalletID,temp,wallet.mnemonicPWD,wallet.passWord,isSingleAddress] callbackId:wallet.walletID className:@"Wallet" methodName:@"importWalletWithMnemonic"];
    
   
    
    
  PluginResult *result= [[ELWalletManager share]importWalletWithMnemonic:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if([status isEqualToString:@"1"]){
        FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
        model.walletID=wallet.masterWalletID;
        model.walletName=wallet.walletName;
        model.TypeW=SingleSign;
        invokedUrlCommand *subCmommand=[[invokedUrlCommand alloc]initWithArguments:@[wallet.masterWalletID,@"ELA",@"10000"] callbackId:wallet.walletID className:@"Wallet" methodName:@"createMasterWallet"];
        
        PluginResult *subResult= [[ELWalletManager share] createSubWallet:subCmommand];
        NSString *status =[NSString stringWithFormat:@"%@",subResult.status];
    
           if([status isEqualToString:@"1"]){
        [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
               sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
               sideModel.walletID=model.walletID;
               sideModel.sideChainName=@"ELA";
               sideModel.sideChainNameTime=@"--:--";
               sideModel.thePercentageCurr=@"0";
                sideModel.thePercentageMax=@"100";
               [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
        
               [self successfulSwitchingRootVC];
               
               
           }
    }
    
}
-(void)successfulSwitchingRootVC{
    [[FLTools share]showErrorInfo:NSLocalizedString(@"导入成功", nil)];
    
  
    
    
//    PluginResult *re=[[ELWalletManager share] getAllMasterWallets:nil];
//    NSArray  *array = [[FLTools share]stringToArray:re.message[@"success"]];
   
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController = appdelegate.window.rootViewController;
    if ([rootViewController.childViewControllers.firstObject isKindOfClass:[FLPrepareVC class]]) {
        FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
    appdelegate.window.rootViewController=tabVC;
    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:updataCreateWallet object:nil ];
   
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
-(void)imKeystoreViewWithWallet:(FLWallet*)wallet{
    
    wallet.walletID=[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
    wallet.masterWalletID=[[[FLTools share]getRandomStringWithNum:6] stringByAppendingString:wallet.walletID];

    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[wallet.masterWalletID,wallet.keyStore,wallet.privateKey,wallet.passWord,wallet.walletID] callbackId:wallet.walletID className:@"Wallet" methodName:@"importWalletWithKeystore"];
    PluginResult *result= [[ELWalletManager share]importWalletWithKeystore:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if([status isEqualToString:@"1"]){
        NSLog(@"导入钱包成功");
        
        [self getAllSubWalletsWith:wallet];
        
    }
    
}
-(void)getAllSubWalletsWith:(FLWallet*)Wallet{
    
    invokedUrlCommand *mommand=[[invokedUrlCommand alloc]initWithArguments:@[Wallet.masterWalletID] callbackId:Wallet.walletID className:@"Wallet" methodName:@"getAllSubWallets"];
    
    PluginResult * result =[[ELWalletManager share]getAllSubWallets:mommand];
    NSString *status=[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
        
        NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
        
        if (array.count==0) {
            [self createSubWallet:Wallet];
            
        }else{
            
            
            FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
            model.walletID=Wallet.masterWalletID;
            model.walletName=Wallet.walletName;
            [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
            sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
            sideModel.walletID=model.walletID;
            sideModel.sideChainName=@"ELA";
            
            sideModel.sideChainNameTime=@"--:--";
            sideModel.thePercentageCurr=@"0";
            sideModel.thePercentageMax=@"100";
            NSLog(@"添加成功");
            [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
            [self successfulSwitchingRootVC];
        }
        
    }
}
-(void)createSubWallet:(FLWallet*)wallet{
    invokedUrlCommand *subCmommand=[[invokedUrlCommand alloc]initWithArguments:@[wallet.masterWalletID,@"ELA",@"10000"] callbackId:wallet.walletID className:@"Wallet" methodName:@"createMasterWallet"];
    
    PluginResult *subResult= [[ELWalletManager share] createSubWallet:subCmommand];
    NSString *status =[NSString stringWithFormat:@"%@",subResult.status];
    
    if([status isEqualToString:@"1"]){
       
        FMDBWalletModel *model=[[FMDBWalletModel alloc]init];
        model.walletID=wallet.masterWalletID;
        model.walletName=wallet.walletName;
        model.TypeW=SingleSign;
        [[HMWFMDBManager sharedManagerType:walletType]addWallet:model];
        sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
        sideModel.walletID=model.walletID;
        sideModel.sideChainName=@"ELA";
        
        sideModel.sideChainNameTime=@"--:--";
        sideModel.thePercentageCurr=@"0";
        sideModel.thePercentageMax=@"100";
        
        [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
        [self successfulSwitchingRootVC];
        
        
    }
}
@end
