//
//  FLNetErrorView.h
//  FLWALLET
//
//  Created by  on 2018/6/21.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLNetErrorView : UIView
@property (nonatomic, copy)void(^callBack)(void);
@property(nonatomic,assign)NSInteger type;//0 默认  1 敬请期待；
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *textLab;

+(instancetype)defultView;
@end
