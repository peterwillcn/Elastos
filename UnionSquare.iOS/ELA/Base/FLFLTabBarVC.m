//
//  FLFLTabBarVC.m
//  FLWALLET
//
//  Created by  on 2018/4/13.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLFLTabBarVC.h"
#import "BaseNavigationVC.h"
#import "AppDelegate.h"
#import "FirstViewController.h"

@interface FLFLTabBarVC ()

@end

@implementation FLFLTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIButton appearance] setExclusiveTouch:YES];
    [[UITabBar appearance] setTranslucent:NO];
    
    //    self.tabBar.tintColor = RGBA(255, 255, 255, 0.85);
    self.tabBar.barTintColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    
    
    NSArray *titles=@[NSLocalizedString(@"资产", nil),NSLocalizedString(@"社区", nil) ,NSLocalizedString(@"我的", nil)];
    NSArray *selectImage = @[@"tab_asset_select",@"tab_found_select",@"tab_mine_selected"];
    NSArray *normalImage =@[@"tab_asset",@"tab_found",@"tab_mine_unselected"];
    
    
    NSArray *Vc =@[@"FirstViewController",@"HMWfoundViewController",@"FLMyVC"];
    
    
    NSMutableArray*vcArrary = [NSMutableArray array];
    
    for (int i=0 ;i<titles.count ; i++) {
        BaseNavigationVC*nv = [self setVC:Vc[i] setTitle:titles[i] normalImage:normalImage[i] selectIamge:selectImage[i]];
        [vcArrary addObject:nv];
    }
    self.viewControllers = vcArrary;
    self.tabBar.selectionIndicatorImage = [self imageWithColor:RGBA(118, 143, 146,0.7) size:CGSizeMake(AppWidth/self.viewControllers.count, self.tabBar.frame.size.height+40)];
    self.tabBar.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onTxPublish:) name:OnTxPublishedResult object:nil];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBA(255, 255, 255, 0.25)} forState:UIControlStateNormal];
    
    //选中字体颜色
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBA(255, 255, 255, 0.85)} forState:UIControlStateSelected];
}

-(void)onTxPublish:(NSNotification*)notice{
    
    NSDictionary *param =notice.object;
    //    DLog(@"%@",param);
    
    //    NSInteger code =[ param[@"result"][@"Code"] integerValue];
    //    if (code == 0||code ==18) {
    //        [[FLTools share]showErrorInfo:[NSString stringWithFormat:        NSLocalizedString(@"交易成功", nil)]];
    //    }else{
    //        [[FLTools share]showErrorInfo:[NSString stringWithFormat:        NSLocalizedString(@"交易失败", nil)]];
    //    }
    
    
}
-(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    if (!color || size.width <=0 || size.height <=0) return nil;
    
    CGRect rect =CGRectMake(0.0f,0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}

-(BaseNavigationVC*)setVC:(NSString*)vc setTitle:(NSString*)title normalImage:(NSString*)image1 selectIamge:(NSString*)image2{
    UIViewController *vcvc =[[NSClassFromString(vc) alloc]init];
    BaseNavigationVC *nv = [[BaseNavigationVC alloc]initWithRootViewController:vcvc];
    nv.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:image1] selectedImage:[[UIImage imageNamed:image2]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //     NSDictionary *dictHome = [NSDictionary dictionaryWithObject:RGBA(255, 255, 255, 0.25) forKey:NSForegroundColorAttributeName];
    //    [nv.tabBarItem setTitleTextAttributes:dictHome forState:  UIControlStateReserved];
    return nv;
    
}
@end
