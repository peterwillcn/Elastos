//
//  HWMallDocumentsListViewController.m
//  elastos wallet
//
//  Created by  on 2020/3/24.
//

#import "HWMallDocumentsListViewController.h"
#import "HWMallDocumentsListTableViewCell.h"
#import "MyUtil.h"
UINib *DocumentsListNib;
static NSString *cellString=@"HWMallDocumentsListTableViewCell";

@interface HWMallDocumentsListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(strong,nonatomic)UIButton*skipButton;
@property(strong,nonatomic)NSMutableArray *allDirAaary;
@property(assign,nonatomic)NSInteger selectIndex;
@property(strong,nonatomic)NSMutableArray *allFlieNameArray;
@end

@implementation HWMallDocumentsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"选择文件", nil);
    self.selectIndex=-1;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:self.skipButton];
    [self loadFlieNameFromeIndex:0 withCount:10];
    [self makeUI];
    [self.table reloadData];
}
-(void)makeUI{
   DocumentsListNib=[UINib nibWithNibName:cellString bundle:nil];
    [self.table registerNib: DocumentsListNib forCellReuseIdentifier:cellString];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.rowHeight = 60;
    self.table.delegate =self;
    self.table.dataSource =self;
    self.table.backgroundColor=[UIColor clearColor];
}

-(UIButton *)skipButton{
    if (!_skipButton) {
        _skipButton =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [_skipButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font=[UIFont systemFontOfSize:14];
        [_skipButton addTarget:self action:@selector(skipVCEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allDirAaary.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMallDocumentsListTableViewCell *cell=[DocumentsListNib instantiateWithOwner:nil options:nil].firstObject;
    NSDictionary *dic=self.allDirAaary[indexPath.row];
    cell.flieNameLabel.text=dic[@"flieName"];
    if ([dic[@"didString"] isEqualToString:@"0"]) {
        cell.possibilityLabel.text=@"";
        cell.possibilityLabel.alpha=0.f;
    }else{
        cell.possibilityLabel.text=NSLocalizedString(@"可导入",nil);
        cell.possibilityLabel.alpha=1.f;
    }
    cell.timeLabel.text=dic[@"date"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSMutableArray *)allDirAaary{
    if (!_allDirAaary) {
        _allDirAaary =[[NSMutableArray alloc]init];
    }
    return _allDirAaary;
}
-(void)loadFlieNameFromeIndex:(int)index withCount:(int)count{
    int max;
    if (index+count>self.allFlieNameArray.count) {
        max=(int)self.allFlieNameArray.count-index;
    }else{
        max=count;
    }
    for (int i=index; i<max; i++) {
        NSDictionary *flieDic =self.allFlieNameArray[i];
        NSArray * array1 = [flieDic[@"fileName"] componentsSeparatedByString:@"_"];
        NSString *didString=@"0";
        if ([self.currentWallet.didString containsString:array1[2]]) {
            didString=@"1";
        }
        NSDictionary *dic=@{@"flieName":flieDic[@"fileName"],@"date":flieDic[@"date"],@"didString":didString};
        [self.allDirAaary addObject:dic];
    }
    
}
-(NSString*)hasConstDIDString:(NSString*)didString{
    
    if ([self.currentWallet.didString containsString:didString]) {
        return @"0";
    }
    return @"-1";
}
-(NSMutableArray *)allFlieNameArray{
    if (!_allFlieNameArray) {
        _allFlieNameArray=[NSMutableArray arrayWithArray:[MyUtil ReadCommDIDPath]];
    }
    return _allFlieNameArray;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.selectIndex==indexPath.row) {
//        return;
//    }
    if (self.selectIndex>-1) {
       HWMallDocumentsListTableViewCell *cell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0]];
        cell.selectImageView.alpha=0.f;
    }
        HWMallDocumentsListTableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
          cell.selectImageView.alpha=1.f;
//
    self.selectIndex=indexPath.row;
//
    
    
    
}
-(void)skipVCEvent{
    if (self.selectIndex>-1) {
        
        if (self.block) {
            NSDictionary *dic=self.allDirAaary[self.selectIndex];
            NSString *flieName=dic[@"flieName"];
            self.block(flieName);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
