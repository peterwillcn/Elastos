//
//  FLthirdViewController.m
//  FLWALLET
//
#import "FLMyVC.h"
#import "FLMeHeadView.h"
#import "MJRefresh.h"
#import "FLShareVC.h"
#import "FLTableViewDefultCell.h"
#import "HMWClassificationOfLanguageTableViewCell.h"
#import "HMWaddWalletListTableViewCell.h"
#import "HMWNotAddContactTableViewCell.h"
#import "HMWmyContactListTableViewCell.h"
#import "HMWaddContactViewController.h"
#import "HMWtheContactInformationViewController.h"
#import "HMWFMDBManager.h"
#import "friendsModel.h"
#import "AboutELAWalletViewController.h"
#import "HWMCreateDIDViewController.h"
#import "HWMDIDListViewController.h"
#import "ELWalletManager.h"

static NSString *MyIncomeOrWealthCell=@"HMWMyIncomeOrWealthTableViewCell";
static NSString *LanguageCell=@"HMWClassificationOfLanguageTableViewCell";
static NSString *addListCell=@"HMWaddWalletListTableViewCell";
static NSString *notAddCell=@"HMWNotAddContactTableViewCell";
static NSString *theContactCell=@"HMWmyContactListTableViewCell";

@interface FLMyVC ()<UITableViewDataSource,UITableViewDelegate,FLMeHeadViewDelegate>
@property (nonatomic, strong)FLMeHeadView *headerView;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong)NSArray *dataSorse;

/*
 *<# #>
 */
@property(assign,nonatomic)BOOL theContactOpen;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *theContactMutableArray;
/*
 *<# #>
 */
@property(strong,nonatomic)NSIndexPath *selectIndex;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *walletListArray;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL hasDID;

@end

