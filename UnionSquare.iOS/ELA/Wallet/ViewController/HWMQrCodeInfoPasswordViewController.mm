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
#import "HWMTransactionDetailsView.h"
#import "ELWalletManager.h"
#import "HWMDIDManager.h"
#import "JWTBase64Coder.h"

@interface HWMQrCodeInfoPasswordViewController ()<HWMCRProposalConfirmViewDelgate, HWMTransactionDetailsViewDelegate>
@property(nonatomic,strong)HWMCRProposalConfirmView *CRProposalConfirmV;
@property(nonatomic,strong)HMWSendSuccessPopuView *sendSuccessPopuV;

@property(nonatomic,strong) HWMTransactionDetailsView *transactionDetailsView;

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
        case Updatemilestone://提案追踪-负责人扫码
        {
            [self closeCRProposalConfirmV];
            
            UIView *manView = [self mainWindow];
            [manView addSubview:self.transactionDetailsView];
            [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(manView);
            }];
            break;
        }
        case Reviewmilestone://提案追踪-秘书长扫码
        {
            [self closeCRProposalConfirmV];
            
            UIView *manView = [self mainWindow];
            [manView addSubview:self.transactionDetailsView];
            [self.transactionDetailsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(manView);
            }];
            break;
        }
        default:
            break;
    }
    _type=type;
}

-(HWMTransactionDetailsView *)transactionDetailsView{
    
    
    if (!_transactionDetailsView) {
        
        _transactionDetailsView =[[HWMTransactionDetailsView alloc]init];
        
        _transactionDetailsView.popViewTitle=NSLocalizedString(@"交易详情", nil);
        _transactionDetailsView.DetailsType=TransactionDetails;
        _transactionDetailsView.delegate=self;
        [_transactionDetailsView  TransactionDetailsWithFee:@"0.0002" withTransactionDetailsAumont:nil];
        
    }
    
    return _transactionDetailsView;
    
}

#pragma mark ---------HWMTransactionDetailsView----------

-(void)closeTransactionDetailsView{
    
    [self.transactionDetailsView removeFromSuperview];
    
    self.transactionDetailsView=nil;
    
}
-(void)pwdAndInfoWithPWD:(NSString*)pwd
{
    pwd = @"xxl123456";
    if(_type == Updatemilestone)//
    {
        [self proposalTracking:pwd];
    }
    else if(_type == Reviewmilestone)
    {
        [self proposalTrackingWithReview:pwd];
    }
}

#pragma mark - 提案追踪-秘书长扫码

- (void)proposalTrackingWithReview:(NSString *)pwd
{
    [self showLoading];
    if(_type == Reviewmilestone)
    {
        
         
        if (![[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO])
        {
            return;
        }

        
        NSDictionary *dic = _PayLoadDic;
        NSDictionary *payLoadDic = @{@"ProposalHash":dic[@"data"][@"proposalhash"],
                                     @"MessageHash":dic[@"data"][@"messagehash"],
                                     @"Stage":dic[@"data"][@"stage"],
                                     @"OwnerPublicKey":dic[@"data"][@"ownerpubkey"],
                                     @"NewOwnerPublicKey":dic[@"data"][@"newownerpubkey"],
                                     @"OwnerSignature":dic[@"data"][@"ownersignature"],
                                     @"SecretaryGeneralOpinionHash":dic[@"data"][@"secretaryopinionhash"]//秘书长比负责人多个参数
        };
         
        NSString *proposaltrackingtype = dic[@"data"][@"proposaltrackingtype"];
        NSNumber *type;
        if([proposaltrackingtype isEqualToString:@"common"])
        {
            type = [NSNumber numberWithInt:0];
        }
        else if([proposaltrackingtype isEqualToString:@"progress"])
        {
            type = [NSNumber numberWithInt:1];
        }
        else if([proposaltrackingtype isEqualToString:@"rejected"])
        {
            type = [NSNumber numberWithInt:2];
        }
        else if([proposaltrackingtype isEqualToString:@"terminated"])
        {
            type = [NSNumber numberWithInt:3];
        }
        else if([proposaltrackingtype isEqualToString:@"changeOwner"])
        {
            type = [NSNumber numberWithInt:4];
        }
        else if([proposaltrackingtype isEqualToString:@"finalized"])
        {
            type = [NSNumber numberWithInt:5];
        }
        
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:payLoadDic];
        [muDic setValue:type forKey:@"Type"];
        
        NSString *newownerpubkey = dic[@"data"][@"newownerpubkey"];
        NSString *newownersignature = @"";//dic[@"data"][@"newownersignature"];
        if(newownerpubkey && ![newownerpubkey isEqualToString:@""])
        {
            newownersignature = dic[@"data"][@"newownersignature"];
            [muDic setValue:newownerpubkey forKey:@"NewOwnerPublicKey"];
            [muDic setValue:newownersignature forKey:@"NewOwnerSignature"];
        }
        else
        {
           [muDic setValue:@"" forKey:@"NewOwnerPublicKey"];
           [muDic setValue:@"" forKey:@"NewOwnerSignature"];
        }
        
        invokedUrlCommand *mommand = [[invokedUrlCommand alloc] initWithArguments:
                                      @[self.currentWallet.masterWalletID,
                                        muDic,
                                        pwd]
                                        callbackId:self.currentWallet.walletID
                                        className:@"Wallet" methodName:@"proposalTracking"];
        PluginResult *pluginResult = [[ELWalletManager share] proposalTrackingTransactionWithSecretary:mommand];
        
        if(pluginResult)
        {
            NSDictionary *resultDic = pluginResult.message[@"success"];
            NSString *txid = resultDic[@"txid"];

            
            if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO])
            {
                NSString *playString = [[FLTools share]DicToString:[self proposalTrackingRequestFileWithReview:txid]];
                NSString *jwtString = [self throuJWTStringWithplayString:playString];
                NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
                if (![REString isEqualToString:@"-1"]) {
                    NSDictionary *dic=@{@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]};
                    [self updaeJWTInfoWithDic:dic];
                }else{
                    [self showSendSuccessOrFial:SignatureFailureType];
                }
            }else{
                [self showSendSuccessOrFial:SignatureFailureType];
            }
        }else{
            [self showSendSuccessOrFial:SignatureFailureType];
        }
        
        [self hiddLoading];
    }
}
#pragma mark - 提案追踪-负责人扫码

