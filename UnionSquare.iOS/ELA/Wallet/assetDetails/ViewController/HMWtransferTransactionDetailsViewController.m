//
//  HMWtransferTransactionDetailsViewController.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtransferTransactionDetailsViewController.h"
#import "HMWtransferTransactionMultipleAddressDetailsTableViewCell.h"
#import "HWMTransactionDetailsURLViewController.h"



static NSString *cellString=@"HMWtransferTransactionMultipleAddressDetailsTableViewCell";
UINib *_cellNib;
@interface HMWtransferTransactionDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *baseTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseTableHeight;
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *listTextArray;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL isOpen;

/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *OutputsArray;

/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *InputsArray;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL inputsISOpen;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger inputsISOpenCount;
/*
 *<# #>
 */
@property(assign,nonatomic)BOOL outputsISOpen;
/*
 *<# #>
 */
@property(assign,nonatomic)NSInteger outputsISOpenCount;
/*
 *<# #>
 */
@property(assign,nonatomic)CGFloat baseTabeleHeightFloat;
@end

@implementation HMWtransferTransactionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.isOpen=NO;
    [self defultWhite];
    self.inputsISOpen=NO;
    self.outputsISOpen=NO;
    [self setBackgroundImg:@""];
    self.title=NSLocalizedString(@"交易详情", nil);
    [self makeView];
    self.baseTable.estimatedRowHeight = 0;
    self.baseTable.estimatedSectionHeaderHeight = 0;
    self.baseTable.estimatedSectionFooterHeight = 0;
    if (@available(iOS 11.0, *)) {
        self.baseTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(NSMutableArray *)InputsArray{
    if (!_InputsArray) {
        _InputsArray =[[NSMutableArray alloc]init];
    }
    return _InputsArray;
}
-(NSMutableArray *)OutputsArray{
    if (!_OutputsArray) {
        _OutputsArray=[[NSMutableArray alloc]init];
    }
    
    return _OutputsArray;
}
-(NSArray *)listTextArray{
    if (!_listTextArray) {
        _listTextArray=[NSArray array];
    }
    
    return _listTextArray;
}
-(void)makeView{
    NSInteger  InputsArrayCount;
    if (self.InputsArray.count!=0) {
        InputsArrayCount=self.inputsISOpenCount-1;
    }else{
        InputsArrayCount=self.inputsISOpenCount;
    }

    NSInteger  OutputsArrayCount;
    if (self.OutputsArray.count!=0) {
       OutputsArrayCount=self.outputsISOpenCount-1;
    }else{
        OutputsArrayCount=self.outputsISOpenCount;
    }
    NSInteger allCount = 0;
  
    if (self.type==transactionSingleIntoType) {// 自转
    self.listTextArray=@[NSLocalizedString(@"交易号", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"手续费", nil),NSLocalizedString(@"输入地址", nil),NSLocalizedString(@"输出地址", nil),NSLocalizedString(@"确认时间", nil),NSLocalizedString(@"确认次数", nil),NSLocalizedString(@"交易类型", nil),NSLocalizedString(@"备注", nil)];
        allCount=InputsArrayCount+self.listTextArray.count+OutputsArrayCount;
       
    }else if (self.type==transactionSingleRollOutType){//转出
        if ([self.TypeString isEqualToString:@"8"]) {
           self.listTextArray=@[NSLocalizedString(@"交易号", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"手续费", nil),NSLocalizedString(@"输入地址", nil),NSLocalizedString(@"输出地址", nil),NSLocalizedString(@"目标地址", nil),NSLocalizedString(@"确认时间", nil),NSLocalizedString(@"确认次数", nil),NSLocalizedString(@"交易类型", nil),NSLocalizedString(@"备注", nil)]; allCount=InputsArrayCount+self.listTextArray.count+OutputsArrayCount+1;
        }else{ self.listTextArray=@[NSLocalizedString(@"交易号", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"手续费", nil),NSLocalizedString(@"输入地址", nil),NSLocalizedString(@"输出地址", nil),NSLocalizedString(@"确认时间", nil),NSLocalizedString(@"确认次数", nil),NSLocalizedString(@"交易类型", nil),NSLocalizedString(@"备注", nil)];
            allCount=InputsArrayCount+self.listTextArray.count+OutputsArrayCount;
        }
    }else if (self.type==transactionMultipleIntoType){// 转入

        if ([self.TypeString isEqualToString:@"8"]) {
            self.listTextArray=@[NSLocalizedString(@"交易号", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"输出地址", nil),NSLocalizedString(@"目标地址", nil),NSLocalizedString(@"确认时间", nil),NSLocalizedString(@"确认次数", nil),NSLocalizedString(@"交易类型", nil),NSLocalizedString(@"备注", nil)];
            
            allCount=self.listTextArray.count+OutputsArrayCount+1;
        }else{
            
            self.listTextArray=@[NSLocalizedString(@"交易号", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"输出地址", nil),NSLocalizedString(@"确认时间", nil),NSLocalizedString(@"确认次数", nil),NSLocalizedString(@"交易类型", nil),NSLocalizedString(@"备注", nil)];
            
            allCount=self.listTextArray.count+OutputsArrayCount;
        }
        
    }else if (self.type==rotationToVoteType){
        self.listTextArray=@[NSLocalizedString(@"交易号", nil),NSLocalizedString(@"交易金额", nil),
//                             NSLocalizedString(@"投票数量-1", nil),
                             NSLocalizedString(@"手续费", nil),NSLocalizedString(@"输入地址", nil),NSLocalizedString(@"输出地址", nil),NSLocalizedString(@"确认时间", nil),NSLocalizedString(@"确认次数", nil),NSLocalizedString(@"交易类型", nil),NSLocalizedString(@"备注", nil)];
        allCount=InputsArrayCount+self.listTextArray.count+OutputsArrayCount;
        
        
    }else if (self.type==NodeReturnsType){
        self.listTextArray=@[NSLocalizedString(@"交易号", nil),NSLocalizedString(@"交易金额", nil),NSLocalizedString(@"输出地址", nil),NSLocalizedString(@"确认时间", nil),NSLocalizedString(@"确认次数", nil),NSLocalizedString(@"交易类型", nil),NSLocalizedString(@"备注", nil)];
        allCount=InputsArrayCount+self.listTextArray.count+OutputsArrayCount;
        
    }
    CGFloat con=allCount*44+20;
    if (AppHeight-100<con) {
        con=AppHeight-100;
    }
    self.baseTableHeight.constant=con;
    self.baseTabeleHeightFloat=self.baseTableHeight.constant;
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.rowHeight=44;
    _cellNib=[UINib nibWithNibName:cellString bundle:nil];
    self.baseTable.backgroundColor=RGBA(0, 0, 0, 0.5);
    [self.baseTable registerNib:_cellNib forCellReuseIdentifier:cellString];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [[HMWCommView share]makeBordersWithView:self.baseTable];
    [self.baseTable reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listTextArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }
    return 0.01;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==self.listTextArray.count) {
        return 10;
    }
    if (self.type == transactionSingleIntoType&&section==3&&self.InputsArray.count>2) {
        if (self.inputsISOpen) {
            return 80;
        }
        return 40;
    }
    if (self.type == transactionSingleIntoType &&section==4&&self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
            return 80;
        }
        return 40;
    }
    if (self.type == transactionSingleRollOutType&&section==3&&self.InputsArray.count>2) {
        if (self.inputsISOpen) {
            return 80;
        }
         return 40;
    }
    if (self.type == transactionSingleRollOutType &&section==4&&self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
            return 80;
        }
        return 40;
    }
    if (self.type == transactionMultipleIntoType &&section==2&& self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
            return 80;
        }
         return 40;
    }
    if (self.type == rotationToVoteType&&section==4&&self.InputsArray.count>2) {
        if (self.inputsISOpen) {
            return 80;
        }
        return 40;
    }
    if (self.type == rotationToVoteType &&section==5&&self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
            return 80;
        }
        return 40;
    }
    
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.type == transactionSingleIntoType&&section==3) {
        return self.inputsISOpenCount;
    }
    if (self.type == transactionSingleIntoType &&section==4) {
       return self.outputsISOpenCount;
    }
    if (self.type == transactionSingleRollOutType&&section==3) {
        return self.inputsISOpenCount;
    }
    if (self.type == transactionSingleRollOutType &&section==4) {
        return self.outputsISOpenCount;
    }
    if (self.type == transactionMultipleIntoType &&section==2) {
        return self.outputsISOpenCount;
    }
    if (self.type == rotationToVoteType &&section==4) {
        return self.inputsISOpenCount;
    }
    if (self.type == rotationToVoteType &&section==5) {
        return self.outputsISOpenCount;
    }
    
    
    return 1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *openOrCloseButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, AppWidth, 40)];
    openOrCloseButton.tag=section;
    NSString * imageString;
    if (self.inputsISOpen||self.outputsISOpen) {
          [openOrCloseButton setTitle:NSLocalizedString(@"完整信息请点击交易号查看", nil) forState:UIControlStateNormal];
        openOrCloseButton.titleLabel.font=[UIFont systemFontOfSize:11 weight:UIFontWeightMedium];
        openOrCloseButton.titleEdgeInsets=UIEdgeInsetsMake(-20, -10, 0, 0);
         openOrCloseButton.imageEdgeInsets=UIEdgeInsetsMake(20, AppWidth/2-50, 0, 0);
        CGRect form= openOrCloseButton.frame;
        form.size.width=80;
        openOrCloseButton.frame=form;
    }else{
        [openOrCloseButton setTitle:nil forState:UIControlStateNormal];
        openOrCloseButton.imageEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 0);
    }
 
    
    if (self.type == transactionSingleIntoType&&section==3&&self.InputsArray.count>2) {
        if (self.inputsISOpen) {
            imageString=@"asset_list_unfold";
          
        }else{
            imageString=@"setting_linkman_detail_click";
        }
        [openOrCloseButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [openOrCloseButton addTarget:self action:@selector(inputsOpenOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];

        return  openOrCloseButton;
    }
    if (self.type == transactionSingleIntoType &&section==4&&self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
            imageString=@"asset_list_unfold";
        }else{
            imageString=@"setting_linkman_detail_click";
        }
        [openOrCloseButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [openOrCloseButton addTarget:self action:@selector(OutputsOpenOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    
       return  openOrCloseButton;
    }
    if (self.type == transactionSingleRollOutType&&section==3&&self.InputsArray.count>2) {
        if (self.inputsISOpen) {
            imageString=@"asset_list_unfold";
        }else{
            imageString=@"setting_linkman_detail_click";
        }
        [openOrCloseButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [openOrCloseButton addTarget:self action:@selector(inputsOpenOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        return  openOrCloseButton;
    }
    if (self.type == transactionSingleRollOutType &&section==4&&self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
            imageString=@"asset_list_unfold";
        }else{
            imageString=@"setting_linkman_detail_click";
        }
        [openOrCloseButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [openOrCloseButton addTarget:self action:@selector(OutputsOpenOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
       return  openOrCloseButton;
    }
    if (self.type == transactionMultipleIntoType &&section==2&& self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
                imageString=@"asset_list_unfold";
            }else{
                imageString=@"setting_linkman_detail_click";
            }
        [openOrCloseButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [openOrCloseButton addTarget:self action:@selector(OutputsOpenOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
       return  openOrCloseButton;
    }
    
    if (self.type == rotationToVoteType&&section==4&&self.InputsArray.count>2) {
        if (self.inputsISOpen) {
            imageString=@"asset_list_unfold";
            
        }else{
            imageString=@"setting_linkman_detail_click";
        }
        [openOrCloseButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [openOrCloseButton addTarget:self action:@selector(inputsOpenOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return  openOrCloseButton;
    }
    if (self.type == rotationToVoteType &&section==5&&self.OutputsArray.count>2) {
        if (self.outputsISOpen) {
            imageString=@"asset_list_unfold";
        }else{
            imageString=@"setting_linkman_detail_click";
        }
        [openOrCloseButton setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
        [openOrCloseButton addTarget:self action:@selector(OutputsOpenOrCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return  openOrCloseButton;
    }
    
    
    return NULL;
}
-(void)OutputsOpenOrCloseAction:(UIButton*)button{
    self.outputsISOpen=!self.outputsISOpen;
    if (self.outputsISOpen) {
        self.outputsISOpenCount=self.OutputsArray.count;
    }else{
        if (self.OutputsArray.count>2) {
            self.outputsISOpenCount=2;
        }else{
            self.outputsISOpenCount=self.OutputsArray.count;
        }
        
    }
  
    
    
    NSString * imageString;
    
        if (self.outputsISOpen) {
            imageString=@"asset_list_unfold";
        }else{
            imageString=@"setting_linkman_detail_click";
        }
    [button setImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    if ((self.listTextArray.count+self.outputsISOpenCount+self.inputsISOpenCount)*44>(AppHeight-110)) {
        self.baseTableHeight.constant=(AppHeight-110);
    }else{ self.baseTableHeight.constant=(self.listTextArray.count+self.outputsISOpenCount+self.inputsISOpenCount)*44;
        
    }
    NSIndexSet * indexSet=[[NSIndexSet alloc]initWithIndex:button.tag];
    [self.baseTable reloadSections:indexSet withRowAnimation: UITableViewRowAnimationAutomatic];
    
}
-(void)inputsOpenOrCloseAction:(UIButton*)button{
    self.inputsISOpen=!self.inputsISOpen;
    if (self.inputsISOpen) {
        self.inputsISOpenCount=self.InputsArray.count;
    }else{
        if (self.InputsArray.count>2) {
            self.inputsISOpenCount=2;
        }else{
            
            self.inputsISOpenCount=self.InputsArray.count;
        }
        
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:button.tag];
    if ((self.listTextArray.count+self.outputsISOpenCount+self.inputsISOpenCount)*44>(AppHeight-110)) {
        self.baseTableHeight.constant=(AppHeight-110);
    }else{ self.baseTableHeight.constant=(self.listTextArray.count+self.outputsISOpenCount+self.inputsISOpenCount)*44;
        
    }
    [self.baseTable reloadSections:indexSet withRowAnimation: UITableViewRowAnimationAutomatic];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMWtransferTransactionMultipleAddressDetailsTableViewCell *cell=[_cellNib instantiateWithOwner:nil options:nil][0];
    
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.orderDetailsLabel.textColor=[UIColor whiteColor];
    cell.textLabel.text=self.listTextArray[indexPath.section];
    if (indexPath.row!=0) {
        cell.textLabel.alpha=0.f;
    }else{
         cell.textLabel.alpha=1.f;
        
    }
     cell.orderDetailsLabel.font=[UIFont systemFontOfSize:14];
    if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"交易号", nil)]) {
          cell.textLabelWidth.constant=95;
        cell.orderDetailsLabel.numberOfLines=1;
        cell.orderDetailsLabel.text=self.model.TxHash;
        cell.orderDetailsLabel.textColor=RGB(28, 164, 252);
        cell.textOffset.constant=10;
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"交易金额", nil)]){
          cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.text=self.model.Amount;
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"手续费", nil)]){
          cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.text=self.model.Fee;

    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"输入地址", nil)]){
        
        cell.textLabelWidth.constant=60;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.font=[UIFont systemFontOfSize:10]; cell.orderDetailsLabel.text=self.InputsArray[indexPath.row];
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"输出地址", nil)]){
        cell.textLabelWidth.constant=60;
        cell.textOffset.constant=7;
       cell.orderDetailsLabel.font=[UIFont systemFontOfSize:10]; cell.orderDetailsLabel.text=self.OutputsArray[indexPath.row];
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"确认时间", nil)]){
         cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.text=self.model.Timestamp;
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"确认次数", nil)]){
          cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
    cell.orderDetailsLabel.text=self.model.ConfirmStatus;
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"交易类型", nil)]){
          cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.text=self.model.Type;
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"备注", nil)]){
          cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.text=self.model.Memo;
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"投票数量-1", nil)]){
          cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.text=self.votesString;
    }else if ([cell.textLabel.text isEqualToString:NSLocalizedString(@"目标地址", nil)]){
          cell.textLabelWidth.constant=95;
        cell.textOffset.constant=7;
        cell.orderDetailsLabel.font=[UIFont systemFontOfSize:10]; cell.orderDetailsLabel.text=self.PayloadInfoString;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *titiString=NSLocalizedString(@"交易号", nil);
    if ( [self.listTextArray[indexPath.section] isEqualToString:titiString]&&[self.iconNameString isEqualToString:@"ELA"]) {
        HWMTransactionDetailsURLViewController *transactionDetailsURLVC=[[HWMTransactionDetailsURLViewController alloc]init];
        transactionDetailsURLVC.urlString=self.model.TxHash;
        [self.navigationController pushViewController:transactionDetailsURLVC animated:YES];
        
    }
   
    
//    目前用的是这个url  https://blockchain-regtest.elastos.org/

}
-(void)setType:(transactionSingleType)type{
    _type=type;
}
-(void)setModel:(assetDetailsModel *)model{
    _model=model;
    NSDictionary *OutputsDic=[[NSDictionary alloc]initWithDictionary:model.Outputs];
 for(NSString *key in OutputsDic){
        NSString *elaKey=[NSString stringWithFormat:@"%@\n%@ %@",key,[[FLTools share] elaScaleConversionWith:OutputsDic[key]],@"ELA"];
        
        [self.OutputsArray addObject:elaKey];
    }
     NSDictionary *InputsDic=[[NSDictionary alloc]initWithDictionary:model.Inputs];
    for(NSString *key in InputsDic){
  NSString *elaKey=[NSString stringWithFormat:@"%@\n%@ %@",key,[[FLTools share] elaScaleConversionWith:InputsDic[key]],@"ELA"];
        
        [self.InputsArray addObject:elaKey];
    }
    if (self.InputsArray.count>2) {
        self.inputsISOpenCount=2;
    }else{
        self.inputsISOpenCount=self.InputsArray.count;
    }
    if (self.OutputsArray.count>2) {
         self.outputsISOpenCount=2;
    }else{
         self.outputsISOpenCount=self.OutputsArray.count;
        
    }
    if(self.type ==NodeReturnsType){
        NSString *elaKey=[NSString stringWithFormat:@"%@",model.Address];
        [self.OutputsArray addObject:elaKey];
    }
    
}
-(void)setVotesString:(NSString *)votesString{
    _votesString=votesString;
    
}
-(void)setTypeString:(NSString *)TypeString{
    _TypeString=TypeString;
    
}
-(void)setPayloadInfoString:(NSString *)PayloadInfoString{
    _PayloadInfoString=PayloadInfoString;
    
}
@end
