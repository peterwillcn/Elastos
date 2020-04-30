//
//  HWMDIDAuthorizationTableViewCell.m
//  elastos wallet
//
//  Created by  on 2020/3/18.
//

#import "HWMDIDAuthorizationTableViewCell.h"


@interface HWMDIDAuthorizationTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *SelectedButton;

@end

@implementation HWMDIDAuthorizationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)SelectedEvent:(id)sender {
    self.SelectedButton.selected=!self.SelectedButton.selected;
    if (self.SelectedButton.selected) {
        self.dic[@"state"]=@"0";
    }else{
       self.dic[@"state"]=@"1";
    }
    [self updaButtonSyle];
    if (self.selectBlock) {
        self.selectBlock(self.dic);
    }
}

-(void)setDic:(NSMutableDictionary *)dic{
        _titleTextLabel.text=[NSString stringWithFormat:@"-%@",dic[@"text"]];
        NSString *imageS;
        if ( [dic[@"state"] isEqualToString:@"1"]) {
             imageS=@"authorization_selected";
        }else{
            imageS=@"authorization_empty";
        }
        [self.SelectedButton setImage:[UIImage imageNamed:imageS] forState:UIControlStateNormal];
           _dic=dic;
}
-(void)updaButtonSyle{
     NSString *imageS;
    
    if ( [self.dic[@"state"] isEqualToString:@"1"]) {
         imageS=@"authorization_selected";
    }else{
        imageS=@"authorization_empty";
    }
    [self.SelectedButton setImage:[UIImage imageNamed:imageS] forState:UIControlStateNormal];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
