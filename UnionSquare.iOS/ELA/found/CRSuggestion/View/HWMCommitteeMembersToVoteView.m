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


#import "HWMCommitteeMembersToVoteView.h"
#import "HWMCommitteeMembersToVoteTableViewCell.h"

static NSString *cellCommitteeMembersString=@"HWMCommitteeMembersToVoteTableViewCell";
UINib *CommitteeMembersNib;

@interface HWMCommitteeMembersToVoteView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *typeInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *showOrHiddenButton;
@property (weak, nonatomic) IBOutlet UIButton *InFavourButton;
@property (weak, nonatomic) IBOutlet UIButton *ObjectionButton;
@property (weak, nonatomic) IBOutlet UIButton *WaiverButton;
@property (weak, nonatomic) IBOutlet UIImageView *InFavourImageView;
@property (weak, nonatomic) IBOutlet UILabel *InFavourLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ObjectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *ObjectionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *WaiverImageView;
@property (weak, nonatomic) IBOutlet UILabel *WaiverLabel;
@property (weak, nonatomic) IBOutlet UITableView *baseTable;
@property (weak, nonatomic) IBOutlet UILabel *totalInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *noVioInfoLabel;

@end
@implementation HWMCommitteeMembersToVoteView
-(instancetype)init{
    self=[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMCommitteeMembersToVoteView" owner:nil options:nil].firstObject;
        self.typeInfoLabel.text=NSLocalizedString(@"委员投票", nil);
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow"] forState:UIControlStateNormal];
        self.noVioInfoLabel.text=NSLocalizedString(@"暂无投票", nil);
        [self makeView];
    }
    return self;
}
-(void)makeView{
    self.totalInfoLabel.alpha=0.f;
    self.baseTable.delegate=self;
    self.baseTable.dataSource=self;
    self.baseTable.rowHeight=44;
    self.baseTable.separatorInset=UIEdgeInsetsMake(-0, 15, 0, 15);
    self.baseTable.backgroundColor=[UIColor clearColor];
    CommitteeMembersNib=[UINib nibWithNibName:cellCommitteeMembersString bundle:nil];
    [self.baseTable registerNib:CommitteeMembersNib forCellReuseIdentifier:cellCommitteeMembersString];
    self.baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.baseTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self allStateNormal];
    [self updateCommitteeMembersToVoteInfo];
    [self updateToalInfo];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWMCommitteeMembersToVoteTableViewCell *cell=[CommitteeMembersNib instantiateWithOwner:nil options:nil].firstObject;
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (IBAction)showOrHiddenButtonEvent:(id)sender {
    self.showOrHiddenButton.selected=!self.showOrHiddenButton.selected;
    if (self.showOrHiddenButton.selected==NO) {
        self.totalInfoLabel.alpha=1.f;
        [self suViewShowOrHidden:0.f];
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow_fold"] forState:UIControlStateNormal];
        
        
    }else{
        self.totalInfoLabel.alpha=0.f;
        [self suViewShowOrHidden:1.f];
        [self.showOrHiddenButton setImage:[UIImage imageNamed:@"setting_list_arrow"] forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(CommitteeMembersToVoteISopenOrClose:)]) {
        [self.delegate CommitteeMembersToVoteISopenOrClose:self.showOrHiddenButton.selected];
    }
    
}
-(void)allStateNormal{
    [self StateNormalWithBGView:self.InFavourImageView withImageName:@"cr_aye_unselected" withTitleLabel:self.InFavourLabel];
    [self StateNormalWithBGView:self.ObjectionImageView withImageName:@"cr_nay_unselected" withTitleLabel:self.ObjectionLabel];
    [self StateNormalWithBGView:self.WaiverImageView withImageName:@"cr_defer_unselected" withTitleLabel:self.WaiverLabel];
}
-(void)StateNormalWithBGView:(UIImageView*)bgImageView withImageName:(NSString*)imageName withTitleLabel:(UILabel*)TLabel{
    bgImageView.image=[UIImage imageNamed:imageName];
    TLabel.font=[UIFont systemFontOfSize:11];
    TLabel.textColor=RGBA(255, 255, 255, 0.5);
}
-(void)StateSelectWithBGView:(UIImageView*)bgImageView withImageName:(NSString*)imageName withTitleLabel:(UILabel*)TLabel{
    bgImageView.image=[UIImage imageNamed:imageName];
    TLabel.font=[UIFont systemFontOfSize:12];
    TLabel.textColor=[UIColor whiteColor];
}
-(void)updateCommitteeMembersToVoteInfo{
    self.InFavourLabel.text=[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"赞成", nil),@"0"];
    self.ObjectionLabel.text=[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"反对", nil),@"0"];
    self.WaiverLabel.text=[NSString stringWithFormat:@"%@(%@)",NSLocalizedString(@"弃权", nil),@"0"];
}
-(void)updateToalInfo{
    
    self.totalInfoLabel.text=[NSString stringWithFormat:@"%@%@  %@%@  %@%@",NSLocalizedString(@"赞成", nil),@"0",NSLocalizedString(@"反对", nil),@"0",NSLocalizedString(@"弃权", nil),@"0"];
    
}
- (IBAction)ayeOrDeferOrnayEvent:(id)sender {
    
    [self StateNormalWithBGView:self.WaiverImageView withImageName:@"cr_nay_unselected" withTitleLabel:self.WaiverLabel];
    [self allStateNormal];
    UIButton *button=sender;
    switch (button.tag) {
        case 10:
            [self StateSelectWithBGView:self.InFavourImageView withImageName:@"cr_aye_selected" withTitleLabel:self.InFavourLabel];
            break;
        case 11:
            [self StateSelectWithBGView:self.ObjectionImageView withImageName:@"cr_nay_selected" withTitleLabel:self.ObjectionLabel];
            break;
        case 12:
            [self StateSelectWithBGView:self.WaiverImageView withImageName:@"cr_defer_selected" withTitleLabel:self.WaiverLabel];
            break;
        default:
            break;
    }
    
}
-(void)suViewShowOrHidden:(CGFloat)al{
    self.baseTable.alpha=al;
    self.InFavourImageView.alpha=al;
    self.InFavourLabel.alpha=al;
    self.InFavourButton.alpha=al;
    self.ObjectionImageView.alpha=al;
    self.ObjectionLabel.alpha=al;
    self.ObjectionButton.alpha=al;
    self.WaiverImageView.alpha=al;
    self.WaiverLabel.alpha=al;
    self.WaiverButton.alpha=al;
    
}
@end
