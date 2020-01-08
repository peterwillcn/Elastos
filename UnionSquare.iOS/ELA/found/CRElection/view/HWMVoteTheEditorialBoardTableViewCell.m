//
//  HWMVoteTheEditorialBoardTableViewCell.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/9/3.
//

#import "HWMVoteTheEditorialBoardTableViewCell.h"


@interface HWMVoteTheEditorialBoardTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *isSelectedImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *AccountedLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalNumberVotesLabel;
@property (weak, nonatomic) IBOutlet UIView *BGView;
@property (copy, nonatomic)NSString *TfNumberString;
@end

@implementation HWMVoteTheEditorialBoardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[HMWCommView share]makeBordersWithView:self.BGView];
    [[HMWCommView share]makeTextFieldPlaceHoTextColorWithTextField:self.numberVotingTextField withTxt:NSLocalizedString(@"请输入票数", nil)];
    self.numberVotingTextField.delegate=self;
    [self.numberVotingTextField addTarget:self action:@selector(valuechanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//  found_vote_select
//    found_not_select
    // Configure the view for the selected state
}
-(void)setModel:(HWMCRListModel *)model{
    self.nickNameLabel.text =model.nickname;
    dispatch_group_t group =  dispatch_group_create();
     __block NSString *locationLabelString;
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       locationLabelString= [[FLTools share]contryNameTransLateByCode:[model.location intValue]];
     });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
          self.locationLabel.text= locationLabelString;
         
     });
         self.indexNumberLabel.text = [NSLocalizedString(@"当前排名：", nil) stringByAppendingString:model.index ];
         self.AccountedLabel.text = [NSString stringWithFormat:@"%@ %@ %@",NSLocalizedString(@"投票占比：", nil),model.voterate,@"%"];
         self.totalNumberVotesLabel.text=[NSString stringWithFormat:@"%@ %ld ",NSLocalizedString(@"得票总数：", nil),[model.votes longValue]];
    NSString *imageNameString=@"found_not_select";
    if (model.isCellSelected) {
         imageNameString=@"found_vote_select";
    }else{
         imageNameString=@"found_not_select";
    }
    self.isSelectedImageView.image =[UIImage imageNamed:imageNameString];
    
    if (model.SinceVotes.length>0&&![model.SinceVotes isEqualToString:@"0"]) {
        self.numberVotingTextField.text=model.SinceVotes;
    }else{
        self.numberVotingTextField.text=model.TextVotes;
    }
    _model=model;
}
-(void)setIndex:(NSIndexPath *)index{
    _index =index;
    
}
- (IBAction)addVote:(id)sender {
    self.model.isCellSelected=!self.model.isCellSelected;
    //  found_vote_select
    //    found_not_select
    NSString *imageNameString=@"found_not_select";
    if (self.model.isCellSelected) {
        
        imageNameString=@"found_vote_select";
    }else{
     
        imageNameString=@"found_not_select";
        
    }
    self.isSelectedImageView.image =[UIImage imageNamed:imageNameString];

    if (self.deleagte) {
         NSString *value;
        if (self.numberVotingTextField.text.length==0) {
                  value=@"0";
               }else{
                   value=self.numberVotingTextField.text;
               }
        [self.deleagte addVoteWithIndex:self.index withVotes:value];
    }
}
-(void)valuechanged:(UITextField*)tf{
//
//    NSString *nubber=self.numberVotingTextField.text;
//
//        [self textFieldDidEndEditing:self.numberVotingTextField];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([[[textField textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textField textInputMode] primaryLanguage]) {
        return NO;
    }
      NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSString *NumbersWithDot = @".1234567890";
//    NSString *NumbersWithoutDot = @"1234567890";
//
//    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
////    if (![string isEqualToString:@""]) {
//        NSCharacterSet *cs;
//            NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
//            if (dotLocation == NSNotFound ) {
//                cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithDot] invertedSet];
//                if (range.location >= 9) {
//                    if ([string isEqualToString:@"."] && range.location == 9) {
//                        return YES;
//                    }
//                    return NO;
//                }
//            }else {
//                cs = [[NSCharacterSet characterSetWithCharactersInString:NumbersWithoutDot] invertedSet];
//            }
//            // 按cs分离出数组,数组按@""分离出字符串
//            NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
//            BOOL basicTest = [string isEqualToString:filtered];
//            if (!basicTest) {
//                return NO;
//            }
//            if (dotLocation != NSNotFound && range.location > dotLocation + 8) {
//                return NO;
//            }
    NSString *stringRegex = @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,8})?)))?";//一般格式 d{0,8} 控制位数

              NSPredicate *money = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];

              BOOL flag = [money evaluateWithObject:toString];

              if (!flag) return NO;
    return YES;


}
-(BOOL)numbeChanged{

            NSCharacterSet *cs;
                NSInteger dotLocation = [self.numberVotingTextField.text rangeOfString:@"."].location;
                if (dotLocation == NSNotFound ) {
                    if (self.numberVotingTextField.text.length>9) {
                        return NO;
                    }
                  
                }else {
                     if (self.numberVotingTextField.text.length>19) {
                                          return NO;
                         
                     }
                }


        return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
        self.TfNumberString=textField.text;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self numbeChanged]) {
        if (self.deleagte) {
               [self.deleagte textFieldDidEnd:textField];
    }
    }else{
        self.numberVotingTextField.text=self.TfNumberString;
    }
   
    
}//第1种方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end
