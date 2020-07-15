//
//  HWMDIDDataListView.m
//  elastos wallet
//
//  Created by  on 2019/10/22.
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
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *genderArray;
@property (nonatomic, assign)NSInteger genderIndex;
@property (nonatomic, copy)NSString * selectMonthString;
@property (nonatomic, copy)NSString * selectDayString;
@end


@implementation HWMDIDDataListView

-(instancetype)init{
    self =[super init];
    if (self) {
        
        self =[[NSBundle mainBundle]loadNibNamed:@"HWMDIDDataListView" owner:nil options:nil].firstObject;
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tag=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ancelThePage)];
        [self addGestureRecognizer:tag];
        self.minDateStr=[NSDate date];
        self.dataPickerView.showsSelectionIndicator = YES;
        //设置UIPickerView的代理
        self.dataPickerView.delegate =self;
        self.dataPickerView.dataSource =self;
        self.makeSureTextLabel.text=NSLocalizedString(@"确认", nil);
    }
    return self;
}
-(NSArray *)genderArray{
    if (!_genderArray) {
        _genderArray =@[NSLocalizedString(@"男", nil),NSLocalizedString(@"女", nil)];
    }
    return _genderArray;
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
        if (self.ListViewType==DIDDataType) {
            //            if (self.yearIndex==5) {
            //                BOOL isSurrce=YES;
            //                if (self.monthIndex>(self.nowMonth-1)) {
            //                    isSurrce=NO;
            //
            //                }
            //                if(self.monthIndex==self.nowMonth-1&&self.dayIndex>(self.nowDay-1)) {
            //                    isSurrce=NO;
            //                }
            //                if (isSurrce==NO) {
            //                    //                    [[FLTools share]showErrorInfo:@"请选择失效日期"];
            //                    return;
            //                }
            //
            //            }
            //            if (self.yearIndex==0) {
            //                BOOL isSurrce=YES;
            //                if (self.monthIndex<(self.nowMonth-1)) {
            //                    isSurrce=NO;
            //
            //                }
            //                if(self.monthIndex==self.nowMonth-1&&self.dayIndex<self.nowDay) {
            //                    isSurrce=NO;
            //                }
            //                if (isSurrce==NO) {
            //                    //                    [[FLTools share]showErrorInfo:@"请选择失效日期"];
            //                    return;
            //                }
            //
            //            }
            [self.delegate selectDataWithYY:self.yearArray[self.yearIndex] withMM:self.monthArray[self.monthIndex] wihMMWithInt:self.monthIndex+1 wtihDD:self.dayArray[self.dayIndex]];
        }else if (self.ListViewType==genderType){
            
            [self.delegate selectGender:self.genderIndex];
        }else if (self.ListViewType==birthdayType){
         
            [self.delegate selectDataWithYY:self.yearArray[self.yearIndex] withMM:self.monthArray[self.monthIndex] wihMMWithInt:self.monthIndex+1 wtihDD:self.dayArray[self.dayIndex]];
        }
        [self.delegate cancelDataListView];
    }
}
- (NSMutableArray *)yearArray {
    
    if (_yearArray == nil) {
        _yearArray = [NSMutableArray array];
        if (self.ListViewType==birthdayType) {
            
            for (int year =(int)self.nowYear-100; year < (int)self.nowYear+1; year++) {
                
                NSString *str = [NSString stringWithFormat:@"%d", year];
                
                [_yearArray addObject:str];
            }
            
        }else{
            for (int year =(int)self.nowYear; year < (int)self.nowYear+6; year++) {
                
                NSString *str = [NSString stringWithFormat:@"%d", year];
                [_yearArray addObject:str];
            }
            
        }
        
        
    }
    
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    int starIndex=1;
    int endIndex=12;
    if (self.ListViewType==DIDDataType) {
        if (self.yearIndex==0) {
            starIndex= (int)self.nowMonth;
        }
        if (self.yearIndex==5) {
            endIndex=(int)self.nowMonth;
        }
        _monthArray =nil;
        if (_monthArray == nil) {
            _monthArray = [NSMutableArray array];
            for (starIndex; starIndex <= endIndex; starIndex++) {
                NSString *str = [NSString stringWithFormat:@"%02d", starIndex];
                
                [_monthArray addObject:str];
            }
        }
        
    }else{
        if (self.yearIndex==0) {
            starIndex= (int)self.nowMonth;
        }
        if (self.yearIndex==100) {
            endIndex=(int)self.nowMonth;
        }
        _monthArray =nil;
        if (_monthArray == nil) {
            _monthArray = [NSMutableArray array];
            for (starIndex; starIndex <= endIndex; starIndex++) {
                NSString *str = [NSString stringWithFormat:@"%02d", starIndex];
                
                [_monthArray addObject:str];
            }
        }
    }
    
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    int starIndex=1;
    
    
    int endIndex=(int)[[FLTools share]GetMonthDaysWithYear:self.yearArray[self.yearIndex] WithMonth:self.monthArray[self.monthIndex]];
    
    if (self.ListViewType==DIDDataType) {
        
        if (self.yearIndex==0&&self.monthIndex==0) {
            starIndex= (int)self.nowDay+1;
        }
        if (self.yearIndex==5&&self.monthIndex==self.nowMonth-1) {
            endIndex=(int)self.nowDay;
        }
        _dayArray =nil;
        if (_dayArray == nil) {
            
            _dayArray = [NSMutableArray array];
            for (starIndex; starIndex <= endIndex; starIndex++) {
                
                NSString *str = [NSString stringWithFormat:@"%02d", starIndex];
                
                [_dayArray addObject:str];
            }
            //            [self.dataPickerView reloadComponent:2];
        }
        
    }else{
        
        if (self.yearIndex==0&&self.monthIndex==0) {
            starIndex= (int)self.nowDay+1;
        }
        if (self.yearIndex==100&&self.monthIndex==self.nowMonth-1) {
            endIndex=(int)self.nowDay;
        }
        _dayArray =nil;
        if (_dayArray == nil) {
            
            _dayArray = [NSMutableArray array];
            for (starIndex; starIndex <= endIndex; starIndex++) {
                
                NSString *str = [NSString stringWithFormat:@"%02d", starIndex];
                
                [_dayArray addObject:str];
            }
            //            [self.dataPickerView reloadComponent:2];
        }
        
    }
    
    return _dayArray;
}
#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.ListViewType==genderType) {
        return 1;
    }
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (self.ListViewType==genderType) {
        return self.genderArray.count;
    }
    if (component == 0) {
        return self.yearArray.count;
        
    }else if(component == 1) {
        
        return self.monthArray.count;
        
    }else {
        return self.dayArray.count;
        
        //        switch (self.monthIndex + 1) {
        //
        //            case 1:
        //            case 3:
        //            case 5:
        //            case 7:
        //            case 8:
        //            case 10:
        //            case 12: return 31;
        //
        //            case 4:
        //            case 6:
        //            case 9:
        //            case 11: return 30;
        //
        //            default: return 28;
        //        }
    }
}
#pragma mark -UIPickerView的代理
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 60;
}
// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.ListViewType==genderType) {
        self.genderIndex=row;
        [self updatSelectIndexTextColorWithRow:row withcomponent:component];
        return;
    }
    if (component == 0) {
        self.yearIndex = row;
        [self updatSelectIndexTextColorWithRow:row withcomponent:component];
        [pickerView reloadComponent:1];
        if ([self.monthArray containsObject:self.selectMonthString]) {
            NSInteger mIndex=[self.monthArray indexOfObject:self.selectMonthString];
            self.monthIndex=mIndex;
        }else{
            self.monthIndex=self.monthArray.count-1;
        }
        [self.dataPickerView selectRow:self.monthIndex inComponent:1 animated:YES];
        [self pickerView:self.dataPickerView didSelectRow:self.monthIndex inComponent:1];
        
    }else if (component == 1) {
        self.monthIndex = row;
        self.selectMonthString=self.monthArray[self.monthIndex];
        if ([self.selectMonthString isEqualToString:@"05"] || [self.selectMonthString isEqualToString:@"07"] || [self.selectMonthString isEqualToString:@"10"]|| [self.selectMonthString isEqualToString:@"12"]) {
            
            if (self.dayIndex + 1 == 31) {
                
                self.dayIndex--;
            }
        }else if ([self.selectMonthString isEqualToString:@"02"]) {
            if (self.dayIndex + 1 > 28) {
                self.dayIndex = 27;
            }
        }
        [self updatSelectIndexTextColorWithRow:self.monthIndex withcomponent:1];
         [pickerView reloadComponent:2];
        if ([self.dayArray containsObject:self.selectDayString]) {
            self.dayIndex=[self.dayArray indexOfObject:self.selectDayString];
        }else{
            self.dayIndex=self.dayArray.count-1;
          
        }
        [self pickerView:self.dataPickerView didSelectRow:self.dayIndex inComponent:2];
        [self.dataPickerView selectRow:self.dayIndex inComponent:2 animated:YES];
        
        
        //
    }else {
        if (row>self.dayArray.count-1) {
            self.dayIndex=self.dayArray.count-1;
            [self.dataPickerView selectRow:self.dayIndex inComponent:2 animated:YES];
            [self pickerView:self.dataPickerView didSelectRow:self.dayIndex inComponent:2];
            return;
        }
        self.dayIndex = row;
        self.selectDayString=self.dayArray[self.dayIndex];
        [self updatSelectIndexTextColorWithRow:row withcomponent:component];
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
    if (self.ListViewType==genderType) {
        genderLabel.text = NSLocalizedString(self.genderArray[row], nil);
        return genderLabel;
    }
    if (component == 0) {
        genderLabel.text = self.yearArray[row];
        if (row==self.yearIndex) {
            genderLabel.textColor = [UIColor whiteColor];
            genderLabel.font = [UIFont systemFontOfSize:16];
        }
        
    }else if (component == 1) {
        NSString *textString=[NSString stringWithFormat:@"%@",self.monthArray[row]];
        genderLabel.text = NSLocalizedString(textString, nil);
        if (row==self.monthIndex) {
            genderLabel.textColor = [UIColor whiteColor];
            genderLabel.font = [UIFont systemFontOfSize:16];
        }
        
        
    }else {
        //        if (row>self.dayArray.count-1) {
        //            self.dayIndex=self.dayArray.count-1;
        //             [pickerView selectRow:self.dayIndex inComponent:2 animated:YES];
        //        }
        genderLabel.text = self.dayArray[row];
        if (row==self.dayIndex) {
            genderLabel.textColor = [UIColor whiteColor];
            genderLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    
    return genderLabel;
}
-(void)setListViewType:(HWMDIDDataListViewType)ListViewType{
    _ListViewType=ListViewType;
    NSString *stringType;
    if (ListViewType==DIDDataType) {
        stringType=NSLocalizedString(@"请选择失效日期",nil);
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
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
        [self.yearArray removeAllObjects];
        self.yearArray=nil;
        self.yearIndex =5;
        self.monthIndex =self.nowMonth-1;
        self.dayIndex =self.nowDay-1;
        self.selectMonthString=self.monthArray[self.monthIndex];
        self.selectDayString=self.dayArray[self.dayIndex];
        [self.dataPickerView selectRow:self.yearIndex inComponent:0 animated:YES];
        [self pickerView: self.dataPickerView didSelectRow:self.yearIndex inComponent:0];
    }else if (ListViewType==genderType){
        stringType=NSLocalizedString(@"请选择性别",nil);
        self.genderIndex=0;
        [self pickerView: self.dataPickerView didSelectRow:self.genderIndex inComponent:0];
        
    }else if (ListViewType==birthdayType){
        stringType=NSLocalizedString(@"请选择出生日期",nil);
        NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
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
        self.yearIndex =100;
        [self.yearArray removeAllObjects];
        self.yearArray=nil;
        self.monthIndex =self.nowMonth-1;
        self.dayIndex =self.nowDay-1;
        [ self.dataPickerView selectRow:self.yearIndex inComponent:0 animated:YES];
        [ self.dataPickerView selectRow:self.monthIndex inComponent:1 animated:YES];
        [ self.dataPickerView selectRow:self.dayIndex inComponent:2 animated:YES];
        [self pickerView: self.dataPickerView didSelectRow:self.yearIndex inComponent:0];
        [self pickerView: self.dataPickerView didSelectRow:self.monthIndex inComponent:1];
        [self pickerView: self.dataPickerView didSelectRow:self.dayIndex inComponent:2];
    }
    self.selectDataTextLabel.text=NSLocalizedString(stringType, nil);
}
-(void)updatSelectIndexTextColorWithRow:(NSInteger)row withcomponent:(NSInteger)component{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UILabel *label = (UILabel *)[self.dataPickerView viewForRow:row forComponent:component];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:16];
        
    });
    
}
@end
