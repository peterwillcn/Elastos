//
//  HWMAddThePrivateKeyViewController.m
//  elastos wallet
//
//  Created by  on 2019/7/3.
//

#import "HWMAddThePrivateKeyViewController.h"
#import "HWMAddThePrivateKeyTableViewCell.h"
#import "HWMNewPrivateKeyViewController.h"
#import "HWMImportTheMnemonicWordViewController.h"
#import "HWMSignTheWalletListViewController.h"


static NSString *cellString=@"HWMAddThePrivateKeyTableViewCell";
@interface HWMAddThePrivateKeyViewController ()<UITableViewDelegate,UITableViewDataSource,HWMNewPrivateKeyViewControllerDelegate,HWMSignTheWalletListViewControllerDelegate,HWMImportTheMnemonicWordViewControllerDelegate,HWMSignTheWalletListViewControllerDelegate>
/*
 *<# #>
 */
@property(strong,nonatomic)UITableView *baseTableView;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *dataSourceArray;


@end

@implementation HWMAddThePrivateKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"添加根私钥", nil);
    self.dataSourceArray =[NSArray arrayWithObjects:NSLocalizedString(@"新建私钥", nil),NSLocalizedString(@"导入助记词", nil),NSLocalizedString(@"使用已有钱包", nil), nil];
    [self.baseTableView reloadData];
}
-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, AppWidth, AppHeight) style:UITableViewStyleGrouped];
        
        _baseTableView.delegate=self;
        _baseTableView.dataSource=self;
        
        [_baseTableView  registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
        _baseTableView.backgroundColor=[UIColor clearColor];
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_baseTableView];
        
        [_baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    return _baseTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataSourceArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HWMAddThePrivateKeyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
cell.typeNameLabel.text=self.dataSourceArray[indexPath.section];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  NSString *nameString=self.dataSourceArray[indexPath.section];

    if ([nameString isEqualToString:NSLocalizedString(@"新建私钥", nil)]) {
        HWMNewPrivateKeyViewController *vc=[[HWMNewPrivateKeyViewController alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([nameString isEqualToString:NSLocalizedString(@"导入助记词", nil)]){
        HWMImportTheMnemonicWordViewController *vc=[[HWMImportTheMnemonicWordViewController alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([nameString isEqualToString:NSLocalizedString(@"使用已有钱包", nil)]){
        
        HWMSignTheWalletListViewController*vc=[[HWMSignTheWalletListViewController alloc]init];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectZero];
    
}
-(void)backTheMnemonicWord:(NSString *)word withPWD:(NSString*)PWD  withPhrasePassword:(NSString*)phrasePassword{
    if (word.length>0) {
        if (self.delegate) {
            [self.delegate backWithWord:word withPWD:PWD withPhrasePassword:phrasePassword];
        }
    }
    
}
-(void)CallbackWithWalletID:(NSString *)wallet withXPK:(NSString *)XPK withPWD:(NSString * _Nonnull)PWD{
    if (self.delegate) {
        [self.delegate CallbackWithWalletID:wallet withXPK:XPK withPWD:PWD];
    }
    
}
-(void)ImportTheMnemonicWordViewWithMnemonic:(NSString*)Mnemonic withPWD:(NSString*)PWD withPhrasePassword:(NSString*)phrasePassword{
    
    if (self.delegate) {
        [self.delegate ImportTheMnemonicWordViewWithMnemonic:Mnemonic withPWD:PWD withPhrasePassword:phrasePassword];
    }
    
}
@end
