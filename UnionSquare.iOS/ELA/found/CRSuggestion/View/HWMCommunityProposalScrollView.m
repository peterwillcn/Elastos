//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import "HWMCommunityProposalScrollView.h"

@interface HWMCommunityProposalScrollView ()<UIScrollViewDelegate>
@property (strong, nonatomic)  UIButton *allButton;
@property (strong, nonatomic)  UIView *allView;
@property (strong, nonatomic)  UIButton *MemberReviewButton;
@property (strong, nonatomic)  UIView *MemberReviewView;
@property (strong, nonatomic)  UIButton *publicButton;
@property (strong, nonatomic)  UIView *publicView;
@property (strong, nonatomic)  UIButton *executionButton;
@property (strong, nonatomic)  UIView *executionView;
@property (strong, nonatomic)  UIButton *completedButton;
@property (strong, nonatomic)  UIView *completedView;
@property (strong, nonatomic)  UIButton *abolishedButton;
@property (weak, nonatomic) IBOutlet UIScrollView *buttonScrollV;
@property (assign, nonatomic)  CGFloat scConWidth;

@property (strong, nonatomic)  UIView *abolishedView;
@end


@implementation HWMCommunityProposalScrollView
-(instancetype)init{
    self=[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMCommunityProposalScrollView" owner:nil options:nil].firstObject;
        self.buttonScrollV.delegate=self;
        self.buttonScrollV.userInteractionEnabled=YES;
        self.buttonScrollV.showsHorizontalScrollIndicator = NO;
        self.buttonScrollV.alwaysBounceVertical=NO;
        [self makeUI];
        
    }
    return self;
}
-(void)makeUI{
    [self allButtonWithTag:10  withTitle:NSLocalizedString(@"全部", nil)];
    [self allButtonWithTag:11 withTitle:NSLocalizedString(@"委员评议", nil)];
    [self allButtonWithTag:12 withTitle:NSLocalizedString(@"公示中1", nil)];
    [self allButtonWithTag:13 withTitle:NSLocalizedString(@"执行中", nil)];
    [self allButtonWithTag:14 withTitle:NSLocalizedString(@"已完成", nil)];
    [self allButtonWithTag:15 withTitle:NSLocalizedString(@"已废止", nil)];
    self.buttonScrollV.frame=CGRectMake(0, 0, AppWidth, 60);
    self.buttonScrollV.contentSize = CGSizeMake(self.scConWidth,0);
    [self StateSelectedWithButton:self.allButton withNormalView:self.allView];
}
-(IBAction)buttonChangeEvent:(id)sender {
    UIButton *button=sender;
    NSInteger buttonTag=button.tag;
    [self allButtonStateNormal];
    if ([self.delegate respondsToSelector:@selector(CommunityProposalScrollWithIndex:)]) {
        [self.delegate CommunityProposalScrollWithIndex:buttonTag-10];
    }
    switch (buttonTag) {
        case 10:
            [self StateSelectedWithButton:self.allButton withNormalView:self.allView];
            break;
        case 11:
            [self StateSelectedWithButton:self.MemberReviewButton withNormalView:self.MemberReviewView];
            break;
        case 12:
            [self StateSelectedWithButton:self.publicButton withNormalView:self.publicView];
            break;
        case 13:
            [self StateSelectedWithButton:self.executionButton withNormalView:self.executionView];
            break;
        case 14:
            [self StateSelectedWithButton:self.completedButton withNormalView:self.completedView];
            break;
        case 15:
            [self StateSelectedWithButton:self.abolishedButton withNormalView:self.abolishedView];
            break;
        default:
            break;
    }
}

-(void)allButtonStateNormal{
    [self StateNormalWithButton:self.allButton withNormalView:self.allView];
    [self StateNormalWithButton:self.MemberReviewButton withNormalView:self.MemberReviewView];
    [self StateNormalWithButton:self.publicButton withNormalView:self.publicView];
    [self StateNormalWithButton:self.executionButton withNormalView:self.executionView];
    [self StateNormalWithButton:self.completedButton withNormalView:self.completedView];
    [self StateNormalWithButton:self.abolishedButton withNormalView:self.abolishedView];
}
-(void)StateNormalWithButton:(UIButton*)button withNormalView:(UIView*)subView{
    [button setTitleColor:RGBA(255, 255, 225, 0.5) forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:11];
    subView.alpha=0.f;
    
}
-(void)StateSelectedWithButton:(UIButton*)button withNormalView:(UIView*)subView{
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont systemFontOfSize:13];
    subView.alpha=1.f;
}
-(void)allButtonWithTag:(NSInteger)tag  withTitle:(NSString*)title{
    CGFloat BttonWidth=[[FLTools share]calculateRowWidth:title withTextFont:13];
    CGFloat makeViewWidth=BttonWidth;
    UIView *makeView=[[UIView alloc]init];
    makeView.backgroundColor=[UIColor whiteColor];
    BttonWidth=makeViewWidth+30;
    UIButton * button =[[UIButton alloc]initWithFrame:CGRectMake(self.scConWidth, 0,BttonWidth, 60)];
    button.tag=tag;
    [button setTitle:title forState:UIControlStateNormal];
    [self StateNormalWithButton:button withNormalView:makeView];
    [button addTarget:self action:@selector(buttonChangeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:makeView];
    [makeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button.mas_centerX).offset(0);
        make.bottom.equalTo(button.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(makeViewWidth, 2));
    }];
    [self.buttonScrollV addSubview:button];
    self.scConWidth=self.scConWidth+BttonWidth;
    switch (tag) {
        case 10:
            self.allButton=button;
            self.allView=makeView;
            break;
        case 11:
            self.MemberReviewButton=button;
            self.MemberReviewView=makeView;
            break;
        case 12:
            self.publicButton=button;
            self.publicView=makeView;
            break;
        case 13:
            self.executionButton=button;
            self.executionView=makeView;
            break;
        case 14:
            self.completedButton=button;
            self.completedView=makeView;
            break;
        case 15:
            self.abolishedButton=button;
            self.abolishedView=makeView;
            break;
            
        default:
            break;
    }
}
-(void)selectTitleWithIndex:(NSInteger)index{
    UIButton *titlButton;
    [self allButtonStateNormal];
    switch (index+10) {
        case 10:
            titlButton= self.allButton;
            [self StateSelectedWithButton:self.allButton withNormalView:self.allView];
            break;
        case 11:
            titlButton=self.MemberReviewButton;
              [self StateSelectedWithButton:self.MemberReviewButton withNormalView:self.MemberReviewView];
            break;
        case 12:
            titlButton=self.publicButton;
             [self StateSelectedWithButton:self.publicButton withNormalView:self.publicView];
            break;
        case 13:
            titlButton=self.executionButton;
            [self StateSelectedWithButton:self.executionButton withNormalView:self.executionView];
            break;
        case 14:
            titlButton=self.completedButton;
            [self StateSelectedWithButton:self.completedButton withNormalView:self.completedView];
            break;
        case 15:
            titlButton=self.abolishedButton;
             [self StateSelectedWithButton:self.abolishedButton withNormalView:self.abolishedView];
            break;
        default:
            break;
    }
    CGRect BTframe=titlButton.frame;
    CGFloat maxW =CGRectGetMaxX(BTframe);
    if (maxW>AppWidth) {
        [self.buttonScrollV setContentOffset:CGPointMake(maxW-AppWidth,0) animated:NO];
    }else{
        [self.buttonScrollV setContentOffset:CGPointMake( 0,0) animated:NO];
    }
}
@end