//提案追踪-负责人扫码
- (void)proposalTracking:(NSString *)pwd
{
    [self showLoading];
    if(_type == Updatemilestone)
    {
        
         
        if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO])
        {
            
        }
        
        NSDictionary *dic = _PayLoadDic;
        NSDictionary *payLoadDic = @{@"ProposalHash":dic[@"data"][@"proposalhash"],
                                     @"MessageHash":dic[@"data"][@"messagehash"],
                                     @"Stage":dic[@"data"][@"stage"],
                                     @"OwnerPublicKey":dic[@"data"][@"ownerpubkey"],
                                     @"NewOwnerPublicKey":dic[@"data"][@"newownerpubkey"],
        };
        
        NSString *proposaltrackingtype = dic[@"data"][@"proposaltrackingtype"];
        NSNumber *type;
        if([proposaltrackingtype isEqualToString:@"common"])
        {
            type = [NSNumber numberWithInt:0];
        }
        else if([proposaltrackingtype isEqualToString:@"progress"])
        {
            type = [NSNumber numberWithInt:1];
        }
        else if([proposaltrackingtype isEqualToString:@"rejected"])
        {
            type = [NSNumber numberWithInt:2];
        }
        else if([proposaltrackingtype isEqualToString:@"terminated"])
        {
            type = [NSNumber numberWithInt:3];
        }
        else if([proposaltrackingtype isEqualToString:@"changeOwner"])
        {
            type = [NSNumber numberWithInt:4];
        }
        else if([proposaltrackingtype isEqualToString:@"finalized"])
        {
            type = [NSNumber numberWithInt:5];
        }
        NSMutableDictionary *muDic = [[NSMutableDictionary alloc] initWithDictionary:payLoadDic];
        [muDic setValue:type forKey:@"Type"];
        invokedUrlCommand *mommand = [[invokedUrlCommand alloc] initWithArguments:
                                      @[self.currentWallet.masterWalletID,
                                        muDic,
                                        pwd]
                                        callbackId:self.currentWallet.walletID
                                        className:@"Wallet" methodName:@"proposalTracking"];
        PluginResult *pluginResult = [[ELWalletManager share] proposalTrackingTransaction:mommand];
        
        if(pluginResult)
        {
            NSDictionary *resultDic = pluginResult.message[@"success"];
            NSString *signature = resultDic[@"Signature"];
            
            if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO])
            {
                NSString *playString = [[FLTools share]DicToString:[self proposalTrackingRequestFileWithString:signature]];
                NSString *jwtString = [self throuJWTStringWithplayString:playString];
                NSString *REString= [[HWMDIDManager shareDIDManager] DIDSignatureWithString:jwtString];
                if (![REString isEqualToString:@"-1"]) {
                    NSDictionary *dic=@{@"jwt":[NSString stringWithFormat:@"%@.%@",jwtString,REString]};
                    [self updaeJWTInfoWithDic:dic];
                }else{
                    [self showSendSuccessOrFial:SignatureFailureType];
                }
            }else{
                [self showSendSuccessOrFial:SignatureFailureType];
            }
        }else{
            [self showSendSuccessOrFial:SignatureFailureType];
        }
        
        [self hiddLoading];
    }
}

#pragma mark -


