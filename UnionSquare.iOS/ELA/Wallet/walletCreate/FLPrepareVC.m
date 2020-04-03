//
//  FLPrepareVC.m
//  FLWALLET
//
//  Created by  on 2018/4/18.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLPrepareVC.h"
#import "FLCreatAcountVC.h"
#import "BaseNavigationVC.h"
#import "HMWImportTheWalletViewController.h"
#import "HWMcreatListViewController.h"


@interface FLPrepareVC ()

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

@end

@implementation FLPrepareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.btn1 setBackgroundColor:RGBA(255, 255, 255, 0.15) boldColor:[UIColor whiteColor] corner:0];
    [self.btn2 setBackgroundColor:RGBA(255, 255, 255, 0.15) boldColor:[UIColor whiteColor] corner:0];
    [self.btn1 setTitle:NSLocalizedString(@"创建钱包(推荐)", nil) forState:UIControlStateNormal];
     [self.btn2 setTitle:NSLocalizedString(@"导入钱包", nil) forState:UIControlStateNormal];
    
   // [self defultWhite];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.type==addWalletType) {
        BaseNavigationVC *nav = self.navigationController;
        nav.panGesture.enabled = NO;
        [self.navigationController setNavigationBarHidden:NO];
        [self defultWhite];
    }else{
        [self.navigationController setNavigationBarHidden:YES];
        
    }
//    [self.navigationController setNavigationBarHidden:YES];
   
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    BaseNavigationVC *nav = self.navigationController;
    nav.panGesture.enabled = YES;

}
- (IBAction)clickBtn1:(id)sender {
    HWMcreatListViewController *vc=[[HWMcreatListViewController alloc]init];
    
   [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)clickBtn2:(id)sender {
    HMWImportTheWalletViewController *importTheWalletVC=[[HMWImportTheWalletViewController alloc]init];
        [self.navigationController pushViewController:importTheWalletVC animated:YES];
//    FLImportWalletVC *vc = [[FLImportWalletVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setType:(FROMETYPE)type{
    _type=type;
    
}
@end
