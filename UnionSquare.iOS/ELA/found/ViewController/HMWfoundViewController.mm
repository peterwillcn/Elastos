//
//  HMWfoundViewController.m
//  ELA
//
//  Created by  on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWfoundViewController.h"
#import "FLSelectSuperPointVC.h"
#import "HMWtheSuperNodeElectionViewController.h"
#import "ELWalletManager.h"
#import "IMainchainSubWallet.h"
#import "HMWtheSuperNodeElectionViewController.h"

@interface HMWfoundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong)NSArray *dataSource;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *typeString;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL hasSing;

@end

@implementation HMWfoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadElectionInfo];
    [self defultWhite];
    [self setBackgroundImg:@""];
        self.title=NSLocalizedString(@"发现", nil);
    
    self.table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.table.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.table];
    self.table.dataSource =self;
    self.table.delegate = self;
    self.table.rowHeight = (AppWidth-60)/2;
    self.table.tableFooterView = [[UIView alloc] init];
    self.dataSource = @[@""];
    [self.table registerNib:[UINib nibWithNibName:@"HMWfoundTableCell" bundle:nil] forCellReuseIdentifier:@"HMWfoundTableCell"];

}
-(void)loadElectionInfo{
    ELWalletManager *manager   =  [ELWalletManager share];
    
    IMainchainSubWallet *mainchainSubWallet = [manager getWalletELASubWallet:manager.currentWallet.masterWalletID];
    
    nlohmann::json info = mainchainSubWallet->GetRegisteredProducerInfo();
    NSString *dataStr = [NSString stringWithUTF8String:info.dump().c_str()];
    NSDictionary *param = [NSJSONSerialization JSONObjectWithData:[dataStr  dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSString *Status = param[@"Status"];
    if ([Status isEqualToString:@"Registered"]){
        self.typeString =@"1";
    }else if([Status isEqualToString:@"Canceled"]){
    self.typeString =@"2";

    }else if([Status isEqualToString:@"Unregistered"]){
        self.typeString =@"0";

    }else if ([Status isEqualToString:@"ReturnDeposit"]){
        self.typeString =@"4";
        
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem=nil;
    [self.navigationController setNavigationBarHidden:NO];
  
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMWfoundTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMWfoundTableCell"];
    cell.img.image = [UIImage imageNamed:NSLocalizedString(@"found_card_vote", nil)];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HMWtheSuperNodeElectionViewController*theSuperNodeElectionVC=[[HMWtheSuperNodeElectionViewController alloc]init];
    theSuperNodeElectionVC.typeString=self.typeString;
    [self.navigationController pushViewController:theSuperNodeElectionVC animated:YES];
//        FLSelectSuperPointVC*selectSuperPointVC=[[FLSelectSuperPointVC alloc]init];
//        [self.navigationController pushViewController:selectSuperPointVC animated:YES];
    
}
@end
