//
//  HWMDIDWalletListView.m
//  elastos wallet
//
//  Created by  on 2019/10/22.
//

#import "HWMDIDWalletListView.h"
#import "HWMDIDWalletListTableViewCell.h"
#import "FMDBWalletModel.h"

static NSString *cellString=@"HWMDIDWalletListTableViewCell";
@interface HWMDIDWalletListView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *walletListTestLabel;
@property (weak, nonatomic) IBOutlet UILabel *makeSureLabel;
@property (weak, nonatomic) IBOutlet UITableView *baseTable;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger selectIndex;
@end

@implementation HWMDIDWalletListView

-(instancetype)init{
    self =[super init];
    if (self) {

        self =[[NSBundle mainBundle]loadNibNamed:@"HWMDIDWalletListView" owner:nil options:nil].firstObject;
        self.userInteractionEnabled=YES;
        self.walletListTestLabel.text=NSLocalizedString(@"请选择钱包", nil);
        self.makeSureLabel.text=NSLocalizedString(@"确认", nil);
        UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ancelThePage)];
        tag.delegate=self;
        [self addGestureRecognizer:tag];
        [self.baseTable registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
//        self.baseTable.userInteractionEnabled=YES;
        self.baseTable.rowHeight=50.f;
        self.baseTable.delegate=self;
        self.baseTable.dataSource=self;
        self.selectIndex=-1;
    }
    return self;
}
-(void)ancelThePage{
    if (self.delegate) {
        [self.delegate cancelDIDListViewView];
    }
}
- (IBAction)makeSureEvent:(id)sender {
    if (self.selectIndex<0) {
        return;
    }
    if (self.delegate) {
        [self.delegate selectListIndex:self.selectIndex];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMDIDWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    FMDBWalletModel *mode=self.dataSourceArray[indexPath.row];
       cell.walletNameLabel.text=mode.walletName;
    if (self.selectIndex==indexPath.row) {
         cell.walletNameLabel.textColor=[UIColor whiteColor];
    }else{
         cell.walletNameLabel.textColor=RGBA(255, 255, 255, 0.5);
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (self.selectIndex>-1) {
//        NSIndexPath *selecIndex=[NSIndexPath indexPathForRow:self.selectIndex inSection:0];
//        HWMDIDWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString forIndexPath:selecIndex];
//          cell.walletNameLabel.textColor=RGBA(255, 255, 255, 0.5);
//    }
//    HWMDIDWalletListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString forIndexPath:indexPath];
//    cell.walletNameLabel.textColor=[UIColor whiteColor];
//    FMDBWalletModel *mode=self.dataSourceArray[indexPath.row];
//
//    cell.walletNameLabel.text=mode.walletName;
    [self.baseTable reloadData];
    self.selectIndex=indexPath.row;
    
}
-(void)setDataSourceArray:(NSArray *)dataSourceArray{
    
    _dataSourceArray=dataSourceArray;
    [self.baseTable reloadData];
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint tapPint= [gestureRecognizer locationInView:self.baseTable];
    if (tapPint.y<0) {
        return YES;
    }
    return NO;
}
@end
