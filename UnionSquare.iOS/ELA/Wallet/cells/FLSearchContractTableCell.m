//
//  FLSearchContractTableCell.m
//  FLWALLET
//
//  Created by  on 2018/6/28.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLSearchContractTableCell.h"

@implementation FLSearchContractTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addAction:(UIButton*)sender {
    
//    NSDictionary *param = @{@"mobilePhone":[FLTools share].user.mobilePhone,
//                            @"tokenAddress": self.data.tokenAddress,
//                            @"userId": [FLTools share].user.userId,
//                            @"walletAddress": self.data.walletAddress,
//                            @"tokenName":self.data.tokenName,
//                            };
//
//        [HttpUrl NetPOSTHost:Http_WALLET url:@"/wallet/asset/definition" dict:param showHUD:YES WithSuccessBlock:^(id data) {
//            self.data.isAppend = 1;
//            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            sender.enabled = NO;
//            [sender setTitle:@"已添加" forState:UIControlStateNormal];
//            [self.addBtn setImage:nil forState:UIControlStateNormal];
//
//            [[FLTools share]showErrorInfo:@"添加成功"];
//
//        } WithFailBlock:^(id data) {
//        }];
}

@end
