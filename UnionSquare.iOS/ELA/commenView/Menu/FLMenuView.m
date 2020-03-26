//
//  FLMenuView.m
//  RYJ
//
//  Created by  on 2018/1/31.
//  Copyright © 2018年 RongKe. All rights reserved.
//

#import "FLMenuView.h"
@interface FLMenuView  ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tabel;
@property (nonatomic, strong)UIImageView *backImg;
@end
NSString *cellid = @"cell";
@implementation FLMenuView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, AppWidth, AppHeight)];
    

    if (self) {
        self.tabel = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        if (!self.items) {
              self.items = @[@{@"img":@"data",@"title":@"数据统计"},@{@"img":@"friends",@"title":@"邀请好友"},@{@"img":@"touzi",@"title":@"我的投资"},@{@"img":@"instruction",@"title":@"投资说明"},];
        }
      
        UIImageView *back = [[UIImageView alloc]initWithFrame:frame];
        self.backImg = back;
        back.image = [UIImage imageNamed:@"menuBg"];
        self.tabel.bounces = NO;
        self.tabel.backgroundColor = [UIColor clearColor];
        self.tabel.backgroundView = back;
        self.tabel.delegate = self;
        self.tabel.dataSource = self;
        self.tabel.rowHeight = 40;
        self.tabel.showsVerticalScrollIndicator = NO;
        self.tabel.separatorInset = UIEdgeInsetsMake(0, 40, 0, 16);
        self.tabel.contentInset = UIEdgeInsetsMake(12, 6, 0,-4);
       self.tabel.separatorColor= RGBHex(0XFBBE5B);
        [self addSubview:self.tabel];
        self.tabel.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 2)];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.05];

       
    }
    return self;
    
}
-(void)setStyle:(NSInteger)style
{
    _style = style;
    self.backImg.image = [UIImage imageNamed:style?@"menuBg_white":@"menuBg"];
    
    UIColor *sColor=  RGBHex(0XA5A5A5);
    self.tabel.separatorColor =sColor;
    
     [self.tabel reloadData];
    
    
    
}
-(void)setItems:(NSArray *)items
{
    _items = items;
    if (items.count>0) {
        self.tabel.mj_h = items.count*40+12;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self invisibale];
}
-(void)invisibale{
    [self removeFromSuperview];
}
#pragma mark tabel

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = self.style ? RGBHex(0X4D4D4D):RGBHex(0xFBBE5B);
        cell.backgroundColor = [UIColor clearColor];
        
    }
    NSDictionary *dic = self.items[indexPath.row];
    NSString *img = [NSString stringWithFormat:@"%@%@",dic[@"img"],self.style?@"1":@"0"];
    cell.imageView.image = [UIImage imageNamed:img];
    cell.textLabel.text = dic[@"title"];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.FLMenuDelegate) {
        [self.FLMenuDelegate FLMenuView:self click:indexPath.row info:nil];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
