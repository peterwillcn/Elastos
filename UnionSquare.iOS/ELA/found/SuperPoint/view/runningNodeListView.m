//
//  runningNodeListView.m
//  elastos wallet
//
//  Created by  on 2019/6/17.
//

#import "runningNodeListView.h"

@interface runningNodeListView ()
@property (weak, nonatomic) IBOutlet UILabel *runningNodeListTextLabel;

@end

@implementation runningNodeListView

-(instancetype)init{
    self =[super init];
    if (self) {
        self =[[NSBundle mainBundle]loadNibNamed:@"runningNodeListView" owner:nil options:nil].firstObject;
        
        self.runningNodeListTextLabel.text=NSLocalizedString(@"参选节点列表", nil);
        
    }
    
    return self;
    
    
}


@end
