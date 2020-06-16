//
//  HMWToDeleteTheWalletPopView.m
//  ELA
//
//  Created by  on 2019/1/3.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWToDeleteTheWalletPopView.h"
#import "HMWSecurityVerificationPopView.h"

@interface HMWToDeleteTheWalletPopView ()<HMWSecurityVerificationPopViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titlePopLabel;

@property (weak, nonatomic) IBOutlet UIButton *sureToDeleteButton;
/*
 *<# #>
 */
@property(strong,nonatomic)HMWSecurityVerificationPopView *securityVerificationPopV;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleButtonConB;

@end
@implementation HMWToDeleteTheWalletPopView
-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HMWToDeleteTheWalletPopView" owner:nil options:nil].firstObject;
        [self.sureToDeleteButton setTitle:NSLocalizedString(@"确认", nil) forState:UIControlStateNormal];
        [self.cancelButton setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        
    }
    
    return self;
    
    
}
-(HMWSecurityVerificationPopView *)securityVerificationPopV{
    if (!_securityVerificationPopV) {
        _securityVerificationPopV =[[HMWSecurityVerificationPopView alloc]init];
        _securityVerificationPopV.backgroundColor=[UIColor clearColor];
        _securityVerificationPopV.delegate=self;
    }
    
    return _securityVerificationPopV;
}
- (IBAction)closeViewEvent:(id)sender {
    [self takeOutOrShutDown];
    [self.securityVerificationPopV removeFromSuperview];
    self.securityVerificationPopV =nil;
    if ([self.delegate respondsToSelector:@selector(toCancelOrCloseDelegate)]) {
        [self.delegate toCancelOrCloseDelegate];
    }
}
- (IBAction)cancelViewEvent:(id)sender {
    [self takeOutOrShutDown];
    if (self.deleteType==CoverCommitteeMembersListType) {
        if ([self.delegate respondsToSelector:@selector(CancelEvent)]) {
            [self.delegate CancelEvent];
        }
        
    }else{
    if ([self.delegate respondsToSelector:@selector(toCancelOrCloseDelegate)]) {
        [self.delegate toCancelOrCloseDelegate];
    }
        
    }
}

