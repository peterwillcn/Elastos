//
//  HMWverifyTheMnemonicWordViewController.m
//  ELA
//
//  Created by  on 2019/1/7.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWverifyTheMnemonicWordViewController.h"
#import "FLSelectWordView.h"
#import "AppDelegate.h"
#import "FLFLTabBarVC.h"
#import "FLPrepareVC.h"
#import "DAConfig.h"
#import "HWMSignThePurseViewController.h"
#import "FMDBWalletModel.h"
#import "ELWalletManager.h"
#import "HMWFMDBManager.h"

@interface HMWverifyTheMnemonicWordViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
/*
 *<# #>
 */
@property(strong,nonatomic)FLSelectWordView *view2;

@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (nonatomic, copy)NSString *textWord;
@property (weak, nonatomic) IBOutlet UILabel *showInfoTextLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *collect;


/*
 *
 */
@property(strong,nonatomic)NSMutableArray *inputMutableArray;
/*
 *<# #>
 */
@property(copy,nonatomic)NSMutableArray *mnemonicWordArray;
@end

@implementation HMWverifyTheMnemonicWordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroundImg:@""];
        [self defultWhite];
    self.title =NSLocalizedString(@"验证助记词", nil);
    self.mnemonic=self.Wallet.mnemonic;
    self.showInfoTextLabel.text=NSLocalizedString(@"请按照顺序点击您的助记词", nil);
    [[HMWCommView share]makeBordersWithView:self.BGView];
    [self.view addSubview:self.view2];
    [self.view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.BGView.mas_bottom).offset(20);
        
    }];
    [self setSubView];
}
-(NSMutableArray *)mnemonicWordArray{
    
    if (!_mnemonicWordArray) {
        _mnemonicWordArray =[[NSMutableArray alloc]init];
    }
    return _mnemonicWordArray;
}
-(NSMutableArray *)inputMutableArray{
    if (!_inputMutableArray) {
        _inputMutableArray =[[NSMutableArray alloc]init];
    }
    
    return _inputMutableArray;
}


