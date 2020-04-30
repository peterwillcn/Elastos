//
//  BaseNavigationVC.m
//  FLWALLET
//
//  Created by  on 2018/4/11.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseNavigationVC.h"
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds

@interface BaseNavigationVC ()

@property (nonatomic, strong) UIView *lastScreenBlackMask;
/**
 *  显示上一个界面的截屏
 */
@property (nonatomic, strong) UIImageView *lastScreenShotView;
@property (nonatomic, strong)UIImage *lastImage;
/**
 *  显示上一个界面的截屏黑色背景
 */
@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic, strong)NSMutableArray *captureImgArray;


@end

@implementation BaseNavigationVC

- (UIView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIView alloc]initWithFrame:SCREEN_BOUNDS];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _lastScreenShotView = [[UIImageView alloc] initWithFrame:_backgroundView.bounds];
        _lastScreenShotView.backgroundColor = [UIColor whiteColor];
        [_backgroundView addSubview:_lastScreenShotView];
        _lastScreenBlackMask = [[UIView alloc] initWithFrame:_backgroundView.bounds];
        _lastScreenBlackMask.backgroundColor = [UIColor blackColor];
        [_backgroundView addSubview:_lastScreenBlackMask];
    }
    if (_backgroundView.superview == nil) {
        [self.view.superview insertSubview:_backgroundView belowSubview:self.view];
    }
    return _backgroundView;
}
+ (void)initialize {
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if (self.isNOBack) {
         return nil;
    }
    return [super popViewControllerAnimated:animated];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.enabled = NO;
    _panGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(dragging:)];
    _panGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_panGesture];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.captureImgArray = [NSMutableArray array];
    __weak __typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(NOBACKChanged:) name:NOBACK object:nil];
}
-(void)NOBACKChanged:(NSNotification *)notification{
    self.isNOBack=notification.object;
}
-(void)dragging:(UIScreenEdgePanGestureRecognizer*)panGesture{
    if (self.viewControllers.count<=1) {
        return;
    }
    CGFloat x= [panGesture translationInView:self.view].x;
    //    DLog(@"我滑动的劳动力 了了:%lf",x);
    if (UIGestureRecognizerStateBegan == panGesture.state) {
        self.backgroundView.hidden = NO;
        self.lastScreenShotView.image = self.lastImage;
    }else if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled){
        if (x >= 100) {
            [UIView animateWithDuration:0.25 animations:^{
                self.lastScreenBlackMask.alpha = 0;
                self.view.transform = CGAffineTransformMakeTranslation(SCREEN_BOUNDS.size.width, 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                [self.captureImgArray removeLastObject];
                self.lastImage = self.captureImgArray.lastObject;
                self.backgroundView.hidden = YES;
                self.view.transform = CGAffineTransformIdentity;
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                self.view.transform = CGAffineTransformIdentity;
                self.lastScreenBlackMask.alpha = 0.5;
            } completion:^(BOOL finished) {
                self.backgroundView.hidden = YES;
            }];
        }
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        if (x>10) {
            self.view.transform = CGAffineTransformMakeTranslation(x, 0);
            self.lastScreenBlackMask.alpha = 0.5-x/SCREEN_BOUNDS.size.width*0.5;
        }
    }
}

- (UIImage *)capture {
    UIView *view = self.view.window;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.interactivePopGestureRecognizer.enabled = YES;
    //    if (self.navigationController.viewControllers.firstObject == self) {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = false;
    //    }else{
    //        self.navigationController.interactivePopGestureRecognizer.enabled = true;
    //    }
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *img = [self capture];
        self.lastImage = img;
        if (img) {
            [self.captureImgArray addObject:img];
        }
    }
    [self.view endEditing:YES];
    [super pushViewController:viewController animated:animated];
}
@end
