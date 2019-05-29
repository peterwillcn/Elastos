//
//  FLGoToIdentyAlertView.h
//  FLWALLET
//
//  Created by  on 2018/7/13.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLGoToIdentyAlertView : UIView
@property (nonatomic, copy)void(^viewCallBack)(NSInteger i);
@property (nonatomic, assign)NSInteger type;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end
