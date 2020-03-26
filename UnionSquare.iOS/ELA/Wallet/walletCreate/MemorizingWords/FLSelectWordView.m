//
//  FLSelectWordView.m
//  FLWALLET
//
//  Created by  on 2018/8/17.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLSelectWordView.h"
#import "Masonry.h"
#import "DAConfig.h"

@implementation WordModel
@end

@interface FLSelectWordView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView*collect;
/*
 *<# #>
 */
//@property(strong,nonatomic)WordModel *selectModel;
@end

@implementation FLSelectWordView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setSubView];
    return self;
}
//-(WordModel *)selectModel{
//    if (!_selectModel) {
//        _selectModel =[[WordModel alloc]init];
//    }
//    return _selectModel;
//}
-(void)setSubView{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumInteritemSpacing = 10;flow.minimumLineSpacing = 10;
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 10, AppWidth-40, 200)collectionViewLayout:flow];
    self.collect.delegate = self;
    self.collect.dataSource =self;
    [self addSubview:self.collect];
    self.collect.backgroundColor = [UIColor clearColor];
    [self.collect registerNib:[UINib nibWithNibName:@"FLSelectWordCollectCell" bundle:nil] forCellWithReuseIdentifier:@"FLSelectWordCollectCell"];
    UIButton *btn = [UIView FLBtn_Text:NSLocalizedString(@"确定", nil) TextColor:[UIColor whiteColor] Fort:15];
    [btn setBackgroundColor:RGBA(63, 91, 104, 0.4) boldColor:[UIColor whiteColor] corner:0];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(sureBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(-50);
        make.height.mas_equalTo(40);
    }];
    
}
-(void)exchangeData{
    if (self.dataSource.count>3) {
        NSInteger y = self.dataSource.count;
        for (int i=0; i<3; i++) {
            [self.dataSource exchangeObjectAtIndex:(arc4random() % y) withObjectAtIndex:(arc4random() % y)];
        }
    }
}
-(void)sureBtn{
    if (self.sureBtnClick) {
        self.sureBtnClick();
    }
}
-(void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [self exchangeData];
    [self.collect reloadData];
}
#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
    
}
#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLSelectWordCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FLSelectWordCollectCell" forIndexPath:indexPath];
//    cell.backgroundColor=[UIColor yellowColor];
    WordModel*model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordModel *model =self.dataSource[indexPath.row];
    if (model.state) {
        return;
    }
    model.state = 1;
//    self.selectModel=model;
    [self exchangeData];
    [self.collect reloadData];
    if (self.callBack) {
        self.callBack(model);
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WordModel *model = self.dataSource[indexPath.row];
    if ([[FLTools share]changeisEnglish:model.word]) {
      return  CGSizeMake(model.word.length*13,20);
    }
    return  CGSizeMake(30,30);
}
-(void)canlceSelectWordModelWithWord:(NSString*)word{
    for ( WordModel *model in self.dataSource) {
        if ([model.word isEqualToString:word]) {
            model.state=0;
        }
    }
    [self.collect reloadData];
    
    
    
}
@end

//collectionCelll
@implementation FLSelectWordCollectCell
-(void)awakeFromNib
{
    [super awakeFromNib];
}
-(void)setModel:(WordModel *)model
{
    _model = model;
    self.wordLab.text =  model.word;
    self.wordLab.textColor = model.state?[UIColor grayColor]:[UIColor whiteColor];
}

@end

