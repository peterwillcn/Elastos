//
//  FLCreatAcountVC.h
//  FLWALLET
//
//  Created by  on 2018/4/20.
//  Copyright © 2018年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FLCreatAcountVCDelegate <NSObject>
-(void)backTheWallet:(FLWallet*)wallet;


@end
@interface FLCreatAcountVC : UIViewController
@property(weak,nonatomic)id<FLCreatAcountVCDelegate>delegate;
@end
