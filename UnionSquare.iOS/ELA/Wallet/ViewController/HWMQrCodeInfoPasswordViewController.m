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


#import "HWMQrCodeInfoPasswordViewController.h"
#import "HWMCRProposalConfirmView.h"
#import "HMWSendSuccessPopuView.h"
@interface HWMQrCodeInfoPasswordViewController ()<HWMCRProposalConfirmViewDelgate>
@property(nonatomic,strong)HWMCRProposalConfirmView *CRProposalConfirmV;
@property(nonatomic,strong)HMWSendSuccessPopuView *sendSuccessPopuV;
@end

@implementation HWMQrCodeInfoPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defultWhite];
    [self setBackgroundImg:@""];
    [self.view addSubview:self.CRProposalConfirmV];
    [self.CRProposalConfirmV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
  
    }];
}
-(void)setType:(QrCodeSignatureType)type{
    
    switch (type) {
        case ProposalLeaderType:
            self.CRProposalConfirmV.type=ProposalLeadType;
            [self.CRProposalConfirmV postWithHash:@"反馈哈希" withVotes:@"" withFee:@""];
            break;
        case SecretaryGeneralType:
            self.CRProposalConfirmV.type=SecretaryGeneType;
              [self.CRProposalConfirmV postWithHash:@"审核哈希" withVotes:@"" withFee:@"0.02 ELA"];
            break;
        case withdrawalsType:
            self.CRProposalConfirmV.type=withdrawaType;
              [self.CRProposalConfirmV postWithHash:@"收款地址" withVotes:@"xxxEAL" withFee:@"0.02 ELA"];
            break;
            
        default:
            break;
    }
    _type=type;
}
-(HWMCRProposalConfirmView *)CRProposalConfirmV{
    if (!_CRProposalConfirmV) {
        _CRProposalConfirmV=[[HWMCRProposalConfirmView alloc]init];
        _CRProposalConfirmV.delegate=self;
    }
    return _CRProposalConfirmV;
}
-(void)closeCRProposalConfirmView{
    [self.CRProposalConfirmV removeFromSuperview];
    self.CRProposalConfirmV=nil;
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)CRProposalConfirmWithPWD:(NSString*_Nonnull)PWD{
    [self showLoading];
}
-(void)showSendSuccessOrFial:(SendSuccessType)type{
   
    [self closeTransactionDetailsView];
    [[FLTools share]hideLoadingView];
    self.sendSuccessPopuV.type=type;
    [self.view addSubview:self.sendSuccessPopuV];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeAllSubviews];
        self.sendSuccessPopuV=nil;
        [self.navigationController popViewControllerAnimated:NO];
    });
}
-(void)closeTransactionDetailsView{
  [self.CRProposalConfirmV removeFromSuperview];
     self.CRProposalConfirmV=nil;
}
-(HMWSendSuccessPopuView *)sendSuccessPopuV{
    if (!_sendSuccessPopuV) {
        _sendSuccessPopuV=[[HMWSendSuccessPopuView alloc]init];
    }
    return _sendSuccessPopuV;
}
@end