@implementation FLMyVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.theContactOpen=NO;
    
    self.title= NSLocalizedString(@"我的", nil);
    self.hasDID=NO;
    
    self.languageOpen =[[NSUserDefaults standardUserDefaults] objectForKey:@"isOpen"];
    
    [self makeUI];
    [self.table reloadData];
    [self setBackgroundImg:@""];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myfriendNeedUpdateInfo) name:myfriendNeedUpdate object:nil];
    [self getDIDListArray];
}
-(void)getDIDListArray{
    
    if ([[HMWFMDBManager sharedManagerType:DIDInfoType]allSelectDIDWithWallID:@""]) {
        self.hasDID=YES;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                 [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
    if (self.hasDID==NO) {
    for (FMDBWalletModel *model in self.walletListArray) {
        invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID,@"IDChain",@"0",@"100"] callbackId:model.walletID className:@"wallet" methodName:@"createMasterWallet"];
          PluginResult * resultBase =[[ELWalletManager share]getDetailsDIDlist:cmommand];
            NSString *statusBase=[NSString stringWithFormat:@"%@",resultBase.status];
        
        if ([statusBase isEqualToString:@"1"] ) {
              self.hasDID=YES;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
               [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            return;
        }
        
    }
     
    }
    
    
    
    
    
}

-(NSMutableArray *)walletListArray{
    if (!_walletListArray) {
        NSArray *allWalletListArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
        _walletListArray=[[NSMutableArray alloc]init];
       for (int i=0; i<allWalletListArray.count; i++) {
              FMDBWalletModel *model=allWalletListArray[i];
              invokedUrlCommand *cmommand=[[invokedUrlCommand alloc]initWithArguments:@[model.walletID] callbackId:model.walletID className:@"wallet" methodName:@"createMasterWallet"];
           PluginResult * result =[[ELWalletManager share]getAllSubWallets:cmommand];
              NSString *status=[NSString stringWithFormat:@"%@",result.status];
              if ([status isEqualToString:@"1"]) {
              NSArray  *array = [[FLTools share]stringToArray:result.message[@"success"]];
                  if (array.count<2) {
                      break;
                  }
                  
              }
           
           
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
-(void)myfriendNeedUpdateInfo{
    [self.theContactMutableArray removeAllObjects];
    self.theContactMutableArray=nil;
 
     NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:self.selectIndex.section];
    [self.table reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}
-(NSMutableArray *)theContactMutableArray{
    
    if (!_theContactMutableArray) {
        _theContactMutableArray =[[NSMutableArray alloc]initWithArray:[[HMWFMDBManager sharedManagerType:friendsModelType]allRecord]];
    }
    return _theContactMutableArray;
}
-(void)makeUI{
    self.table  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.table registerNib:[UINib nibWithNibName:@"FLTableViewDefultCell" bundle:nil] forCellReuseIdentifier:@"FLTableViewDefultCell"];
        [self.table registerNib:[UINib nibWithNibName:LanguageCell bundle:nil] forCellReuseIdentifier:LanguageCell];
    
        [self.table registerNib:[UINib nibWithNibName:addListCell bundle:nil] forCellReuseIdentifier:addListCell];
    [self.table registerNib:[UINib nibWithNibName:notAddCell bundle:nil] forCellReuseIdentifier:notAddCell];
      [self.table registerNib:[UINib nibWithNibName:theContactCell bundle:nil] forCellReuseIdentifier:theContactCell];
 
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.delegate =self;
    self.table.dataSource =self;
    [self.view addSubview:self.table];
    UIImageView *bgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
   [self CAGradientColorFrome:RGB(83, 136, 136) withToColor:RGB(16, 47, 58) withView:bgview];
    self.table.backgroundView = bgview;
    self.table.rowHeight = 60;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AppWidth, 40)];
    self.dataSorse = @[
  @{@"img":@"mine_sugar",@"title":NSLocalizedString(@"DID", nil),@"url":@"/app/vlink/wallet.html",@"subTitle":@""},
  @{@"img":@"mine_sugar",@"title":NSLocalizedString(@"手势密码", nil),@"url":@"/app/vlink/wallet.html",@"subTitle":@""},
  @{@"img":@"mine_sugar",@"title":NSLocalizedString(@"联系人", nil),@"url":@"/app/vlink/wallet.html",@"subTitle":@""},
  @{@"img":@"mine_mission",@"title":NSLocalizedString(@"语言", nil),@"url":@"/app/task.html",@"subTitle":@""},
  @{@"img":@"mine_sugar",@"title":NSLocalizedString(@"关于", nil),@"url":@"/app/vlink/wallet.html",@"subTitle":@""}];  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self defultWhite];
     [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.leftBarButtonItem = nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 3:
            if (self.languageOpen) {
                return 2;
            }
            break;
        case 2:{
            if (self.theContactOpen) {
                if (self.theContactMutableArray.count==0) {
                    return self.theContactMutableArray.count+3;
                }
                return self.theContactMutableArray.count+2;
            }
        }
            break;
            
        default:
            return 1;
            break;
    }
    
//    if (self.languageOpen) {
//        if (section==3) {
//
//
//            return 2;
//        }
//
//    }
//
//    if (self.theContactOpen) {
//        if (section==2) {
//            if (self.theContactMutableArray.count==0) {
//                return self.theContactMutableArray.count+3;
//            }
//            return self.theContactMutableArray.count+2;
//
//        }
//    }
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [[UIView alloc]initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.languageOpen) {
        if (indexPath.section==3) {
            if (indexPath.row==0) {
                FLTableViewDefultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLTableViewDefultCell"];
                
                NSDictionary*dict =self.dataSorse[indexPath.section];
                cell.nameLab.text  = dict[@"title"];
                cell.subImag.image=[UIImage imageNamed:@"setting_list_arrow"];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
            HMWClassificationOfLanguageTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:LanguageCell];
            cell.backgroundColor=[UIColor clearColor];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    if (self.theContactOpen) {
        if (indexPath.section==2) {
            if (indexPath.row==0) {
                FLTableViewDefultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLTableViewDefultCell"];
                
                NSDictionary*dict =self.dataSorse[indexPath.section];
                cell.nameLab.text  = dict[@"title"];
                cell.subImag.image=[UIImage imageNamed:@"setting_list_arrow"];
                    return cell;
            }
            if (self.theContactMutableArray.count==0) {
                
        if(indexPath.row==self.theContactMutableArray.count+2) {
                HMWaddWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:addListCell];
                cell.backgroundColor=[UIColor clearColor];
                [[HMWCommView share] makeBordersWithView:cell.BGView];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            return cell;
            
        }
                HMWNotAddContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:notAddCell];
                cell.backgroundColor=[UIColor clearColor];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
                
                
            }else{
                if (indexPath.row==self.theContactMutableArray.count+1) {
                    HMWaddWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:addListCell];
                    
                    cell.backgroundColor=[UIColor clearColor];
                    [[HMWCommView share] makeBordersWithView:cell.BGView];
           
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    return cell;
                }
                HMWmyContactListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:theContactCell];
                
                cell.backgroundColor=[UIColor clearColor];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                
                friendsModel *model=self.theContactMutableArray[indexPath.row-1];
                cell.nickNameLabel.text=model.nameString;
            
                return cell;
                
            }

            
        }
    }
    
    FLTableViewDefultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FLTableViewDefultCell"];

    NSDictionary*dict =self.dataSorse[indexPath.section];
    cell.nameLab.text  = dict[@"title"];

    cell.subImag.image=[UIImage imageNamed:@"setting_list_arrow_fold"];
  
    if (indexPath.section==1) {
        cell.subImag.alpha=0.f;
        cell.pwdSwitch.alpha=1.f;
    }else{
        cell.subImag.alpha=1.f;
        cell.pwdSwitch.alpha=0.f;
    }
    if (indexPath.section==0&&self.hasDID==NO) {
        cell.stastuLabel.text=NSLocalizedString(@"暂无", nil);
    }else if (indexPath.section==0&&self.hasDID){
        cell.stastuLabel.alpha=0.f;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSDictionary *dict = self.dataSorse[indexPath.section];

    NSString *name = dict[@"title"];
    if([name isEqualToString:NSLocalizedString(@"语言", nil)]) {
        if (indexPath.row==0) {
            self.languageOpen=!self.languageOpen;
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
            [self.table reloadSections:indexSet withRowAnimation: UITableViewRowAnimationAutomatic];
       
        }
        }else if([name isEqualToString:NSLocalizedString(@"联系人", nil)]){
        self.selectIndex=indexPath;
         if (indexPath.row==0) {
         self.theContactOpen=!self.theContactOpen;
         NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
             [self.table reloadSections:indexSet withRowAnimation: UITableViewRowAnimationAutomatic];
         }else{
                if (self.theContactMutableArray.count==0) {
                 HMWaddContactViewController *addContactVC=[[ HMWaddContactViewController alloc]init];
                 addContactVC.title=NSLocalizedString(@"添加联系人", nil);
                 addContactVC.typeInfo=updateInfo;
                 [self.navigationController pushViewController:addContactVC animated:YES];
                    }else{
                        if (indexPath.row==self.theContactMutableArray.count+1) {//添加
                            HMWaddContactViewController *addContactVC=[[ HMWaddContactViewController alloc]init];
                            addContactVC.title=NSLocalizedString(@"添加联系人", nil);
                            [self.navigationController pushViewController:addContactVC animated:YES];
                        }else{
                 
                            HMWtheContactInformationViewController *theContactInformationVC=[[HMWtheContactInformationViewController alloc]init];
                            theContactInformationVC.model=self.theContactMutableArray[indexPath.row-1];
                    [self.navigationController pushViewController:theContactInformationVC animated:YES];}
             }
             
         }
        
     }else if ([name isEqualToString:NSLocalizedString(@"关于", nil)]){
                         AboutELAWalletViewController* AboutELAWalletVC =[[AboutELAWalletViewController alloc]init];
                                         AboutELAWalletVC.title=name;
                                         [self.navigationController pushViewController:AboutELAWalletVC animated:YES];
                         
     }else if ([name isEqualToString:NSLocalizedString(@"DID", nil)]){
         if (self.hasDID) {
             HWMDIDListViewController *DIDListVC=[[HWMDIDListViewController alloc]init];
        [self.navigationController pushViewController:DIDListVC animated:YES];
         }else{
         HWMCreateDIDViewController * HWMCreateDIDVC=[[HWMCreateDIDViewController alloc]init];
         [self.navigationController pushViewController:HWMCreateDIDVC animated:YES];
         }
     }else if ([name isEqualToString:NSLocalizedString(@"手势密码", nil)]){
         
     }
}
   
-(void)head:(FLMeHeadView *)header click:(NSInteger)index
{
 
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//-(void)setLanguageOpen:(BOOL)languageOpen{
//    _languageOpen=languageOpen;
//
//}
@end
