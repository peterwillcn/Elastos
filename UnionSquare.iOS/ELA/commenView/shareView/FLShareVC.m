//
//  FLShareVC.m
//  FLWALLET
//
//  Created by  on 2018/9/21.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLShareVC.h"
#import "FLItemCollectionCell.h"
@interface FLShareVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, copy)NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flow;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end

@implementation FLShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.window.backgroundColor =[UIColor clearColor];
    self.collection.delegate =self;
    self.collection.dataSource = self;
    self.flow.itemSize = CGSizeMake(60, 90);
    self.flow.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.flow.minimumLineSpacing = 1;
    self.flow.minimumInteritemSpacing = 1;
    [self.collection registerNib:[UINib nibWithNibName:@"FLItemCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"FLItemCollectionCell"];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FLItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FLItemCollectionCell" forIndexPath:indexPath];
    FLShareModel *model = self.dataSource[indexPath.row];
    cell.iconImgWith.constant = 45;
    cell.iconImage.image = [UIImage imageNamed:model.icon];
    cell.goldLine.hidden = YES;
    cell.name.text = model.plantName;
    cell.name.textColor = [UIColor lightGrayColor];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     [UIPasteboard generalPasteboard].string =self.shareContent;
    FLShareModel *model = self.dataSource [indexPath.row];
//    [[FLTools share]showErrorInfo:[NSString stringWithFormat:@"请到%@中粘贴" ,model.plantName]];
//    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:model.UrlScheme]]) {
//        if (@available(iOS 10.0, *)) {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:model.UrlScheme] options:@{} completionHandler:^(BOOL success) {
//                [self dismissViewControllerAnimated:NO completion:nil];
//            }];
//        } else {
//            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:model.UrlScheme]];
//            [self dismissViewControllerAnimated:NO completion:nil];
//
//        }
//    }
  
}

-(NSArray *)dataSource
{
    if (!_dataSource) {
    NSArray *models = @[@{@"sharePlan":@"1",@"icon":@"wechatfriend",@"plantName":@"微信",@"UrlScheme":@"wechat://"},
    @{@"sharePlan":@"2",@"icon":@"QQfriend",@"plantName":@"QQ",@"UrlScheme":@"mqq://"},
    @{@"sharePlan":@"3",@"icon":@"weibo",@"plantName":@"微博",@"UrlScheme":@"sinaweibo://"},
                            ];
//        _dataSource = [NSArray modelArrayWithClass:FLShareModel.class json:models];
        
    }
    return _dataSource;
}
- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
@implementation FLShareModel

@end
