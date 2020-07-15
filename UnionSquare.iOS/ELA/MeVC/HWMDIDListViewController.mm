//
//  HWMDIDListViewController.m
//  elastos wallet
//
//  Created by  on 2019/10/28.
//

#import "HWMDIDListViewController.h"
#import "HWMDIDListAbnormalTableViewCell.h"
#import "HWMCreateDIDViewController.h"
#import "HWMDIDListNormalTableViewCell.h"
#import "HMWFMDBManager.h"
#import "ELWalletManager.h"
#import "HWMDIDInfoViewController.h"

static NSString *AbnormalCellString=@"HWMDIDListAbnormalTableViewCell";
static NSString *normalCellString=@"HWMDIDListNormalTableViewCell";

@interface HWMDIDListViewController ()<UITableViewDelegate,UITableViewDataSource,HWMDIDInfoViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *HasBeenReleasedButton;
@property (weak, nonatomic) IBOutlet UIButton *theDraftButton;
@property (weak, nonatomic) IBOutlet UIView *HasBeenReleaseView;
@property (weak, nonatomic) IBOutlet UIView *theDraftView;
@property (weak, nonatomic) IBOutlet UITableView *table;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *releDIDdataSorse;
/*
 *<# #>
 */
@property(copy,nonatomic)NSArray *theDraftDIDdataSorse;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isRel;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *walletListArray;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *RelDIDArray;

@end

@implementation HWMDIDListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"DID", nil);
    self.isRel=YES;
    [self makeUI];
    [self.HasBeenReleasedButton setTitle:NSLocalizedString(@"已发布", nil) forState:UIControlStateNormal];
    [self.theDraftButton setTitle:NSLocalizedString(@"草稿", nil) forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mine_did_add"] style:UIBarButtonItemStyleDone target:self action:@selector(creatDIDEvent)];
    [self selectHasBeenReleased];
    [self getDIDListArray];
}
-(void)getDIDListArray{
//    self.theDraftDIDdataSorse=[[HMWFMDBManager sharedManagerType:DIDInfoType]allSelectDIDWithWallID:@""];
//    for (FMDBWalletModel *model in self.walletListArray) {
//        invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID,@"IDChain",@"0",@"100"] callbackId:model.walletID className:@"wallet" methodName:@"createMasterWallet"];
//          PluginResult * resultBase =[[ELWalletManager share]getDetailsDIDlist:cmommand];
//            NSString *statusBase=[NSString stringWithFormat:@"%@",resultBase.status];
//    }
    
}
-(NSMutableArray *)RelDIDArray{
    if (_RelDIDArray) {
        _RelDIDArray =[[NSMutableArray alloc]init];
    }
    return _RelDIDArray;
}
-(NSMutableArray *)walletListArray{
    if (!_walletListArray) {
        NSArray *allWalletListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
        _walletListArray=[[NSMutableArray alloc]init];
       for (int i=0; i<allWalletListArray.count; i++) {
              FMDBWalletModel *model=allWalletListArray[i];
              invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID] callbackId:model.walletID className:@"wallet" methodName:@"createMasterWallet"];
              PluginResult * resultBase =[[ELWalletManager share]getMasterWalletBasicInfo:cmommand];
              NSString *statusBase=[NSString stringWithFormat:@"%@",resultBase.status];
              NSDictionary *baseDic=[[NSDictionary alloc]init];
              if ([statusBase isEqualToString:@"1"] ) {
                  baseDic=[[FLTools share]dictionaryWithJsonString:resultBase.message[@"success"]];
                  NSString *Readonly=[NSString stringWithFormat:@"%@",baseDic[@"Readonly"]];
                  if ([Readonly isEqualToString:@"0"]) {
                      if ([baseDic[@"M"] integerValue]==1) {
                          model.TypeW=SingleSign;
                          [_walletListArray addObject:model];
                      }else{
                          model.TypeW=HowSign;
                 
                      }
                  }else{
                      if ([baseDic[@"M"] integerValue]==1) {
                          model.TypeW=SingleSignReadonly;
                      }else{
                          model.TypeW=HowSignReadonly;
                      }
                  }
              }
              
              
          
          }
    }
    return _walletListArray;
}
-(void)makeUI{
    [self.table registerNib:[UINib nibWithNibName:normalCellString bundle:nil] forCellReuseIdentifier:normalCellString];
        [self.table registerNib:[UINib nibWithNibName:AbnormalCellString bundle:nil] forCellReuseIdentifier:AbnormalCellString];
       self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
       self.table.delegate =self;
       self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isRel) {
    HWMDIDListNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=self.releDIDdataSorse[indexPath.section];
    return cell;
    }else{
    HWMDIDListAbnormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AbnormalCellString];
    cell.timeLeftConOff.constant=0;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=self.theDraftDIDdataSorse[indexPath.section];
    return cell;
    }
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   if (self.isRel) {
    return self.releDIDdataSorse.count;
       }else{
    return self.theDraftDIDdataSorse.count;
       }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isRel) {
     
      }else{
          HWMDIDInfoViewController *DIDInfoVC=[[HWMDIDInfoViewController alloc]init];
          DIDInfoVC.model=self.theDraftDIDdataSorse[indexPath.section];
          DIDInfoVC.delegate=self;
          [self.navigationController pushViewController:DIDInfoVC animated:YES];
      }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isRel) {
        return 100 ;
      }else{
       return 70;
      }
}
-(void)creatDIDEvent{
    HWMCreateDIDViewController *CreateDIDVC=[[HWMCreateDIDViewController alloc]init];
    [self.navigationController pushViewController:CreateDIDVC animated:YES];
}
- (IBAction)HasBeenReleasedAndChangeTheDrafteEvent:(id)sender {
    if (sender==self.theDraftButton) {
        [self selectTheDraftView];
    }else if (sender==self.HasBeenReleasedButton){
        [self selectHasBeenReleased];
    }
}
-(void)selectHasBeenReleased{
        [self.HasBeenReleasedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.HasBeenReleaseView.alpha=1.f;
        [self.theDraftButton setTitleColor:RGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
    self.theDraftView.alpha=0.f;
    self.isRel=YES;
    [self.table reloadData];
}
-(void)selectTheDraftView{
      [self.HasBeenReleasedButton setTitleColor:RGBA(255, 255, 255, 0.5) forState:UIControlStateNormal];
    self.HasBeenReleaseView.alpha=0.f;
        [self.theDraftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.theDraftView.alpha=1.f;
    self.isRel=NO;
    [self.table reloadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.f;
}
-(void)needUpdateDIDInfo{
    [self getDIDListArray];
    
}
@end
