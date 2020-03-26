//
//  AddressPickerView.m
//
//

#import "AddressPickerView.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface AddressPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

/** 选择器 */
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic,strong)NSMutableArray *provinceDatas;

@property (nonatomic,assign)NSInteger currentProvinceIndex;
@property (nonatomic,assign)NSInteger currentCityIndex;
@property (nonatomic,assign)NSInteger currentCountyIndex;

@end

@implementation AddressPickerView


-(instancetype)init{
   
    self =[super init];
    if (self) {
         self =[[NSBundle mainBundle]loadNibNamed:@"AddressPickerView" owner:nil options:nil].firstObject;
        self.currentProvinceIndex=0;
    }
    
    return self;
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;    
    self.provinceDatas = [NSMutableArray arrayWithObjects:@"2",@"3",@"4",@"5",@"6", nil];
}
//返回分区数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回cell个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
        return self.provinceDatas.count;
}

//返回cell
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    UILabel *pickerTextLb = (UILabel *)view;
    if (!pickerTextLb) {
        pickerTextLb = [[UILabel alloc]init];
        pickerTextLb.textColor = [UIColor whiteColor];
        pickerTextLb.adjustsFontSizeToFitWidth = YES;
        pickerTextLb.textAlignment = NSTextAlignmentCenter;
        pickerTextLb.font = [UIFont systemFontOfSize:22];
    }
    for (UIView *line in pickerView.subviews) {
        if (line.frame.size.height < 1) {//0.6667
            line.backgroundColor = [UIColor whiteColor];
            line.alpha=0.5;
            CGRect tempRect = line.frame;
            CGFloat lineW = pickerView.frame.size.width-60;
            line.frame = CGRectMake(30, tempRect.origin.y, lineW, 1);
        }
        
    }
    pickerTextLb.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerTextLb;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
        NSString *province = self.provinceDatas[row];
        return province;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 60;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.currentProvinceIndex=row;
}

- (IBAction)back {
   
}

- (IBAction)sureAction:(id)sender {
    if (self.delegate) {
        [self.delegate sureActionWithNumber:self.provinceDatas[self.currentProvinceIndex]];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.delegate) {
        [self.delegate closePickerView];
    }
}

@end
