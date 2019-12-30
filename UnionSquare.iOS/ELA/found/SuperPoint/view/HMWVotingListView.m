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
#import "HWMCRVotingListCollectionViewCell.h"
#import "HWMCRListModel.h"

static NSString *cellString=@"HMWVotingListCollectionViewCell";

static NSString *crossCellString=@"HMWVotingListTypeCrossCollectionViewCell";
static NSString *crossCRCellString=@"HWMCRCCommitteeElectionCollectionViewCell";
static NSString *ListCRCellString=@"HWMCRVotingListCollectionViewCell";

@interface HMWVotingListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

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
@property (weak, nonatomic) IBOutlet UIButton *AddModelButton;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isEdiet;
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
         __weak __typeof(self) weakSelf = self;
        
        self.baseCollectionView.alwaysBounceVertical=YES;
        self.baseCollectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{


            if (weakSelf.delegate) {
                [weakSelf.delegate updateDataInfo];
            }

        }];
        [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HMWVotingListCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellString];
        [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HMWVotingListTypeCrossCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:crossCellString];
          [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HWMCRCCommitteeElectionCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:crossCRCellString];
           [self.baseCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HWMCRVotingListCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ListCRCellString];
        
    

     

        self.taglab1.text = NSLocalizedString(@"全网投票占比", nil);
        self.taglab3.text = NSLocalizedString(@"当前票数", nil);
         self.runningNodeListTextLabel.text=NSLocalizedString(@"参选节点列表", nil);
        self.numberNodesTextLabel.text=NSLocalizedString(@"节点数量", nil);
        self.listType=@"1";
    }
 return self;
}

-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource =[[NSMutableArray alloc]initWithArray:dataSource];
    self.numberNodesLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)dataSource.count];
        [self.baseCollectionView reloadData];
    [self.baseCollectionView.mj_header endRefreshing];
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
            cell.isEdiet=self.isEdiet;
           cell.model = self.dataSource[indexPath.row];
            if (indexPath.row==0&&[self.typeString isEqualToString:@"Registered"]) {
                    cell.backgroundColor=RGB(48, 124, 162);
            }else{
                cell.backgroundColor=RGB(92, 116, 120);
            }
            
            return cell;
        }
        HMWVotingListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellString forIndexPath:indexPath];
        cell.model = self.dataSource[indexPath.row];
        if (indexPath.row==0&&[self.typeString isEqualToString:@"Registered"]) {
                       cell.backgroundColor=RGB(48, 124, 162);
               }
        else{
            cell.backgroundColor=[UIColor clearColor];
               }
        return cell;
    }
    if (self.isEdiet&&self.type==CRType&&[self.listType isEqualToString:@"2"]) {
        HWMCRVotingListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:ListCRCellString forIndexPath:indexPath];
        if (indexPath.row==0&&[self.typeString isEqualToString:@"Registered"]) {
                cell.backgroundColor=RGB(48, 124, 162);
        }
        else{
           cell.backgroundColor=[UIColor clearColor];
        }
        cell.model = self.dataSource[indexPath.row];
        return cell;
    }
    
    HMWVotingListTypeCrossCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:crossCellString forIndexPath:indexPath];
    cell.backgroundColor=RGB(51, 51, 51);
    if (self.type==CRType) {
        cell.CRModel = self.dataSource[indexPath.row];
        if (indexPath.row==0&&[self.typeString isEqualToString:@"Registered"]) {
             cell.backgroundColor=RGB(48, 124, 162);
        }else{
               cell.backgroundColor=[UIColor clearColor];
            }
    }else{
        cell.model = self.dataSource[indexPath.row];
        if (indexPath.row==0&&[self.typeString isEqualToString:@"Registered"]) {
                       cell.backgroundColor=RGB(48, 124, 162);
        }else{
                   cell.backgroundColor=[UIColor clearColor];
               }
    }
   
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
        if (self.type==CRType) {
            if (self.isEdiet){
                    FLCoinPointInfoModel *model=self.dataSource[indexPath.row];
                if (model.isCellSelected==NO) {
                model.isNewCellSelected=!model.isNewCellSelected;
                    self.dataSource[indexPath.row]=model;
                    [collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
                }
                 return;
            }
        }
   
    if (self.delegate) {
        [self.delegate selectedVotingListWithIndex:indexPath.row];
    }
}

