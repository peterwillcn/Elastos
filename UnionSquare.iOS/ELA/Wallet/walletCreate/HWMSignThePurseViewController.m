//
//  HWMSignThePurseViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/7/2.
//

#import "HWMSignThePurseViewController.h"
#import "HWMaddSignThePursefootView.h"
#import "HWMaddSignThePurseViewTableViewCell.h"
#import "HWMSignThePurseHeadView.h"
#import "AddressPickerView.h"
#import "HWMAddThePrivateKeyViewController.h"

static NSString*cellString=@"HWMaddSignThePurseViewTableViewCell";
@interface HWMSignThePurseViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *baseTableView;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMSignThePurseHeadView *SignThePurseView;
/*
 *<# #>
 */
@property(strong,nonatomic)AddressPickerView *PickerV;


@end

@implementation HWMSignThePurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"创建多签钱包", nil);
    [self makeUI];
}
-(void)makeUI{
   
    self.baseTableView.dataSource=self;
    self.baseTableView.delegate=self;
    self.baseTableView.backgroundColor=[UIColor clearColor];
    [self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    [self.baseTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEdit)];
    [self.baseTableView addGestureRecognizer:tap];
    
}
-(AddressPickerView *)PickerV{
    if (!_PickerV) {
        _PickerV =[[AddressPickerView alloc]init];
        _PickerV.delegate=self;
        
    }
    return _PickerV;
}
- (void)sureActionWithNumber:(NSString*)number{
    self.SignThePurseView.numberLabel.text=number;
    [self closePickerView];
}
-(void)closePickerView{
    [self.PickerV removeFromSuperview];
    self.PickerV=nil;
}
-(HWMSignThePurseHeadView *)SignThePurseView{
    if (!_SignThePurseView) {
        _SignThePurseView =[[HWMSignThePurseHeadView alloc]initWithFrame:CGRectMake(130, 0, AppWidth-60, 150)];
        [_SignThePurseView.changeNumberSignatureButton addTarget:self action:@selector(aleartNumberView) forControlEvents:UIControlEventTouchUpInside];
        [_SignThePurseView.addPurseButton addTarget:self action:@selector(AddThePrivateKeyView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SignThePurseView;
}
-(void)AddThePrivateKeyView{
    HWMAddThePrivateKeyViewController*vc=[[HWMAddThePrivateKeyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)aleartNumberView{
    UIView *maView=[self mainWindow];
    [maView addSubview:self.PickerV];
    [self.PickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(maView);
    }];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return  2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
   HWMaddSignThePurseViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];

    
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.SignThePurseView;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HWMaddSignThePursefootView *footView =[[HWMaddSignThePursefootView alloc]init];
    return footView;

}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    
    return 220;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 230;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEdit];
}
-(void)endEdit{
    [self.view endEditing:YES];
}
@end
