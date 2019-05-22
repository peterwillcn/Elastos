//
//  HMWtheSuperNodeElectionViewController.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWtheSuperNodeElectionViewController.h"
#import "HMWVotingListView.h"
#import "HMWvotingRulesView.h"
#import "HMWnodeInformationViewController.h"
#import "FLCoinPointInfoModel.h"
#import "HMWtheCandidateListViewController.h"
#import "HMWMyVoteViewController.h"
#import "FLNotePointDBManager.h"
#import "DC_DealTextViewController.h"
@interface HMWtheSuperNodeElectionViewController ()<HMWvotingRulesViewDelegate,HMWVotingListViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tagMyVotedLab;
@property (weak, nonatomic) IBOutlet UILabel *tagVoteRuleLab;

/*
 *<# #>
 */
@property(strong,nonatomic)HMWVotingListView *votingListV;
@property (weak, nonatomic) IBOutlet UIButton *toVoteButton;

@property (weak, nonatomic) IBOutlet UIButton *votingRulesButton;
@property (weak, nonatomic) IBOutlet UIButton *myVoteButton;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWvotingRulesView *votingRulesV;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation HMWtheSuperNodeElectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self defultWhite];
    [self setBackgroundImg:@"tab_bg"];
    self.title=NSLocalizedString(@"超级节点选举", nil);
    self.tagMyVotedLab.text=NSLocalizedString(@"我的投票", nil);
    self.tagVoteRuleLab.text=NSLocalizedString(@"投票规则", nil);
    [self.toVoteButton setTitle:NSLocalizedString(@"我要投票", nil) forState:UIControlStateNormal];
    
    UIView *mainView =[self mainWindow];
    [mainView addSubview:self.votingRulesV];
    
    [self.votingRulesV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(mainView);
    }];
    [self.view addSubview:self.votingListV];
    [self.votingListV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.myVoteButton.mas_top).offset(0);
        make.top.equalTo(self.view).offset(10);
    }];
    [self getNetCoinPointArray];

}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource =[[NSMutableArray alloc]init];
    }
    return _dataSource;
}
-(void)loadAllImageInfo:(NSMutableArray*)allListInfoArray{
  
    
    dispatch_group_t group =  dispatch_group_create();
   
    for (int i=0; i<allListInfoArray.count; i++) {
        FLCoinPointInfoModel *model =allListInfoArray[i];
        
        if (model.url.length>0) {
            dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                model.iconImageUrl= [[FLTools share] getImageViewURLWithURL:model.url];
                allListInfoArray[i]=model;
            });
           
        }
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
         [self.votingListV setDataSource: allListInfoArray];
    });

    
    
    
    dispatch_queue_t queue = dispatch_queue_create(0, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{

     [self UpdataLocalOwerlist];
    });

    
}
-(void)getNetCoinPointArray{
    
    [HttpUrl NetPOSTHost:Http_IP url:@"/api/dposnoderpc/check/listproducer" header:@{} body:@{@"moreInfo":@"1"} showHUD:YES WithSuccessBlock:^(id data) {
        NSDictionary *param = data[@"data"];
        NSArray *dataArray =[NSArray modelArrayWithClass:FLCoinPointInfoModel.class json:param[@"result"][@"producers"]];
        
        self.dataSource= [NSMutableArray arrayWithArray:dataArray];
        
        self.votingListV.dataSource = self.dataSource;
        self.votingListV.lab1.text = [NSString stringWithFormat:@"%.5f %@" ,[param[@"result"][@"totalvoterate"] floatValue]*100,@"%"];
       // self.votingListV.lab2.text = [param[@"result"][@"totalvotes"]stringValue ];
        self.votingListV.lab3.text =[NSString stringWithFormat:@"%ld", (long)[param[@"result"][@"totalvotes"] integerValue]];
        
        
        [self loadAllImageInfo:[NSMutableArray arrayWithArray:dataArray]];
        
    } WithFailBlock:^(id data) {
        
    }];
}


-(void)UpdataLocalOwerlist{
    NSArray *localStore  = [[NSMutableArray alloc]initWithArray: [[FLNotePointDBManager defult]allRecord]];
    
    for (int i= 0; i<localStore.count; i++) {
        FLCoinPointInfoModel *model = localStore[i];
        
        FLCoinPointInfoModel *curentmodel = nil ;
        BOOL ret = NO;
        for (FLCoinPointInfoModel*dataModel in self.dataSource) {
           ret =  [dataModel.ownerpublickey isEqualToString:model.ownerpublickey];
            if (ret) {
                curentmodel = model;
            }
        }
        
        if (curentmodel){
            [[FLNotePointDBManager defult]updateRecord:model];
            continue;
        }else{
            [[FLNotePointDBManager defult]delectRecord:model];
        }
    }
}
-(HMWvotingRulesView *)votingRulesV{
    if (!_votingRulesV) {
        _votingRulesV =[[HMWvotingRulesView alloc]init];
        _votingRulesV.delegate=self;
        _votingRulesV.alpha=0.f;
    }
    return _votingRulesV;
}
-(HMWVotingListView *)votingListV{
    if (!_votingListV) {
        _votingListV =[[HMWVotingListView alloc]init];
        _votingListV.delegate=self;
        
        
    }
    return _votingListV;
}
- (IBAction)myVoteEvent:(id)sender {
    
    HMWMyVoteViewController * vc = [[HMWMyVoteViewController alloc]init];
    vc.listData = self.dataSource;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)votingRulesEvent:(id)sender {
    DC_DealTextViewController *vc = [[DC_DealTextViewController alloc]init];
    vc.html_url = NSLocalizedString(@"rules", nil); 
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)myVoteButton:(id)sender {
    HMWtheCandidateListViewController * vc = [[HMWtheCandidateListViewController alloc]init];
    vc.persent = self.votingListV.lab1.text ;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)closeViewDele{
    
    self.votingRulesV.alpha=0.f;
}
#pragma mark ---------HMWVotingListViewDelegate----------

- (void)selectedVotingListWithIndex:(NSInteger)index {
    HMWnodeInformationViewController *nodeInformationVC=[[HMWnodeInformationViewController alloc]init];
    nodeInformationVC.model = self.dataSource[index];
      [self.navigationController pushViewController:nodeInformationVC animated:YES];
    
  
    
}






@end
