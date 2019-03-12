//
//  HMWClassificationOfLanguageTableViewCell.m
//  ELA
//
//  Created by 韩铭文 on 2019/1/4.
//  Copyright © 2019 HMW. All rights reserved.
//

#import "HMWClassificationOfLanguageTableViewCell.h"
#import "DAConfig.h"


@interface HMWClassificationOfLanguageTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *ChineseButton;
@property (weak, nonatomic) IBOutlet UIButton *EnglishButton;

@end

@implementation HMWClassificationOfLanguageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[HMWCommView share]makeBordersWithView:self.ChineseButton];
        [[HMWCommView share]makeBordersWithView:self.EnglishButton];
    
  
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectChiness:(id)sender {
//    [self selectChinssStatBG];
  [DAConfig setUserLanguage:@"zh"];
}
- (IBAction)selectEnglish:(id)sender {
//    [self selectEnglishStatBG];
  [DAConfig setUserLanguage:@"en"];
}
-(void)selectChinssStatBG{
    
    [self.ChineseButton setBackgroundColor:RGBA(255, 255, 255, 0.2)];
    
    [self.EnglishButton setBackgroundColor:RGBA(0, 0, 0, 0.2)];
}
-(void)selectEnglishStatBG{
    
    self.ChineseButton.backgroundColor=RGBA(0, 0, 0, 0.2);
    self.EnglishButton.backgroundColor=RGBA(255, 255, 255, 0.2);
}
-(void)layoutSubviews{
    
    NSArray *dataArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"];
    NSString *languageString=dataArray.firstObject;
    if ([languageString  containsString:@"en"]) {
        [self selectEnglishStatBG];
    }else if ([languageString  containsString:@"zh"]){
        
        [self selectChinssStatBG];
    }
    
}
@end
