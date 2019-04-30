//
//  HMWVotingListView.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWVotingListView.h"
#import "HMWVotingListCollectionViewCell.h"


static NSString *cellString=@"HMWVotingListCollectionViewCell";

@interface HMWVotingListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *baseCollectionView;

@end

@implementation HMWVotingListView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWVotingListView" owner:nil options:nil].firstObject;
        self.userInteractionEnabled=YES;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
       self.baseCollectionView.collectionViewLayout=layout;
        self.baseCollectionView.delegate=self;
        self.baseCollectionView.dataSource=self;
        [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HMWVotingListCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellString];
        self.taglab1.text = NSLocalizedString(@"全网投票占比", nil);
        self.taglab3.text = NSLocalizedString(@"当前票数", nil);


    }
    
    return self;

}
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self.baseCollectionView reloadData];
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMWVotingListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellString forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 6;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 3;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(3, 3, 3, 3);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((AppWidth-16)/3 ,135/120*AppWidth/3);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"*(*(*(*(*开始");
    if (self.delegate) {
        [self.delegate selectedVotingListWithIndex:indexPath.row];
    }
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
}

////返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
@end
