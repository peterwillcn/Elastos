//
//  FLVersionAlert.h
//  FLWALLET
//
//  Created by  on 2018/7/30.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLVersionAlert : UIView
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *UpdataBtn;
@property (weak, nonatomic) IBOutlet UIButton *GiveUpBtn;
@property (nonatomic, copy)NSString *updataUrl;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *closeViewButton;

+(instancetype)defultView;
@end
