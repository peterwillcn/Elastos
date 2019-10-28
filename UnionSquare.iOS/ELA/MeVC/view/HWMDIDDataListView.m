//
//  HWMDIDDataListView.m
//  elastos wallet
//
//  Created by 韩铭文 on 2019/10/22.
//

#import "HWMDIDDataListView.h"

@interface HWMDIDDataListView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *selectDataTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *makeSureTextLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *dataPickerView;

/*
 *<# #>
 */
@property(strong,nonatomic)NSMutableArray *data;
/*
 *<# #>
 */
@property(strong,nonatomic)NSDate *minDateStr;
/*
 *
 */
@property(assign,nonatomic)NSInteger yearIndex;
/*
 *
 */
@property(assign,nonatomic)NSInteger monthIndex;
/*
 *
 */
@property(assign,nonatomic)NSInteger dayIndex;
@property (nonatomic, strong) NSMutableArray *yearArray;

@property (nonatomic, strong) NSMutableArray *monthArray;

@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, assign)NSInteger nowMonth;
@property (nonatomic,assign)NSInteger nowDay;
@property (nonatomic, assign)NSInteger nowYear;
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *ENMonthArray;

@end


@implementation HWMDIDDataListView

-(instancetype)init{
    self =[super init];
    if (self) {

        self =[[NSBundle mainBundle]loadNibNamed:@"HWMDIDDataListView" owner:nil options:nil].firstObject;
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ancelThePage)];
        [self addGestureRecognizer:tag];
        //设置地区: zh-中国
//           self.dataPickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
           
           //设置日期模式(Displays month, day, and year depending on the locale setting)
        self.minDateStr=[NSDate date];
        self.dataPickerView.showsSelectionIndicator = YES;
               //设置UIPickerView的代理
        self.dataPickerView.delegate =self;
        self.dataPickerView.dataSource =self;

       NSCalendar *calendar = [[NSCalendar alloc]
                                       initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
               // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
               unsigned unitFlags = NSCalendarUnitYear |
               NSCalendarUnitMonth |  NSCalendarUnitDay |
               NSCalendarUnitHour |  NSCalendarUnitMinute |
               NSCalendarUnitSecond | NSCalendarUnitWeekday;
               // 获取不同时间字段的信息
               NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
              self.nowYear=comp.year;
                  self.nowMonth=comp.month;
                  self.nowDay=comp.day;
        self.yearIndex =self.yearArray.count;
//        [self.yearArray indexOfObject:[NSString stringWithFormat:@"%ld年", comp.year]];
        self.monthIndex = [self.monthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", (long)comp.month]];
        self.dayIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%02ld日", (long)comp.day]];
    
               [ self.dataPickerView selectRow:self.yearIndex+5 inComponent:0 animated:YES];
               [ self.dataPickerView selectRow:self.monthIndex inComponent:1 animated:YES];
               [ self.dataPickerView selectRow:self.dayIndex inComponent:2 animated:YES];

               [self pickerView: self.dataPickerView didSelectRow:self.yearArray.count inComponent:0];
               [self pickerView: self.dataPickerView didSelectRow:self.monthIndex inComponent:1];
               [self pickerView: self.dataPickerView didSelectRow:self.dayIndex inComponent:2];
               
               dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                   UILabel *label = (UILabel *)[ self.dataPickerView viewForRow:self.yearIndex forComponent:0];
                   label.textColor = [UIColor whiteColor];
                   label.font = [UIFont systemFontOfSize:16];
//
                   label = (UILabel *)[self.dataPickerView viewForRow:self.monthIndex forComponent:1];
                   label.textColor = [UIColor whiteColor];
                   label.font = [UIFont systemFontOfSize:16];
                   label = (UILabel *)[self.dataPickerView viewForRow:self.dayIndex forComponent:2];
                        label.textColor = [UIColor whiteColor];
                  label.font = [UIFont systemFontOfSize:16];

                    });
    }
    return self;
}
-(NSArray *)ENMonthArray{
    if (!_ENMonthArray) {
        _ENMonthArray =@[@"Jan.",@"Feb.",@"Mar.",@"Apr.",@"May.",@"Jun.",@"Jul.",@"Aug.",@"Sept.",@"Oct.",@"Nov.",@"Dec."];
    }
    return _ENMonthArray;
}
-(void)ancelThePage{
    if (self.delegate) {
        [self.delegate cancelDataListView];
    }
    
    
}
- (IBAction)makeSureEvent:(id)sender {
    if (self.delegate) {
        
        [self.delegate selectDataWithYY:self.yearArray[ self.yearIndex] withMM:self.monthArray[self.monthIndex] wihMMWithInt:self.monthIndex+1 wtihDD:self.monthArray[self.dayIndex]];
    }
}
- (NSMutableArray *)yearArray {
    
    if (_yearArray == nil) {
        _yearArray = [NSMutableArray array];
        
        for (int year =self.nowYear; year < self.nowYear+5; year++) {
            
            NSString *str = [NSString stringWithFormat:@"%d年", year];
            
            [_yearArray addObject:str];
        }
    }
    
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    
    if (_monthArray == nil) {
        
        _monthArray = [NSMutableArray array];
         for (int month = 1; month <= 12; month++) {
                    
                    NSString *str = [NSString stringWithFormat:@"%02d月", month];
                    
                    [_monthArray addObject:str];
                }
            }
            
            return _monthArray;
        }

