//
//  HWMAddSocialAccountViewController.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/28.
//

#import "HWMAddSocialAccountViewController.h"
#import "HWMCreateDIDListTableViewCell.h"
#import "HWMTransactionDetailsView.h"
#import "HMWSendSuccessPopuView.h"


static NSString *cellString=@"HWMCreateDIDListTableViewCell";


@interface HWMAddSocialAccountViewController ()<UITableViewDelegate,UITableViewDataSource,HWMTransactionDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *textInfoLabel;
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *dataSorse;
@property (weak, nonatomic) IBOutlet UIButton *saveAsDraftButton;
@property (weak, nonatomic) IBOutlet UIButton *DIDInfoReleaseButton;
@property (weak, nonatomic) IBOutlet UITableView *table;
/*
 *<# #>
 */
@property(strong,nonatomic)HWMTransactionDetailsView *transactionDetailsView;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSendSuccessPopuView *sendSuccessPopuV;
@end

@implementation HWMAddSocialAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self defultWhite];
    [self setBackgroundImg:@""];
    
    self.title=NSLocalizedString(@"添加社交账号", nil);
      [self makeUI];
}
-(void)makeUI{

        self.dataSorse =@[NSLocalizedString(@"请输入个人主页网址", nil),NSLocalizedString(@"请输入谷歌账号", nil),NSLocalizedString(@"请输入微软账号", nil),NSLocalizedString(@"请输入Facebook账号",nil),
               NSLocalizedString(@"请输入Twitter账号", nil),NSLocalizedString(@"请输入微博账号",nil),@[NSLocalizedString(@"请输入微信账号",nil),NSLocalizedString(@"请输入支付宝账号",nil)],
               NSLocalizedString(@"请选择国家/地区", nil)];
        [self.saveAsDraftButton setTitle:NSLocalizedString(@"存为草稿", nil) forState: UIControlStateNormal];
        [[HMWCommView share]makeBordersWithView:self.saveAsDraftButton];
    [self.DIDInfoReleaseButton setTitle:NSLocalizedString(@"发布", nil) forState: UIControlStateNormal];
           [[HMWCommView share]makeBordersWithView:self.DIDInfoReleaseButton];
        [self.table registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
        
           self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
         self.table.rowHeight = 55;
           self.table.delegate =self;
           self.table.dataSource =self;
        self.table.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditTab)];
    [self.table addGestureRecognizer:tap];
}
-(void)endEditTab{
    [self.view endEditing:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWMCreateDIDListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *textString=self.dataSorse[indexPath.row];

            cell.arrowImageView.alpha=0.f;
            cell.intPutTextField.placeholder=textString;
            [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:cell.intPutTextField withTxt:textString];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataSorse.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)saveAsDraftEvent:(id)sender {
    [self.view endEditing:YES];
}
- (IBAction)DIDInfoReleaseEvent:(id)sender {
    [self.view endEditing:YES];
    UIView *mainView =[self mainWindow];
    [mainView addSubview:self.transactionDetailsView];
    [self.transactionDetailsView TransactionDetailsWithFee:@"2" withTransactionDetailsAumont:[NSString stringWithFormat:@"%@",@"2"]];
    [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(mainView);
    }];
}

-(HMWSendSuccessPopuView *)sendSuccessPopuV{
        if (!_sendSuccessPopuV) {
            _sendSuccessPopuV =[[HMWSendSuccessPopuView alloc]init];
        }
        return _sendSuccessPopuV;
}

-(HWMTransactionDetailsView *)transactionDetailsView{
    
    if (!_transactionDetailsView) {
        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];
        _transactionDetailsView.DetailsType=didInfoType;
        _transactionDetailsView.delegate=self;
    }
    return _transactionDetailsView;
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd{
    [self closeTransactionDetailsView];
    [self showSendSuccessPopuV];
}
-(void)closeTransactionDetailsView{
    [self.transactionDetailsView removeFromSuperview];
    self.transactionDetailsView=nil;
}
-(void)showSendSuccessPopuV{
    UIView *manView=[self mainWindow];
    [manView addSubview:self.sendSuccessPopuV];
    [self.sendSuccessPopuV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(manView);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeFromSuperview];
        self.sendSuccessPopuV=nil;
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}
@end