- (IBAction)sureToDeleteEvent:(id)sender {
    
    if (self.deleteType==deleteTheWallet) {
        self.titlePopLabel.text=NSLocalizedString(@"是否删除当前钱包？", nil);
        
        [self addSubview:self.securityVerificationPopV];
        [self.securityVerificationPopV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }else if (self.deleteType==deleteFriends){
        self.titlePopLabel.text=NSLocalizedString(@"是否删除当前联系人？", nil);
        if (self.delegate) {
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
    }else if (self.deleteType==deleteSelectVote){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
        //        [self addSubview:self.securityVerificationPopV];
        //        [self.securityVerificationPopV mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.right.top.bottom.equalTo(self);
        //        }];
    }else if (self.deleteType==moreThan36SelectList){
        //        self.titlePopLabel.text=NSLocalizedString(@"超出投票选择上限，是否在已选列表中按排名顺序选择前36名？", nil);
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
        
    }else if (self.deleteType==UtxoChangeWhole){
        
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
    }else if (self.deleteType==openIDChainType){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
        
    }else if (self.deleteType==NeedsSavedType){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
    }else if (self.deleteType==deleteCRVote){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
    }else if (self.deleteType==voteInvalidType){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
    }else if (self.deleteType==deleteDIDInfoType){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
            
        }
    }else if (self.deleteType==needCreadDIDType){
        [self addSubview:self.securityVerificationPopV];
        [self.securityVerificationPopV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }else if (self.deleteType==deleteHasSaveInfoType){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
            
        }
    }else if (self.deleteType== documentsCoveringType){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
    }else if (self.deleteType==CloseChainIDType){
        if(self.delegate){
            [self.delegate sureToDeleteViewWithPWD:@""];
        }
    }else if (self.deleteType==CoverCommitteeMembersListType){
         if(self.delegate){
              [self.delegate sureToDeleteViewWithPWD:@""];
          }
    }else if (self.deleteType==ResyncChainDataType){
         if(self.delegate){
              [self.delegate sureToDeleteViewWithPWD:@""];
          }
    }
    
}
-(void)takeOutOrShutDown{
    [self.securityVerificationPopV removeFromSuperview];
    self.securityVerificationPopV=nil;
    if ([self.delegate respondsToSelector:@selector(toCancelOrCloseDelegate)]) {
        [self.delegate toCancelOrCloseDelegate];
    }
}
-(void)makeSureWithPWD:(NSString*)pwdString{
    if ([[FLTools share]checkWhetherThePassword:pwdString]) {
        return;
    }
    [self takeOutOrShutDown];
    if (self.delegate){
        [self.delegate sureToDeleteViewWithPWD:pwdString];
    }
    
}
-(void)setDeleteType:(HMWToDeleteType)deleteType{
    if (deleteType==deleteTheWallet) {
        self.titlePopLabel.text=NSLocalizedString(@"是否删除当前钱包？", nil);
        
        
    }else if (deleteType==deleteFriends){
        self.titlePopLabel.text=NSLocalizedString(@"是否删除当前联系人？", nil);
        
    }else if (deleteType==deleteSelectVote){
        self.titlePopLabel.text= NSLocalizedString(@"是否确认注销候选资格? \n 候选资格一旦注销，所有投票清零且不可恢复。", nil);
        [self.sureToDeleteButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        
    }else if (deleteType==moreThan36SelectList){
        self.viewHeight.constant=160; self.titlePopLabel.text=NSLocalizedString(@"超出投票选择上限，是否在已选列表中按排名顺序选择前36名？", nil);
        
    }else if (deleteType==UtxoChangeWhole){
        self.viewHeight.constant=200;
        //        self.titlePopLabel.text=@"";
        self.titlePopLabel.text=[NSString stringWithFormat:@"%@ %@%@\n%@",NSLocalizedString(@"账户Utxo数量为", nil),self.UtxosString,NSLocalizedString(@"，", nil),NSLocalizedString(@"是否零钱换整？", nil)];
        self.titleButtonConB.constant=0;
    }else if (deleteType==deleteCRVote){
        self.titlePopLabel.text= NSLocalizedString(@"是否退出本届CR选举？\n一旦退出本届选举，所有投票清零且不可恢复。", nil);
        
    }else if (deleteType==openIDChainType){
        self.titlePopLabel.text= NSLocalizedString(@"该钱包尚未开启ID侧链，是否 \n 立即开启", nil);
        [self.sureToDeleteButton setTitle:NSLocalizedString(@"去开启", nil) forState:UIControlStateNormal];
        
    }else if (deleteType==NeedsSavedType){
        self.titlePopLabel.text= NSLocalizedString(@"该钱包尚未开启ID侧链，是否 \n 立即开启", nil);
        [self.sureToDeleteButton setTitle:NSLocalizedString(@"去开启", nil) forState:UIControlStateNormal];
        
    }else if (deleteType==voteInvalidType){
        self.titlePopLabel.text= NSLocalizedString(@"账户余额不足，将使之前的投票结果失效。是否继续交易？", nil);
        [self.sureToDeleteButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        
    }else if (deleteType==deleteDIDInfoType){
        self.titlePopLabel.text= NSLocalizedString(@"是否永久弃用当前DID？", nil);
        [self.sureToDeleteButton setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    }else if (deleteType==needCreadDIDType){
        self.titlePopLabel.text= NSLocalizedString(@"参选CR委员须使用DID\n是否立即创建？", nil);
        [self.sureToDeleteButton setTitle:NSLocalizedString(@"去创建", nil) forState:UIControlStateNormal];
        
    }else if (deleteType==deleteHasSaveInfoType){
        self.titlePopLabel.text= NSLocalizedString(@"是否删除本项？", nil);
        
    }else if (deleteType==documentsCoveringType){
        self.titlePopLabel.text= NSLocalizedString(@"是否覆盖当前凭证信息？", nil);
        
    }else if (deleteType==CloseChainIDType){
        self.titlePopLabel.text= NSLocalizedString(@"关闭ID侧链将无法使用DID功能，\n是否立即关闭？", nil);
    }else if (deleteType==CoverCommitteeMembersListType){
          self.titlePopLabel.text= NSLocalizedString(@"是否覆盖现有候选列表？", nil);
    }else if (deleteType==ResyncChainDataType){
          self.titlePopLabel.text= NSLocalizedString(@"是否清除并重新同步数据？", nil);
    }
    _deleteType=deleteType;
}
-(void)setUtxosString:(NSString *)UtxosString{
    _UtxosString=UtxosString;
    
    //    账户Utxo数量为65535个，
    //    是否零钱换整？
    self.titlePopLabel.text=[NSString stringWithFormat:@"%@ %@%@\n%@",NSLocalizedString(@"账户Utxo数量为", nil),UtxosString,NSLocalizedString(@"，", nil),NSLocalizedString(@"是否零钱换整？", nil)];
}
@end