- (NSMutableArray *)dayArray {
            
            if (_dayArray == nil) {
                
                _dayArray = [NSMutableArray array];
                
                for (int day = 1; day <= 31; day++) {
                    
                    NSString *str = [NSString stringWithFormat:@"%02d日", day];
                    
                    [_dayArray addObject:str];
                }
            }
            
            return _dayArray;
}
#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearArray.count;
        
    }else if(component == 1) {
        
        return self.monthArray.count;
        
    }else {
        
        switch (self.monthIndex + 1) {
            
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: return 31;
                
            case 4:
            case 6:
            case 9:
            case 11: return 30;
                                
            default: return 28;
                        }
                    }
                }
#pragma mark -UIPickerView的代理
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 60;
}
// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        
        self.yearIndex = row;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:16];
            
        });
        
    }else if (component == 1) {
        
//        if (self.yearIndex==0||self.yearIndex==self.yearArray.count) {
//            if (row<self.self.monthIndex-1) {
//                [pickerView selectRow:self.monthIndex inComponent:1 animated:NO];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                         UILabel *label = (UILabel *)[pickerView viewForRow:1 forComponent:component];
//                         label.textColor = [UIColor whiteColor];
//                         label.font = [UIFont systemFontOfSize:16];
//
//                     });
//
//                           return;
//            }
//
//        }
    
        self.monthIndex = row;
        [pickerView reloadComponent:2];
        
       
        if (self.monthIndex + 1 == 4 || self.monthIndex + 1 == 6 || self.monthIndex + 1 == 9 || self.monthIndex + 1 == 11) {
            
            if (self.dayIndex + 1 == 31) {
                
                self.dayIndex--;
            }
        }else if (self.monthIndex + 1 == 2) {
             if (self.dayIndex + 1 > 28) {
                            self.dayIndex = 27;
                        }
                    }
                    [pickerView selectRow:self.dayIndex inComponent:2 animated:YES];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
                        label.textColor = [UIColor whiteColor];
                        label.font = [UIFont systemFontOfSize:16];
                        
                        label = (UILabel *)[pickerView viewForRow:self.dayIndex forComponent:2];
                        label.textColor = [UIColor whiteColor];
                        label.font = [UIFont systemFontOfSize:16];
                        
                    });
                }else {
                    
                       self.dayIndex = row;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
                        label.textColor = [UIColor whiteColor];
                        label.font = [UIFont systemFontOfSize:16];
                        
                    });
                }
            }
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
        //设置分割线的颜色
        for(UIView *singleLine in pickerView.subviews)
        {
            if (singleLine.frame.size.height < 1)
            {
                singleLine.backgroundColor =RGB(102, 102, 102);
                CGRect neWF=singleLine.frame;
                neWF.size.width=90;
            }
        }
    
    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = RGBA(255, 255, 255, 0.5);
    genderLabel.font = [UIFont systemFontOfSize:14];
    if (component == 0) {
        
        genderLabel.text = self.yearArray[row];
        
    }else if (component == 1) {
        NSString *textString=[NSString stringWithFormat:@"m%@",self.monthArray[row]];
        genderLabel.text = NSLocalizedString(textString, nil);
        
    }else {
        
        genderLabel.text = self.dayArray[row];
    }
    
    return genderLabel;
}

@end