- (NSString *)throuJWTStringWithplayString:(NSString *)playString
{
    NSString *jwtString;
    NSDictionary * headers = @{@"alg": @"ES256",@"typ": @"JWT"};
    NSString *headerString=[[FLTools share]DicToString:headers];
    headerString=[JWTBase64Coder base64UrlEncodedStringWithData:[headerString dataUsingEncoding:NSUTF8StringEncoding]];
    playString=[JWTBase64Coder base64UrlEncodedStringWithData:[playString dataUsingEncoding:NSUTF8StringEncoding]];
    return jwtString=[NSString stringWithFormat:@"%@.%@",headerString,playString];
}
//提案追踪-负责人
- (NSDictionary *)proposalTrackingRequestFileWithString:(NSString *)String
{
    
    
    NSLog(@"proposalhashRequestFileWithString rep %@",self.jwtString);
    
    String = [String stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSDictionary *FLDic = @{
        @"command":@"updatemilestone",
        @"type":@"signature",
        @"iss":self.currentWallet.didString,
        @"iat": self.PayLoadDic[@"iat"],
        @"exp": self.PayLoadDic[@"exp"],
        @"aud": self.PayLoadDic[@"iss"],
        @"req": self.jwtString,
        @"data":String};
    return FLDic;
}
//提案追踪-秘书长
- (NSDictionary *)proposalTrackingRequestFileWithReview:(NSString *)String
{
    
    
    NSLog(@"proposalhashRequestFileWithString rep %@",self.jwtString);
    
    String = [String stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSDictionary *FLDic = @{
        @"command":@"reviewmilestone",
        @"type":@"txid",
        @"iss":self.currentWallet.didString,
        @"iat": self.PayLoadDic[@"iat"],
        @"exp": self.PayLoadDic[@"exp"],
        @"aud": self.PayLoadDic[@"iss"],
        @"req": self.jwtString,
        @"data":String};
    return FLDic;
}


- (void)updaeJWTInfoWithDic:(NSDictionary*)pare
{
    
    
    NSLog(@"calback url %@",self.PayLoadDic[@"callbackurl"]);
    NSLog(@"pare %@",pare);
    
    [HttpUrl NetPOSTHost:self.PayLoadDic[@"callbackurl"] url:@"" header:nil body:pare showHUD:NO WithSuccessBlock:^(id data) {
        [self showSendSuccessOrFial:SignatureSuccessType];
    } WithFailBlock:^(id data) {
        
        NSLog(@"error --- @%",data);
        [self showSendSuccessOrFial:SignatureFailureType];
    }];
}

#pragma mark -----

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
-(void)CRProposalConfirmWithPWD:(NSString*_Nonnull)PWD
{
    if(_type == withdrawalsType)
    {
        [self createProposalWithdrawTransaction:PWD];
    }
    
}
- (void)createProposalWithdrawTransaction:(NSString *)pwd
{
    [self showLoading];
    if(_type == withdrawalsType)
    {
        
         pwd = @"xxl123456";
        if ([[HWMDIDManager shareDIDManager]hasDIDWithPWD:pwd withDIDString:self.currentWallet.didString WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO])
        {
            
        }
        
        NSDictionary *dic = _PayLoadDic;
        NSDictionary *payLoadDic = @{@"ProposalHash":dic[@"data"][@"proposalhash"],
                                     @"OwnerPublicKey":dic[@"data"][@"ownerpublickey"]
        };
        NSArray *array = dic[@"data"][@"utxos"];
        NSString *recipient = dic[@"data"][@"recipient"];
        NSString *amount = dic[@"data"][@"amount"];
        
        NSMutableArray *utxosArray = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in array)
        {
            NSString *amount = dic[@"amount"];
            NSString *txid = dic[@"txid"];
            NSNumber *vout = dic[@"vout"];
            NSMutableDictionary *utxosDic = [[NSMutableDictionary alloc] init];
            [utxosDic setValue:amount forKey:@"Amount"];
            [utxosDic setValue:txid forKey:@"Hash"];
            [utxosDic setValue:vout forKey:@"Index"];
            [utxosArray addObject:utxosDic];
        }
        
        invokedUrlCommand *mommand = [[invokedUrlCommand alloc] initWithArguments:
                                      @[self.currentWallet.masterWalletID,
                                        payLoadDic,
                                        pwd,
                                        recipient,
                                        amount,
                                        utxosArray
                                      ]
                                                                       callbackId:self.currentWallet.walletID className:@"Wallet" methodName:@"createProposalWithdrawTransaction"];
        PluginResult *pluginResult = [[ELWalletManager share] createProposalWithdrawTransaction:mommand];
        
        if(pluginResult)
        {
            NSDictionary *resultDic = pluginResult.message[@"success"];
            [self hiddLoading];

        }
    }
}
-(void)showSendSuccessOrFial:(SendSuccessType)type{
   
    [self closeCRProposalConfirmV];
    [[FLTools share]hideLoadingView];
    self.sendSuccessPopuV.type=type;
    [self.view addSubview:self.sendSuccessPopuV];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.sendSuccessPopuV removeAllSubviews];
        self.sendSuccessPopuV=nil;
        [self.navigationController popViewControllerAnimated:NO];
    });
}
-(void)closeCRProposalConfirmV{
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
