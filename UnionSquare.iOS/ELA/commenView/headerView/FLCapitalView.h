//
//  FLCapitalView.h
//  FLWALLET
//
//  Created by  on 2018/4/16.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FLCapitalViewDelegate <NSObject>
-(void)capitalViewDidClick:(NSInteger)index;
@end

@interface FLCapitalView : UIView

@property (weak, nonatomic) IBOutlet UIButton *restoreBtn;

@property(weak,nonatomic)id<FLCapitalViewDelegate>delegaate;
@end
