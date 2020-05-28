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


#import "HWMSecretaryGeneralAndMembersInfo.h"
#import "HWMDIDManager.h"
#import "HWMCRSuggestionNetWorkManger.h"
#import "HWMSecretaryGeneralAndMembersDetailsViewModel.h"
#import "HWMSecretaryGeneralAndMembersDetailsModel.h"
#import "HMWFMDBManager.h"
static HWMSecretaryGeneralAndMembersInfo *_instance;
@interface HWMSecretaryGeneralAndMembersInfo ()
@property(strong,nonatomic)FLWallet*currentWallet;
@property(strong,nonatomic)HWMSecretaryGeneralAndMembersDetailsModel*detailsModel;
@end

@implementation HWMSecretaryGeneralAndMembersInfo

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        
        }
    });
    return _instance;
}
+(instancetype)shareTools
{
    return [[self alloc]init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}
-(void)loadDataSourceWithLoading:(BOOL)isLoading complete:(DetailsModelBlock)com{
    self.detailsModel=nil;
    if (isLoading) {
        [[FLTools share]showLoadingView];
    }
    
    NSString *didString= [self getDIDString];
    __weak __typeof__(self)weakSelf=self;
    [[HWMCRSuggestionNetWorkManger shareCRSuggestionNetWorkManger]reloadSecretaryGeneralAndMembersDetailsWithID:@"" withDIDString:didString withComplete:^(id  _Nonnull data) {
         
        NSLog(@"委员信息获取成功---%@",data);
        [self parsingModelWithData:data[@"data"] complete:^(HWMSecretaryGeneralAndMembersDetailsModel *model) {
            if (isLoading) {
                   [[FLTools share] hideLoadingView];
               }
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                  com(model);
            });
          
        }];
      [[FLTools share]hideLoadingView];
        }];

}
-(void)parsingModelWithData:(id)data complete:(DetailsModelBlock)com{
    HWMSecretaryGeneralAndMembersDetailsViewModel  *DetailsViewMode=[[HWMSecretaryGeneralAndMembersDetailsViewModel alloc] init];
    [DetailsViewMode SecretaryGeneralAndMembersDetailsModelDataJosn:data completion:^(HWMSecretaryGeneralAndMembersDetailsModel * _Nonnull model) {
        self.detailsModel=model;
        com(self.detailsModel);
    }];
}
-(FLWallet *)currentWallet{
    if (!_currentWallet) {
        NSArray *walletArray=[NSArray arrayWithArray:[[HMWFMDBManager sharedManagerType:walletType] allRecordWallet]];
        FMDBWalletModel *model =walletArray[[[STANDARD_USER_DEFAULT valueForKey:selectIndexWallet] integerValue]];
        self.currentWallet=[[FLWallet alloc]init];
        self.currentWallet.masterWalletID =model.walletID;
        self.currentWallet.walletName     =model.walletName;
        self.currentWallet.walletAddress  = model.walletAddress;
        self.currentWallet.walletID       =[NSString stringWithFormat:@"%@%@",@"wallet",[[FLTools share] getNowTimeTimestamp]];
        self.currentWallet.TypeW  = model.TypeW;
    }
    return _currentWallet;
}
-(void)deleateModel{
    self.detailsModel =nil;
}
-(HWMSecretaryGeneralAndMembersDetailsModel*)getDetailsModel{
    if (self.detailsModel) {
        return self.detailsModel;
    }
    return nil;
}
-(NSString*)getDIDString{
   return [[HWMDIDManager shareDIDManager]hasDIDWithPWD:@"" withDIDString:@"" WithPrivatekeyString:@"" WithmastWalletID:self.currentWallet.masterWalletID needCreatDIDString:NO];
}
-(NSString*)getmasterWalletID{
    return self.currentWallet.masterWalletID;
}
@end
