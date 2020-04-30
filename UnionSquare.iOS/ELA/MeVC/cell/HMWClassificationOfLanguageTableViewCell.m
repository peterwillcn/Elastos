//
//  HMWClassificationOfLanguageTableViewCell.m
//  ELA
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

  [DAConfig setUserLanguage:@"zh"];
  [DAConfig resetSystemLanguage];
    
}
- (IBAction)selectEnglish:(id)sender {

  [DAConfig setUserLanguage:@"en"];
  [DAConfig resetSystemLanguage];
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
    

    NSString *languageString=[DAConfig userLanguage];
    if ([languageString  containsString:@"en"]) {
        [self selectEnglishStatBG];
    }else if ([languageString  containsString:@"zh"]){
        
        [self selectChinssStatBG];
    }
    
}
@end
