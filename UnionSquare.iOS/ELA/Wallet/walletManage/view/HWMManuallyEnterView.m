//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import "HWMManuallyEnterView.h"
#import "HWMIPListTableViewCell.h"
#import "HMWFMDBManager.h"

static NSString *cellString=@"HWMIPListTableViewCell";

@interface HWMManuallyEnterView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,HWMIPListTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UILabel *viewTitlieLabel;
@property (weak, nonatomic) IBOutlet UITextField *IPTextField;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UITableView *listIPtabView;
@property (weak, nonatomic) IBOutlet UIButton *makeSureEvent;
@property(strong,nonatomic)NSMutableArray *ipListArray;
@end

@implementation HWMManuallyEnterView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMManuallyEnterView" owner:nil options:nil].firstObject;
        self.viewTitlieLabel.text=NSLocalizedString(@"手动输入", nil);
        [self.makeSureEvent setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        self.portTextField.delegate=self;
        self.IPTextField.delegate=self;
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.IPTextField withTxt:NSLocalizedString(@"请输入节点地址", nil)];
        [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.portTextField withTxt:NSLocalizedString(@"请输入端口号", nil)];
        [[HMWCommView share]makeBordersWithView:self.makeSureEvent];
        [self makeView];
    }
    return self;
}
- (IBAction)closeViewEvent:(id)sender {
    if (self.delegate) {
    [self.delegate closEnterView];
    }
      
}
- (IBAction)makeSure:(id)sender {
    if (self.IPTextField.text.length==0) {
        [[FLTools share] showErrorInfo:@"请输入节点地址"];
    }
    if (self.delegate) {
        [self.delegate selectIPWithString:self.IPTextField.text withPort:self.portTextField.text];
    }
}

-(void)makeView{
    self.listIPtabView.delegate=self;
    self.listIPtabView.dataSource=self;
    self.listIPtabView.backgroundColor=[UIColor clearColor];
    self.listIPtabView.rowHeight=50;
    self.listIPtabView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.listIPtabView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
    self.listIPtabView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.ipListArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMIPListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.delegate=self;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=self.ipListArray[indexPath.row];
    self.IPTextField.text=dic[@"ip"];
    self.portTextField.text=dic[@"port"];
}

-(NSMutableArray *)ipListArray{
    if(!_ipListArray){
        _ipListArray=[[NSMutableArray alloc]initWithArray:[[HMWFMDBManager sharedManagerType:IPInfoType] allIPString]];
    }
    return _ipListArray;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return [[FLTools share]textField:textField replacementString:string withStringLenth:50];
    
}
-(void)delegIP:(NSString*_Nonnull)IP delePort:(NSString*_Nullable)port{
    if ( [[HMWFMDBManager sharedManagerType:IPInfoType]delectIPString:IP withPort:port]) {
        [self.ipListArray removeAllObjects];
        [self.listIPtabView reloadData];
    }
    
}
@end
