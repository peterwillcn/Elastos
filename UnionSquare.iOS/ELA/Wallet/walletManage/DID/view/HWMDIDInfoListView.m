//
//  HWMDIDInfoListView.m
//  elastos wallet
//
//  Created by  on 2020/2/13.
//

#import "HWMDIDInfoListView.h"
#import "HWMCreateDIDListTableViewCell.h"

static NSString *cellString=@"HWMCreateDIDListTableViewCell";
@interface HWMDIDInfoListView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleILabel;
@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation HWMDIDInfoListView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMDIDInfoListView" owner:nil options:nil].firstObject;
        self.table.delegate=self;
        self.table.dataSource=self;
        [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
           self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
           self.table.rowHeight = 55;
    }
    return self;
    
    
}
- (IBAction)backView:(id)sender {
    if (self.delegate) {
        [self.delegate closeView];
    }
    
}
-(void)setDataSourceArray:(NSMutableArray *)dataSourceArray{
    _dataSourceArray=dataSourceArray;
    [self.table reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *infDic=self.dataSourceArray[indexPath.row];
    NSString *titleString=infDic[@"test"];
    HWMCreateDIDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
             cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.infoLabel.alpha=1.f;
        cell.infoLabel.text=titleString;
        cell.intPutTextField.alpha=0.f;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSourceArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *infoDic=self.dataSourceArray[indexPath.row];
    NSString *index=infoDic[@"index"];
    if (self.delegate) {
        [self.delegate addInfoWithIndex:index];
    }
    [self.dataSourceArray removeObjectAtIndex:indexPath.row];
    [self.table reloadData];
}
@end
