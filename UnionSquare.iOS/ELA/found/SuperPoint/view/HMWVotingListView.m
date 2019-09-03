//
//  HMWVotingListView.m
//  ELA
//
//  Created by  on 2019/1/5.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWVotingListView.h"
#import "HMWVotingListCollectionViewCell.h"
#import "runningNodeListView.h"
#import "HMWVotingListTypeCrossCollectionViewCell.h"
#import "HWMCRCCommitteeElectionCollectionViewCell.h"


static NSString *cellString=@"HMWVotingListCollectionViewCell";

static NSString *crossCellString=@"HMWVotingListTypeCrossCollectionViewCell";
static NSString *crossCRCellString=@"HWMCRCCommitteeElectionCollectionViewCell";

@interface HMWVotingListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *baseCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *runningNodeListTextLabel;
/*
 *<# #>
 */
@property(copy,nonatomic)NSString *listType;
@property (weak, nonatomic) IBOutlet UIButton *modifyTheListModeButton;
@property (weak, nonatomic) IBOutlet UILabel *numberNodesTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberNodesLabel;
@property (weak, nonatomic) IBOutlet UIView *numberNodesBGView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textTopOffset;

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
        [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HMWVotingListTypeCrossCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:crossCellString];
          [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HWMCRCCommitteeElectionCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:crossCRCellString];
        self.taglab1.text = NSLocalizedString(@"全网投票占比", nil);
        self.taglab3.text = NSLocalizedString(@"当前票数", nil);
         self.runningNodeListTextLabel.text=NSLocalizedString(@"参选节点列表", nil);
        self.numberNodesTextLabel.text=NSLocalizedString(@"节点数量", nil);
        self.listType=@"1";
       

    }
    
    return self;

}
-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    self.numberNodesLabel.text=[NSString stringWithFormat:@"%lu",dataSource.count];
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
    if ([self.listType isEqualToString:@"1"]) {
        if (self.type==CRType) {
            HWMCRCCommitteeElectionCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:crossCRCellString forIndexPath:indexPath];

             cell.backgroundColor=RGB(51, 51, 51);
           cell.model = self.dataSource[indexPath.row];
            
            return cell;
        }
        HMWVotingListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellString forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.row];
        return cell;
    }
    HMWVotingListTypeCrossCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:crossCellString forIndexPath:indexPath];
    cell.backgroundColor=RGB(51, 51, 51);
    cell.model = self.dataSource[indexPath.row];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.listType isEqualToString:@"1"]) {
     return 6;
    }
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if ([self.listType isEqualToString:@"1"]) {
     return 3;
    }
    return 5;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    if ([self.listType isEqualToString:@"1"]) {
        if (self.type==CRType) {
             return UIEdgeInsetsMake(5, 8, 5, 5);
        }
           return UIEdgeInsetsMake(3, 8, 3, 3);
    }
    return UIEdgeInsetsMake(5, 8, 5, 3);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.listType isEqualToString:@"1"]) {
        if (self.type==CRType) {
            CGFloat width=(AppWidth)/2-10;
            CGFloat Height=170.f/180.f*width;
            
            return CGSizeMake(width,Height);
        }
        return CGSizeMake((AppWidth-22)/3 ,135/120*AppWidth/3);
    }
    return CGSizeMake(AppWidth-13,60);
    
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        [self.delegate selectedVotingListWithIndex:indexPath.row];
    }
}

////返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
- (IBAction)modifyTheListMode:(id)sender {
    if ([self.listType isEqualToString:@"1"]) {
        [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_squeral"] forState:UIControlStateNormal];
        self.listType=@"2";
    }else{
        [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_list"] forState:UIControlStateNormal];
      self.listType=@"1";
    }
    [self.baseCollectionView reloadData];
}
-(void)setType:(VotingListType)type{
   
    if (type==CRType) {
        self.numberNodesBGView.alpha=0.f; self.runningNodeListTextLabel.text=NSLocalizedString(@"参选委员列表", nil);
        self.textTopOffset.constant=18.f;
    }
     _type=type;
}
- (IBAction)AddModelEvent:(id)sender {
    
    
    
}
@end
