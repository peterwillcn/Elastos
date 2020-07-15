//
//  FLwalletSelectView.m
//  FLWALLET
//
//  Created by  on 2018/4/18.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLwalletSelectView.h"
#import "FLItemCollectionCell.h"
#import "FLTools.h"
@interface FLwalletSelectView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flow;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic, strong)NSArray *dataSourse;

@end

@implementation FLwalletSelectView

+(instancetype)shareView{
    FLwalletSelectView *v = [[NSBundle mainBundle]loadNibNamed:@"FLwalletSelectView" owner:nil options:nil].lastObject;
    v.frame = [UIScreen mainScreen].bounds;
    return v;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    

    self.collection.delegate =self;
    self.collection.dataSource = self;
    self.flow.itemSize = CGSizeMake(80, 90);
    self.flow.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    self.flow.minimumLineSpacing = 0;
    [self.collection registerNib:[UINib nibWithNibName:@"FLItemCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"FLItemCollectionCell"];

    self.menuView.frame =CGRectMake(0, 0, AppWidth, 150);
    self.menuView.transform = CGAffineTransformMakeTranslation(0, -150);
    [self addSubview:self.menuView];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.menuView.bounds;
//
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.menuView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
//    //赋值
//    maskLayer.path = path.CGPath;
//    self.menuView.layer.mask = maskLayer;
    [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.menuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {

    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removed];
}
-(void)removed{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.menuView.transform = CGAffineTransformMakeTranslation(0, -130);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (IBAction)click2:(id)sender {
    if (self.delegate) {
        [self.delegate memu:self clickBtn:2];
    }
}
- (IBAction)click:(id)sender {
    if (self.delegate) {
        [self.delegate memu:self clickBtn:1];
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FLItemCollectionCell" forIndexPath:indexPath];
    FLWallet *dict = self.dataSourse[indexPath.row];
    NSString *logoN=dict.logoNumber;
    if (logoN.length==0) {
        logoN= [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    
    cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"walletListIcon0%@",logoN]];
    cell.goldLine.hidden = indexPath.row ==0;
    cell.name.text = dict.walletName;
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourse.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.selectIndext) {
        return;
    }
    if (self.delegate) {
        [self.delegate memu:self clickWallet:indexPath.row];
    }
}

@end
