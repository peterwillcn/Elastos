//
//  FLTradeInfoView.m
//  FLWALLET
//
//  Created by  on 2018/4/24.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLTradeInfoView.h"
@interface FLTradeInfoView()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIView *contentVi;

@end

@implementation FLTradeInfoView



-(void)awakeFromNib{
    [super awakeFromNib];
    [self.contentVi setBackgroundColor:nil boldColor:nil corner:8];
    self.table.dataSource = self;
    self.table.delegate =self;
}

+(instancetype)shareView{
    FLTradeInfoView *v =[[NSBundle mainBundle]loadNibNamed:@"FLTradeInfoView" owner:nil options:nil].firstObject;
    v.frame = [UIScreen mainScreen].bounds;
    return v;
}
- (IBAction)clickCancle:(UIButton*)sender {
    if (self.delegate) {
        [self.delegate TradeInfoView:self clickBtn:1];
    }
}
- (IBAction)clickSure:(UIButton*)sender {
    if (self.delegate) {
        [self.delegate TradeInfoView:self clickBtn:2];
    }
}
#pragma mark table

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSouce.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.textColor = [UIColor darkTextColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *a = self.dataSouce[indexPath.row];
    cell.textLabel.text = a[@"a"];
    cell.detailTextLabel.text = a[@"b"];
    return cell;
}
@end