-(FLSelectWordView *)view2{
    if (!_view2) {
        _view2  = [[FLSelectWordView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 200)];
        
        NSArray *arr=[self.mnemonic componentsSeparatedByString:@" "];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            WordModel *m = [[WordModel alloc]init];
            m.word = arr[i];
            m.state = 0;
            [array addObject:m];
        }
        
        self.view2.dataSource = array;

    __weak __typeof__(self) weakSelf = self;
        _view2.callBack = ^(WordModel *model) {
            [weakSelf.mnemonicWordArray addObject:model.word];
            [weakSelf.inputMutableArray addObject:model];
            [weakSelf.collect reloadData];
        };
        _view2.sureBtnClick = ^{
            [weakSelf compareTextView];
        };
    }
    return _view2;
}
-(void)compareTextView{
    
        BOOL ret=NO;
    if ([self.Wallet.mnemonic isEqualToString:[self.mnemonicWordArray componentsJoinedByString:@" "]]) {
        ret=YES;
    }
    if (ret) {
        if (self.createType==3) {
            [self privateKey];
        }else{
            [self creteWallet];
        }

    }else{
        [[FLTools share]showErrorInfo:NSLocalizedString(@"你备份的助记词顺序验证错误,请从新校验", nil)];
        NSArray *arr = [self.Wallet.mnemonic componentsSeparatedByString:@" "];
    
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            WordModel *m = [[WordModel alloc]init];
            m.word = arr[i];
            m.state = 0;
            [array addObject:m];
        }
        [self.inputMutableArray removeAllObjects];
        [self.mnemonicWordArray removeAllObjects];
        [self.collect reloadData];
        self.view2.dataSource = array;
    
    }
}
-(void)setWallet:(FLWallet *)Wallet{
    _Wallet=Wallet;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)setSubView{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing = 10;
    flow.minimumLineSpacing = 10;
    self.collect.collectionViewLayout=flow;
    self.collect.delegate = self;
    self.collect.dataSource =self;
    self.collect.backgroundColor = [UIColor clearColor];
    [self.collect registerNib:[UINib nibWithNibName:@"FLSelectWordCollectCell" bundle:nil] forCellWithReuseIdentifier:@"FLSelectWordCollectCellS"];
 
    
}
#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.inputMutableArray.count;
    
}
#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLSelectWordCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FLSelectWordCollectCellS" forIndexPath:indexPath];
    WordModel*model = self.inputMutableArray[indexPath.row];
    cell.wordLab.text =model.word;
    cell.wordLab.textColor=[UIColor whiteColor];
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordModel *model =self.inputMutableArray[indexPath.row];
    [self.view2 canlceSelectWordModelWithWord:model.word];
    [self.mnemonicWordArray removeObjectAtIndex:indexPath.row];
    [self.inputMutableArray removeObjectAtIndex:indexPath.row];
    [self.collect reloadData];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        WordModel *model = self.inputMutableArray[indexPath.row];
    if ([[FLTools share]changeisEnglish:model.word]) {
        return  CGSizeMake(model.word.length*13,20);
    }
    
    return  CGSizeMake(30,30);
}
- (void)setFormeType:(NSString *)FormeType{
    _FormeType=FormeType;
    
}
-(void)creteWallet{
    NSString *isSingleAddress=@"NO";
    if (self.Wallet.isSingleAddress) {
        isSingleAddress=@"YES";
    }
    
    
    invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.Wallet.masterWalletID,self.Wallet.mnemonic,self.Wallet.mnemonicPWD,self.Wallet.passWord,isSingleAddress] callbackId:self.Wallet.walletID className:@"Wallet" methodName:@"createMasterWallet"];
    PluginResult *result= [[ELWalletManager share] createMasterWallet:cmommand];
    NSString *status =[NSString stringWithFormat:@"%@",result.status];
    if ([status isEqualToString:@"1"]) {
        invokedUrlCommand *subCmommand=[[invokedUrlCommand alloc]initWithArguments:@[self.Wallet.masterWalletID,@"ELA",@"10000"] callbackId:self.Wallet.walletID className:@"Wallet" methodName:@"createMasterWallet"];
        PluginResult *subResult= [[ELWalletManager share] createSubWallet:subCmommand];
        NSString *status =[NSString stringWithFormat:@"%@",subResult.status];
        if ([status isEqualToString:@"1"]) {
            FMDBWalletModel*waModel=[[FMDBWalletModel alloc]init];
            waModel.walletName=self.Wallet.walletName;
            //            waModel.walletAddress
            waModel.walletID=self.Wallet.masterWalletID;
            [[HMWFMDBManager sharedManagerType:walletType] addWallet:waModel];
            sideChainInfoModel *sideModel=[[sideChainInfoModel alloc]init];
            sideModel.walletID=waModel.walletID;
            sideModel.sideChainName=@"ELA";
            sideModel.sideChainNameTime=@"--:--";
            [[HMWFMDBManager sharedManagerType:sideChain] addsideChain:sideModel];
//            HMWverifyTheMnemonicWordViewController *verifyTheMnemonicWordVC=[[HMWverifyTheMnemonicWordViewController alloc]init];
//            verifyTheMnemonicWordVC.Wallet=self.Wallet;
//            verifyTheMnemonicWordVC.FormeType=@"1";
//            [self.navigationController pushViewController:verifyTheMnemonicWordVC animated:YES];
        }
        
        
    }else{
        self.Wallet.walletID=NULL;
        
    }
    
    [[FLTools share]showErrorInfo:NSLocalizedString(@"备份成功", nil)];
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootViewController1 = appdelegate.window.rootViewController;
    if ([rootViewController1.childViewControllers.firstObject isKindOfClass:[FLPrepareVC class]]) {
        
        FLFLTabBarVC *tabVC = [[FLFLTabBarVC alloc]init];
        appdelegate.window.rootViewController=tabVC;
    }else{
        if ([self.FormeType isEqualToString:@"1"]) {
            [[NSNotificationCenter defaultCenter]postNotificationName:updataCreateWallet object:nil ];}
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}
-(void)privateKey{
    
    if (self.delegate) {
        [self.delegate backTheWallet:self.Wallet];
    }
 
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HWMSignThePurseViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
            
        }
        
    }
    
}
-(void)setCreateType:(NSInteger)createType{
    _createType=createType;
    
}
@end
