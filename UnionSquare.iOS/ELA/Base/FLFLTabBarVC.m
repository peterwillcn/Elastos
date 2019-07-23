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
    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        NSArray *titles=@[NSLocalizedString(@"资产", nil),NSLocalizedString(@"社区", nil) ,NSLocalizedString(@"设置", nil)];
     NSArray *selectImage = @[@"tab_asset_select",@"tab_found_select",@"tab_setting_select"];
    NSArray *normalImage =@[@"tab_asset",@"tab_found",@"tab_setting"];
    
//       NSArray *Vc =@[@"FirstViewController",@"FLPrepareVC",@"FLMyVC"];
           NSArray *Vc =@[@"FirstViewController",@"HMWfoundViewController",@"FLMyVC"];
   
  
    NSMutableArray*vcArrary = [NSMutableArray array];
    
    for (int i=0 ;i<titles.count ; i++) {
      BaseNavigationVC*nv = [self setVC:Vc[i] setTitle:titles[i] normalImage:normalImage[i] selectIamge:selectImage[i]];
        [vcArrary addObject:nv];
    }
    self.viewControllers = vcArrary;
    self.tabBar.selectionIndicatorImage = [self imageWithColor:[UIColor colorWithWhite:1 alpha:0.3] size:CGSizeMake(AppWidth/self.viewControllers.count, self.tabBar.frame.size.height+40)];
    self.tabBar.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(onTxPublish:) name:OnTxPublishedResult object:nil];
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
    
    return nv;
}
//- (void)viewDidAppear:(BOOL)animated{
//    self.hidesBottomBarWhenPushed = YES;
//}
//
//-(void)viewDidDisappear:(BOOL)animated {
//    self.hidesBottomBarWhenPushed = YES;
//}
@end
