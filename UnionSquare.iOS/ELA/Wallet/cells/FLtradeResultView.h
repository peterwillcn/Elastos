//
//  FLtradeResultView.h
//  FLWALLET
//
//  Created by  on 2018/5/11.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FLtradeResultView : UIView
@property (weak, nonatomic) IBOutlet UILabel *fromLab;

@property (weak, nonatomic) IBOutlet UILabel *toLab;
@property (weak, nonatomic) IBOutlet UILabel *gasLab;
@property (weak, nonatomic) IBOutlet UILabel *beizhuLab;
@property (weak, nonatomic) IBOutlet UILabel *tradeNumbLab;
@property (weak, nonatomic) IBOutlet UILabel *blackNumb;
@property (weak, nonatomic) IBOutlet UILabel *tradeTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *QRimage;
@property (weak, nonatomic) IBOutlet UILabel *valueLab;
@property (weak, nonatomic) IBOutlet UILabel *biLab;

@end
