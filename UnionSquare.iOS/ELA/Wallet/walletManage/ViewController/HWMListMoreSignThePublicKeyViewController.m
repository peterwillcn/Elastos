//
//  HWMListMoreSignThePublicKeyViewController.m
//  elastos wallet
//
//  Created by  on 2019/9/10.
//

#import "HWMListMoreSignThePublicKeyViewController.h"
#import "HWMListMoreSignThePublicKeyTableViewCell.h"
#import "HWMPublicKeyListHeadView.h"

#import "HWMPublicKeyListTabHeadView.h"

static NSString *cellString=@"HWMListMoreSignThePublicKeyTableViewCell";

@interface HWMListMoreSignThePublicKeyViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *PublicKeyListArray;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMPublicKeyListHeadView *headView;


@end

@implementation HWMListMoreSignThePublicKeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"公钥列表", nil);
    [self makeView];

}
-(HWMPublicKeyListHeadView *)headView{
    if (!_headView) {
        _headView =[[HWMPublicKeyListHeadView alloc]init];
        
    }
    return _headView;
}
-(void)makeView{
    self.baseTableView.delegate=self;
    self.baseTableView.dataSource=self;
self.baseTableView.backgroundColor=[UIColor clearColor];
    self.baseTableView.rowHeight=60;
    self.baseTableView.separatorStyle= UITableViewCellSeparatorStyleNone;

    UIView *headV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, AppWidth,60)];
    [headV addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headV.mas_left).offset(0);
        make.right.mas_equalTo(headV.mas_right).offset(0);
        make.top.bottom.mas_equalTo(headV);
        
    }];
self.baseTableView.tableHeaderView=headV;
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=self.PublicKeyListArray[section];
    if (section==0) {
      return   arr.count;
    }
       return   arr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.typeW==2) {
        return 2;
    }
    return 1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 HWMListMoreSignThePublicKeyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *addressString=[NSString stringWithFormat:@"%@",self.PublicKeyListArray[indexPath.section][indexPath.row]];
    if (self.typeW==2) {
        if (indexPath.section==0&&indexPath.row==0) {
            cell.BGView.alpha=1.f;
            
        }
    }
    cell.addressLabel.text=addressString;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 74;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *fooView =[[UIView alloc]init];
    
    fooView.backgroundColor=[UIColor clearColor];
    
    return fooView;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HWMPublicKeyListTabHeadView *headView =[[HWMPublicKeyListTabHeadView alloc]init];
    if (self.typeW==2) {
        if(section==0){
            headView.type=LocalPublicKeyType;
        }else{
            headView.type=ParticipatePublicKeyType;
        }
    }else if (self.typeW==3){
        headView.type=ParticipatePublicKeyType;
        
    }
  
    return headView;
    
}
- (NSMutableArray *)PublicKeyListArray{
    if (!_PublicKeyListArray) {
        _PublicKeyListArray =[[NSMutableArray alloc]init];
    }
    return _PublicKeyListArray;
}
-(void)setTypeW:(NSInteger)typeW{
    _typeW=typeW;
    
}
-(void)setDataDic:(NSDictionary *)DataDic{
    NSInteger n=[DataDic[@"n"] integerValue];
    [self.headView TheTotalNoMSignature:[NSString stringWithFormat:@"%ld",(long)n] withNoSignature:[NSString stringWithFormat:@"%@",DataDic[@"m"]]];
    NSArray *publicKeyRingArray=[NSArray arrayWithArray:DataDic[@"publicKeyRing"]];
    if (self.typeW==2) {
        if (n>1&&[DataDic[@"derivationStrategy"] isEqualToString:@"BIP44"]) {
            [self.PublicKeyListArray addObject:[NSArray arrayWithObject:DataDic[@"xPubKey"]]];
        }else{
           [self.PublicKeyListArray addObject:[NSArray arrayWithObject:DataDic[@"xPubKeyHDPM"]]];
            
        }
    }
    [self.PublicKeyListArray addObject:publicKeyRingArray];
    _DataDic=DataDic;
}
@end