////返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
-(void)AddAllTheCRList{
    
    [self modifyTheListMode:nil];
}
- (IBAction)modifyTheListMode:(id)sender {
    if (self.type==CRType) {
        if ([self.listType isEqualToString:@"1"]) {
            if (self.isEdiet){
                self.AddModelButton.alpha=1.f;
                [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_list"] forState:UIControlStateNormal];
                self.isEdiet=NO;
                if (self.delegate) {
                    [self.delegate VotingListisEdite:self.isEdiet];
                }
            }else{
                self.listType=@"2";
                  [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_squeral"] forState:UIControlStateNormal];
            }
        }else{
            if (self.isEdiet){
                self.AddModelButton.alpha=1.f;
                [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_squeral"] forState:UIControlStateNormal];
                self.isEdiet=NO;
                if (self.delegate) {
                    [self.delegate VotingListisEdite:self.isEdiet];
                }
            }else{
                [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_list"] forState:UIControlStateNormal];
                self.listType=@"1";
            }
        }
    }else{
        if ([self.listType isEqualToString:@"1"]) {
                self.listType=@"2";
            [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_squeral"] forState:UIControlStateNormal];
        }else{
            [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"vote_switch_list"] forState:UIControlStateNormal];
            self.listType=@"1";
        }
    }
    [self.baseCollectionView reloadData];
}
-(void)setType:(VotingListType)type{
    if (type==CRType) {
        self.numberNodesBGView.alpha=0.f; self.runningNodeListTextLabel.text=NSLocalizedString(@"参选委员列表", nil);
        self.textTopOffset.constant=18.f;
        self.AddModelButton.alpha=1.f;
    }
     _type=type;
}
- (IBAction)AddModelEvent:(id)sender {
    self.isEdiet=YES;
    if (self.isEdiet) {
        self.AddModelButton.alpha=0.f;
        [self.modifyTheListModeButton setImage:[UIImage imageNamed:@"asset_adding_select"] forState:UIControlStateNormal];
    }
    if (self.delegate) {
        [self.delegate VotingListisEdite:self.isEdiet];
    }
    [self.baseCollectionView reloadData];
}
-(void)selectAllListWithIsSelect:(BOOL)isSelectAll{
    if (self.type==CRType) {
        if (isSelectAll){
            for (int i=0; i<self.dataSource.count; i++) {
                 FLCoinPointInfoModel *model=self.dataSource[i];
                if (model.isCellSelected==NO) {
                    model.isNewCellSelected=YES;
                    self.dataSource[i]=model;
                }
            }
        }else{
            for (int i=0; i<self.dataSource.count; i++) {
                FLCoinPointInfoModel *model=self.dataSource[i];
                if (model.isCellSelected==NO) {
                    model.isNewCellSelected=NO;
                    self.dataSource[i]=model;
                }
            }
        }
    }else if (self.type==NodeElectioType){
    if (isSelectAll) {
        for (int i=0; i<self.dataSource.count; i++) {
             FLCoinPointInfoModel *model=self.dataSource[i];
            model.isCellSelected=YES;
            self.dataSource[i]=model;
        }
    }else{
        for (int i=0; i<self.dataSource.count; i++) {
            FLCoinPointInfoModel *model=self.dataSource[i];
            model.isCellSelected=NO;
            self.dataSource[i]=model;
        }
    }
    }
    [self.baseCollectionView reloadData];
}
-(void)setTypeString:(NSString *)typeString{
    _typeString=typeString;
}-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    

    if (self.delegate&&self.dataSource.count==0) {
        [self.delegate updateDataInfo];
    }
}
@end
