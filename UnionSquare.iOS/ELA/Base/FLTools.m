//
//  FLTools.m
//  FLWALLET
//
//  Created by  on 2018/4/19.
//  Copyright © 2018年 . All rights reserved.
//

#import "FLTools.h"
#import "DAConfig.h"
//#import "YYCache.h"
#import<SystemConfiguration/SCNetworkReachability.h>
@implementation FLFLUser

@end

@implementation FLWallet

@end

static FLTools *tool;

@interface FLTools ()
@property (nonatomic,strong)YYCache *cache;
@property (nonatomic,strong)NSMutableDictionary *QRCoreDic;
@end
@implementation FLTools

+(instancetype)share{
    if (!tool) {
      
        tool = [[self alloc]init];
    }
    return tool;
    
}
-(instancetype)init{
    self = [super init];
    return self;
}

-(void)setWalletList:(NSArray *)list{

//    NSMutableArray *b = [NSMutableArray array];
//    for (FLWallet *a in list) {
//        NSString* c = [a modelToJSONString];
//        NSLog(@"__+_+%@",a.walletName);
//
//        [b addObject:c];
//    }
//    [self.cache setObject:b forKey:FLFLWALLETLIST];
//    [self getWalletList];
}
-(void)clearlist{
//    [self.cache removeObjectForKey:FLFLWALLETLIST];
}
- (NSString *)getTimeFromTimesTamp:(NSString *)timeStr

{
    
    double time = [timeStr doubleValue];
    
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    //将时间转换为字符串
    
    NSString *timeS = [formatter stringFromDate:myDate];
    
    return timeS;
    
}
- (NSString *)CNTOYMDHMSgetTimeFromTimesTamp:(NSString *)timeStr{
    
    double time = [timeStr longLongValue];
    
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    
    //将时间转换为字符串
    
    NSString *timeS = [formatter stringFromDate:myDate];
    
    return timeS;
    
}
- (NSString *)YMDHMSgetTimeFromTimesTamp:(NSString *)timeStr

{
    double time = [timeStr longLongValue];
    
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSString *languageString=[DAConfig userLanguage];
    
    NSString *timeS;
if ([languageString  containsString:@"en"]) {
     
    NSInteger month = [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:myDate] month];
      [formatter setDateFormat:@"dd  HH:mm:ss YYYY"];
    NSString *monthString=[NSString stringWithFormat:@"m%ld",(long)month];
    timeS=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(monthString,nil),[formatter stringFromDate:myDate]];
  }else if ([languageString  containsString:@"zh"]){
        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
      timeS = [formatter stringFromDate:myDate];
    }
    
    return timeS;
    
}
- (NSString *)YMDCommunityTimeConversionTimeFromTimesTamp:(NSString *)timeStr

{
    
    double time = [timeStr longLongValue];
    
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"YYYY.MM.dd"];
    
    //将时间转换为字符串
    
    NSString *timeS = [formatter stringFromDate:myDate];
    
    return timeS;
    
}
- (NSString *)YMDCommunityTimeConversToAllFromTimesTamp:(NSString *)timeStr{
    double time = [timeStr longLongValue];
    
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSString *languageString=[DAConfig userLanguage];
    
 NSString *timeS;
 if ([languageString  containsString:@"en"]) {
       
      NSInteger month = [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:myDate] month];
        [formatter setDateFormat:@"dd  HH:mm:ss YYYY"];
      NSString *monthString=[NSString stringWithFormat:@"m%ld",(long)month];
            timeS=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(monthString,nil),[formatter stringFromDate:myDate]];
    }else if ([languageString  containsString:@"zh"]){
            [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
            timeS = [formatter stringFromDate:myDate];
      }
    return timeS;
}
-(NSString *)TimeFormatConversion:(NSString *)timeStr{
     double time = [timeStr longLongValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // 设置为UTC时区
    // 这里如果不设置为UTC时区，会把要转换的时间字符串定为当前时区的时间（东八区）转换为UTC时区的时间
//    NSTimeZone *timezone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
      NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
 
    NSString *languageString=[DAConfig userLanguage];
    
    
//    if ([languageString  containsString:@"en"]) {
//
//        [formatter setDateFormat:@"MM-dd-YYYY HH:mm:ss"];
//
//    }else if ([languageString  containsString:@"zh"]){
//
//        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
//
//    }
//    NSDate *someDay = [formatter dateFromString:timeStr];
//    NSString *timeS = [formatter stringFromDate:someDay];
//
//    return timeS;
    
    
    
    NSString *timeS;
    if ([languageString  containsString:@"en"]) {
          
         NSInteger month = [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:myDate] month];
           [formatter setDateFormat:@"dd  HH:mm:ss YYYY"];
         NSString *monthString=[NSString stringWithFormat:@"m%ld",(long)month];
               timeS=[NSString stringWithFormat:@"%@ %@",NSLocalizedString(monthString,nil),[formatter stringFromDate:myDate]];
       }else if ([languageString  containsString:@"zh"]){
               [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
               timeS = [formatter stringFromDate:myDate];
         }
    return timeS;
    
    
    
    
    
}
-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
//    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

-(void)showLoadingView{
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setForegroundColor:[UIColor grayColor]];
    [SVProgressHUD showWithStatus:@"loading"];
    
}
-(void)showErrorInfo:(NSString*)info{
    [SVProgressHUD setBackgroundColor:RGB(100, 100, 100)];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:info];
}
-(CGFloat)gasETHwithGasPrice:(NSString*)gasPrice withLimetPrice:(NSString*)LimetPrice{
      NSString *basePow=[NSString stringWithFormat:@"%.f",pow(10,9)];
    NSDecimalNumber *basePowDecimalNumber=[NSDecimalNumber       decimalNumberWithString:basePow];
    NSDecimalNumber *estimateGasDecimalNumber=[NSDecimalNumber       decimalNumberWithString:LimetPrice];
    NSDecimalNumber *gasPricDecimalNumber=[NSDecimalNumber       decimalNumberWithString:gasPrice];
    NSDecimalNumber *MultiplyingETH=[estimateGasDecimalNumber decimalNumberByMultiplyingBy:gasPricDecimalNumber];
    NSDecimalNumberHandler*roundUp = [NSDecimalNumberHandler
                                      
                                      decimalNumberHandlerWithRoundingMode: NSRoundDown
                                      
                                      scale:20.
                                      
                                      raiseOnExactness:NO
                                      
                                      raiseOnOverflow:NO
                                      
                                      raiseOnUnderflow:NO
                                      
                                      raiseOnDivideByZero:YES];
    NSDecimalNumber *last=[MultiplyingETH decimalNumberByDividingBy:basePowDecimalNumber withBehavior:roundUp];    
    return last.floatValue;
    
    
    
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)hasEmoji:(NSString*)string
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
-(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}

-(NSString *)notRounding:(NSString *)priceString afterPoint:(int)position{
    
   
    
    if (priceString.length==0) {
        return @"0";
    }
    NSDecimalNumber * roundedOunces=[[NSDecimalNumber alloc]initWithString:priceString];
    
    
    NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                       scale:position
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];



       NSDecimalNumber * roundedposition = [roundedOunces decimalNumberByRoundingAccordingToBehavior:roundDown];

    
    NSString *we = [NSString stringWithFormat:@"%f",roundedposition.doubleValue];
    NSRange range = [we rangeOfString:@"."];
    NSString * outNumber=[we substringWithRange:NSMakeRange(0, (range.location+position+1))];
    return outNumber;
    

    
}

-(BOOL)checkWhetherThePassword:(NSString*)passWord{
    if (passWord.length==0) {
        
          [self showErrorInfo:NSLocalizedString(@"密码不能为空", nil)];
        return YES;
    }
    if (passWord.length>7&&passWord.length<17) {
        
        NSInteger numberint=[self isStringContainTheLetterNumberSpecialCharactersWith:passWord];
        if (numberint>1) {
            return NO;
        }
        
    }
    
     [self showErrorInfo:NSLocalizedString(@"密码错误", nil)];
    return YES;
}


-(NSInteger)isStringContainTheLetterNumberSpecialCharactersWith:(NSString *)str{
    
    
    NSInteger number=0;
    NSRegularExpression *TheLetterRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger TheLettercount = [TheLetterRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    
    
    
    if (TheLettercount > 0) {
        
        number+=1;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]" options:0 error:nil];
        str = [regularExpression stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
        
    }
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numbercount = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    if (numbercount>0) {
        number+=1;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:nil];
        str = [regularExpression stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
    }
    
    
    if (str.length>0) {
        number+=1;
    }
    
    return number;
    
}
-(void)copiedToTheClipboardWithString:(NSString*)str{
    if (str.length==0) {
        return;
    }
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    
    pastboard.string = str;
    
    [self showErrorInfo:NSLocalizedString(@"复制成功", nil)];
}
-(NSString*)pastingTextFromTheClipboard{
    NSString *backString;
    UIPasteboard * pastboard = [UIPasteboard generalPasteboard];
    
    backString=pastboard.string;
    
    return backString;
}
-(BOOL)checkWalletName:(NSString*)walletName{
    if (walletName.length==0) {
          [self showErrorInfo:NSLocalizedString(@"钱包名称不能为空", nil)];
        
        return NO;
    }
    if (walletName.length>16) {
        [self showErrorInfo:NSLocalizedString(@"钱包名称非法", nil)];
        
        return NO;
    }
//    if (walletName.length>16||![self walltNameType:walletName]) {
//        [self showErrorInfo:NSLocalizedString(@"钱包名称非法", nil)];
//
//        return NO;
//    }
    
    
   
    
    
    
    return YES;
}
-(BOOL)walltNameType:(NSString*)str{
    NSInteger number=0;
    NSRegularExpression *TheLetterRegular = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSInteger TheLettercount = [TheLetterRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    
    
    
    if (TheLettercount > 0) {
        
        number+=1;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]" options:0 error:nil];
        str = [regularExpression stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
        
    }
    NSRegularExpression *numberRegular = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numbercount = [numberRegular numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    if (numbercount>0) {
        number+=1;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:0 error:nil];
        str = [regularExpression stringByReplacingMatchesInString:str options:0 range:NSMakeRange(0, str.length) withTemplate:@""];
    }
    
    
    if (str.length>0) {
        return NO;
    }
    return YES;
    
    
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
        options:NSJSONReadingMutableContainers
            error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(NSArray*)stringToArray:(NSString*)str{
   NSString *strUrl = [str stringByReplacingOccurrencesOfString:@"[" withString:@""];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"]" withString:@""];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    strUrl = [strUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strUrl.length==0) {
        return NULL;
    }
    NSArray  *array = [strUrl componentsSeparatedByString:@","];
    return array;
}
-(NSString *)getNowTimeTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
    
}
- (NSString *)getRandomStringWithNum:(NSInteger)num
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < num; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
-(NSString *)formattermnemonicWord:(NSString *)string

{
    
    NSString *tempStr=string;
    NSInteger size =(tempStr.length / 1);
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++){
        [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(n,1)]];
    }
//
//    [tmpStrArr addObject:[tempStr substringWithRange:NSMakeRange(size*1, (tempStr.length % 1))]];
    
    
    
    tempStr = [tmpStrArr componentsJoinedByString:@" "];
    
    
    
    return tempStr;
    
    
    
}
-(NSString*)elaScaleConversionWith:(NSString*)el{
    el=[NSString stringWithFormat:@"%@",el];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:el];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
     NSDecimalNumber *num2 = [num1 decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100000000"] withBehavior:roundDown];
    return num2.stringValue;
    
//    NSNumber * nsNumber = [num2.stringValue numberValue];
//    NSString * outNumber = [NSString stringWithFormat:@"%@",nsNumber];
//    return outNumber;
}
-(NSString*)CRVotingPercentageWithAllCount:(NSString*)allcount withCRMermVoting:(NSString*)MermVot{
//    SDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:priceStr];
//    NSDecimalNumber *countNum = [NSDecimalNumber decimalNumberWithString:stringWithNSInteger(NSIntegerMax)];
    @try {
        NSString *volatilePercentage;
             NSDecimalNumber *allcountD = [NSDecimalNumber decimalNumberWithString:allcount];
           NSDecimalNumber *MermVotD = [NSDecimalNumber decimalNumberWithString:MermVot];
             NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
           NSDecimalNumber *num2 = [MermVotD decimalNumberByDividingBy:allcountD withBehavior:roundDown];
           NSDecimalNumber *num3 = [num2 decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
           if (num3.doubleValue<1) {
               volatilePercentage=@"< 1";
           }else{
               volatilePercentage=num3.stringValue;
           }
           return volatilePercentage;
    } @catch (NSException *exception) {
        return @"--";
    } @finally {
       
    }
  
    
}
-(NSString*)CRVotingTheAverageDistribution:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout{
      NSDecimalNumber *blanceD = [NSDecimalNumber decimalNumberWithString:blance];
    NSDecimalNumber *MermVotCoutD = [NSDecimalNumber decimalNumberWithString:MermVotCout];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSDecimalNumber *num2 = [blanceD decimalNumberByDividingBy:MermVotCoutD withBehavior:roundDown];

        NSDecimalNumber * result = [NSDecimalNumber decimalNumberWithString:num2.stringValue];
    if (result.doubleValue==0) {
        return @"0";
    }

return  result.stringValue;
    
}
-(NSString*)DownTheValue:(NSString*)blance withLength:(NSInteger)MermVotCout{
 NSString*volatilePercentage;
    NSDecimalNumber *blanceD = [NSDecimalNumber decimalNumberWithString:blance];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:MermVotCout raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        blanceD=[blanceD decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
        NSDecimalNumber * result= [blanceD decimalNumberByRoundingAccordingToBehavior:roundDown];
  if (result.doubleValue<1) {
        volatilePercentage=@"< 1";
  }else{
      volatilePercentage=result.stringValue;
  }

return  volatilePercentage;
    
}
-(NSString*)DownAlllTheValuePercentage:(NSString*)blance withLength:(NSInteger)MermVotCout{

    NSDecimalNumber *blanceD = [NSDecimalNumber decimalNumberWithString:blance];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:MermVotCout raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
        blanceD=[blanceD decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
        NSDecimalNumber * result= [blanceD decimalNumberByRoundingAccordingToBehavior:roundDown];


return  result.stringValue;
    
}
-(NSString*)DownNumberPercentage:(NSString*)blance withLength:(NSInteger)MermVotCout{

    NSDecimalNumber *blanceD = [NSDecimalNumber decimalNumberWithString:blance];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:MermVotCout raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
      
        NSDecimalNumber * result= [blanceD decimalNumberByRoundingAccordingToBehavior:roundDown];


return  result.stringValue;
    
}

-(NSString*)CRVotingDecimalNumberBySubtracting:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout{
    if (MermVotCout.length==0) {
        MermVotCout=@"0";
    }
      NSDecimalNumber *blanceD = [NSDecimalNumber decimalNumberWithString:blance];
    NSDecimalNumber *MermVotCoutD = [NSDecimalNumber decimalNumberWithString:MermVotCout];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSDecimalNumber *num2 = [blanceD decimalNumberBySubtracting:MermVotCoutD withBehavior:roundDown];

        NSDecimalNumber * result = [NSDecimalNumber decimalNumberWithString:num2.stringValue];
    if (result.doubleValue==0) {
        return @"0";
    }

return  result.stringValue;
    
}
-(NSString*)CRVotingDecimalNumberByAdding:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout{
      NSDecimalNumber *blanceD = [NSDecimalNumber decimalNumberWithString:blance];
    NSDecimalNumber *MermVotCoutD = [NSDecimalNumber decimalNumberWithString:MermVotCout];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSDecimalNumber *num2 = [blanceD decimalNumberByAdding:MermVotCoutD withBehavior:roundDown];

        NSDecimalNumber * result = [NSDecimalNumber decimalNumberWithString:num2.stringValue];
    if (result.doubleValue==0) {
        return @"0";
    }

return  result.stringValue;
    
}
-(NSString*)CRVotingDecimalNumberByMultiplying:(NSString*)blance withCRMermVoting:(NSString*)MermVotCout{
      NSDecimalNumber *blanceD = [NSDecimalNumber decimalNumberWithString:blance];
    NSDecimalNumber *MermVotCoutD = [NSDecimalNumber decimalNumberWithString:MermVotCout];
      NSDecimalNumberHandler *roundDown = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    NSDecimalNumber *num2 = [blanceD decimalNumberByMultiplyingBy:MermVotCoutD withBehavior:roundDown];

        NSDecimalNumber * result = [NSDecimalNumber decimalNumberWithString:num2.stringValue];
    if (result.doubleValue==0) {
        return @"0";
    }

return  result.stringValue;
    
}
-(NSString *)elsToSela:(NSString*)ela{
    ela=[NSString stringWithFormat:@"%@",ela];
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:ela];
    NSString *uNmuber=[NSString stringWithFormat:@"%d",unitNumber];
      NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:uNmuber];
    NSDecimalNumber *num = [num1 decimalNumberByMultiplyingBy:num2];

    return num.stringValue;
}
-(NSString *)contryNameTransLateByCode:(NSInteger)code{
    NSString *codeString=[NSString stringWithFormat:@"%ld",(long)code];
   
  NSString *str1 = [codeString substringToIndex:1];//截取掉下标5之前的字符串
    if ([str1 isEqualToString:@"00"]) {
        code =[[codeString substringFromIndex:2] integerValue];
    }
    codeString=[NSString stringWithFormat:@"%ld",code];
    NSDictionary *contryName=@{
                @"阿富汗":@"93",
                @"阿尔巴尼亚":@"355",
                @"阿尔及利亚":@"213",
                @"萨摩亚":@"684",
                @"安道尔共和国":@"376",
                @"安哥拉":@"244",
                @"安圭拉岛":@"1264",
                @"安提瓜和巴布达":@"1268",
                @"阿根廷":@"54",
                @"亚美尼亚":@"374",
                @"阿鲁巴":@"297",
                @"澳大利亚":@"61",
                @"奥地利":@"43",
                @"阿塞拜疆":@"994",
                @"巴哈马":@"1242",
                @"巴林":@"973",
                @"孟加拉国":@"880",
                @"巴巴多斯":@"1246",
                @"白俄罗斯":@"375",
                @"比利时":@"32",
                @"伯利兹城":@"501",
                @"贝宁":@"229",
                @"百慕大":@"1441",
                @"不丹":@"975",
                @"玻利维亚":@"591",
                @"波斯尼亚和黑塞哥维那":@"387",
                @"博茨瓦纳":@"267",
                @"巴西":@"55",
                @"英属印度洋领地":@"246",
                @"文莱达鲁萨兰国":@"673",
                @"保加利亚":@"359",
                @"布基纳法索":@"226",
                @"布隆迪":@"257",
                @"泽西岛":@"1044",
                @"柬埔寨":@"855",
                @"喀麦隆":@"237",
                @"加拿大":@"1",
                @"佛得角":@"238",
                @"开曼群岛":@"1345",
                @"中非共和国":@"236",
                @"乍得":@"235",
                @"智利":@"56",
                @"中国":@"86",
                @"圣延岛":@"6724",
                @"科科斯群岛":@"61891",
                @"哥伦比亚":@"57",
                @"科摩罗":@"269",
                @"刚果":@"242",
                @"库克群岛":@"682",
                @"哥斯达黎加":@"506",
                @"Cote D'Ivoire":@"225",
                @"克罗地亚":@"385",
                @"古巴":@"53",
                @"塞浦路斯":@"357",
                @"捷克":@"420",
                @"丹麦":@"45",
                @"吉布提":@"253",
                @"多米尼克国":@"1767",
                //                @"多米尼加共和国":@"1849",
                @"东帝汶":@"670",
                @"厄瓜多尔":@"593",
                @"埃及":@"20",
                @"萨尔瓦多":@"503",
                @"赤道几内亚":@"240",
                @"厄立特里亚国":@"291",
                @"爱沙尼亚":@"372",
                @"埃塞俄比亚":@"251",
                @"法罗群岛":@"298",
                @"斐济":@"679",
                @"芬兰":@"358",
                @"法国":@"33",
                //          @"法国大都会":@"33",
                @"法属圭亚那":@"594",
                @"法属玻里尼西亚":@"689",
                @"加蓬":@"241",
                @"冈比亚":@"220",
                @"格鲁吉亚":@"995",
                @"德国":@"49",
                @"加纳":@"233",
                @"直布罗陀":@"350",
                @"希腊":@"30",
                @"格陵兰":@"10045",
                @"格林纳达":@"1473",
                @"瓜德罗普岛":@"590",
                @"关岛":@"1671",
                @"危地马拉":@"502",
                @"几内亚":@"224",
                @"几内亚比绍":@"245",
                @"圭亚那":@"592",
                @"海地":@"509",
                @"洪都拉斯":@"504",
                @"香港":@"852",
                @"匈牙利":@"36",
                @"冰岛":@"354",
                @"印度":@"91",
                @"印度尼西亚":@"62",
                @"伊朗（伊斯兰共和国)":@"98",
                @"伊拉克":@"964",
                @"爱尔兰":@"353",
                @"以色列":@"972",
                @"意大利":@"39",
                @"牙买加":@"1876",
                @"日本":@"81",
                @"约旦":@"962",
                @"哈萨克":@"7",
                @"肯尼亚":@"254",
                @"科威特":@"965",
                @"吉尔吉斯":@"996",
                @"拉脱维亚":@"371",
                @"黎巴嫩":@"961",
                @"莱索托":@"266",
                @"利比里亚":@"231",
                @"利比亚":@"218",
                @"列支敦士登":@"423",
                @"立陶宛":@"370",
                @"卢森堡":@"352",
                @"老挝":@"856",
                @"澳门地区":@"853",
                @"马达加斯加":@"261",
                @"马拉维":@"265",
                @"马来西亚":@"60",
                @"马尔代夫":@"960",
                @"马里":@"223",
                @"马尔他":@"356",
                @"马提尼克岛":@"596",
                @"毛里塔尼亚":@"222",
                @"毛里求斯":@"230",
                @"马约特":@"262",
                @"墨西哥":@"52",
                @"密克罗尼西亚":@"691",
                @"摩尔多瓦":@"373",
                @"摩纳哥":@"377",
                @"外蒙古":@"976",
                @"黑山共和国":@"382",
                @"蒙特塞拉特":@"1664",
                @"摩洛哥":@"212",
                @"莫桑比克":@"258",
                @"缅甸":@"95",
                @"那米比亚":@"264",
                @"瑙鲁":@"674",
                @"尼泊尔":@"977",
                @"荷兰":@"31",
                @"荷兰安的列斯群岛":@"599",
                @"新喀里多尼亚":@"687",
                @"新西兰":@"64",
                @"尼加拉瓜":@"505",
                @"尼日尔":@"227",
                @"尼日利亚":@"234",
                @"诺福克岛":@"6723",
                @"朝鲜":@"850",
                @"北马里亚纳群岛":@"1670",
                @"挪威":@"47",
                @"阿曼":@"968",
                @"巴基斯坦":@"92",
                @"帛琉":@"680",
                @"巴勒斯坦":@"970",
                @"巴拿马":@"507",
                @"巴布亚新几内亚":@"675",
                @"巴拉圭":@"595",
                @"秘鲁":@"51",
                @"菲律宾共和国":@"63",
                @"皮特凯恩岛":@"10064",
                @"波兰":@"48",
                @"葡萄牙":@"351",
                @"波多黎各":@"1787",
                @"卡塔尔":@"974",
                @"留尼汪岛":@"262",
                @"罗马尼亚":@"40",
                @"俄罗斯联邦":@"1007",
                @"卢旺达":@"250",
                @"美属萨摩亚":@"10684",
                @"圣马力诺共和国":@"378",
                @"沙特阿拉伯":@"966",
                @"塞内加尔":@"221",
                @"塞尔维亚共和国":@"381",
                @"塞舌尔":@"248",
                @"塞拉利昂":@"232",
                @"新加坡":@"65",
                @"斯洛伐克（斯洛伐克人的共和国）":@"421",
                @"斯洛文尼亚":@"386",
                @"索罗门群岛":@"677",
                @"索马里":@"252",
                @"南非":@"27",
                @"韩国":@"82",
                @"西班牙":@"34",
                @"斯里兰卡":@"94",
                @"苏丹":@"249",
                @"苏里南":@"597",
                @"斯威士兰":@"268",
                @"瑞典":@"46",
                @"瑞士":@"41",
                @"叙利亚":@"963",
                @"圣文森特和格林纳丁斯":@"1784",
                @"圣多美和普林西比":@"239",
                @"台湾地区":@"886",
                @"塔吉克":@"992",
                @"坦桑尼亚":@"255",
                @"泰国":@"66",
                @"多哥":@"228",
                @"托克劳":@"690",
                @"汤加":@"676",
                @"特立尼达和多巴哥":@"1868",
                @"突尼斯":@"216",
                @"土耳其":@"90",
                @"土库曼":@"993",
                @"土克斯及开科斯群岛":@"1809",
                @"图瓦卢":@"688",
                @"阿布哈兹":@"2007",
                @"南奥赛梯":@"3007",
                @"马其顿":@"389",
                @"圣基茨和尼维斯":@"1869",
                @"南苏丹共和国":@"211",
                @"刚果民主共和国":@"243",
                @"乌干达":@"256",
                @"乌克兰":@"380",
                @"阿拉伯联合酋长国":@"971",
                @"英国":@"44",
                @"美国":@"1001",
                @"乌拉圭":@"598",
                @"乌兹别克斯坦":@"998",
                @"瓦努阿图":@"678",
                @"梵蒂冈(罗马教廷)":@"10039",
                @"委内瑞拉":@"58",
                @"越南":@"84",
                //                @"维尔京群岛(英国)":@"01284",
                @"沃利斯和富图纳群岛":@"681",
                @"西撒哈拉":@"685",
                @"也门":@"967",
                @"南斯拉夫":@"338",
                @"赞比亚":@"260",
                @"津巴布韦":@"263",
    };
    
    NSArray *contryArray =[contryName allKeysForObject:codeString];
    NSString *contryString;
    if (contryArray.count>0) {
        contryString=NSLocalizedString(contryArray.firstObject, nil);
    }else{
        contryString=NSLocalizedString(@"未知", nil);
        
    }
 


    
  
    return contryString;

}
-(BOOL)changeisEnglish:(NSString*)m{
    
    NSString *checkString = m;
    // 1.创建正则表达式，[0-9]:表示‘0’到‘9’的字符的集合
    NSString *pattern = @"[a-zA-Z]";
    // 1.1将正则表达式设置为OC规则
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 2.利用规则测试字符串获取匹配结果
    NSArray *results = [regular matchesInString:checkString options:0 range:NSMakeRange(0, checkString.length)];
    if (results.count>0) {
        return YES;
    }
    return NO;
    
    
}
-(NSDictionary *)getImageViewURLWithURL:(NSString*)urlString withCRString:(NSString*)CRS{
    NSString *urlLaString=[urlString substringFromIndex:[urlString length]-1];
    NSString *jsonType;
    if (CRS.length==0) {
        jsonType=@"bpinfo.json";
    }else{
        jsonType=@"crinfo.json";
    }
    if ([urlLaString isEqualToString:@"/"] ) {
        urlString= [NSString stringWithFormat:@"%@%@",jsonType,urlString];
    }else{
        urlString= [NSString stringWithFormat:@"%@/%@",jsonType,urlString];
    }
    NSURL *url=  [NSURL URLWithString:urlString];
    NSData *data=[NSData dataWithContentsOfURL:url];
    if (data==nil) {
        return @{};
    }
    NSError *error;
    id jsonClass = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSDictionary*
        infoDic=jsonClass[@"org"][@"candidate_info"];
    return @{@"url":[NSString stringWithFormat:@"%@",jsonClass[@"org"][@"branding"][@"logo_256"]],
             @"infoEN":infoDic[@"en"],@"infoZH":infoDic[@"zh"]
             
    };
}
-(NSDictionary*)CreateQrCodeImage:(NSString*)contentString WithType:(NSString*)type withSubWalletIdChain:(NSString *)subW{
    if (subW.length==0) {
        subW=@"ELA";
    }
    NSDictionary *extraDic=@{@"Type":[NSString stringWithFormat:@"%@",type],
                             @"SubWallet":subW};
    NSDictionary *dic=@{@"version":@(0),
                        @"name":@"MultiQrContent",
                        @"total":@(1),
                        @"index":@(1),
                        @"data":contentString,
                        @"md5":@"",
                        @"extra":extraDic
                        };
    return dic;

}
-(NSArray*)CreateArrayQrCodeImage:(NSString*)contentString WithType:(NSString*)type withSubWall:(NSString*)subW{
    if (subW.length==0) {
        subW=@"ELA";
    }
//    NSString * contentString=[self DicToString:contentDic];
        NSMutableArray *allQRCodeArray=[[NSMutableArray alloc]init];
    CGFloat maxChar=300.0;
       int max =ceil(contentString.length/maxChar);
        int min=floor(contentString.length/maxChar);
    NSLog(@"二维码max==%d min===%d",max,min);
        for (NSInteger i=0; i<max; i++) {
            NSString *dataString;
            if ((i==min && max>min) ) {
                dataString=[contentString substringWithRange:NSMakeRange(i*maxChar, contentString.length-i*maxChar)];
    
            }else{
                dataString=[contentString substringWithRange:NSMakeRange(i*maxChar,maxChar)];
    
            }
    NSDictionary *dic=@{@"version":@(0),
                        @"name":@"MultiQrContent",
                        @"total":@(max),
                        @"index":@(i+1),
                        @"data":dataString,
                        @"md5":@"",
                        @"extra":@{@"Type":type,
                        @"SubWallet":subW}
                        };
            NSString *QRCodeString=[self returnJSONStringWithDictionary:dic];
            [allQRCodeArray addObject:QRCodeString];
            NSLog(@"二维码 dic==%@",dic);
    
        }
        return allQRCodeArray;
    
}
-(NSString*)DicToString:(NSDictionary*)dic{
    NSError*  errn;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:& errn];
    if (errn) {
        
        
        NSLog(@"e:%@",errn);
        
        
    }
    NSString * contentString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return contentString;
    
}
- (UIImage*)imageWithSize:(CGFloat)size andColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andQRDic:(NSDictionary *)qrDic{

    UIImage *resultImage=
    [self createInterPolatedUIImage:[self createQRFromNSDic:qrDic] withSize:size];

    return [self imageBlackToTransParent:resultImage withRed:red andGreen:green andBlur:blue];
}
- (UIImage*)imageWithSize:(CGFloat)size andColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andQRString:(NSString*)qrString{
//    NSDictionary *qrDic=[self dictionaryWithJsonString:qrString];
    UIImage *resultImage=
    [self createInterPolatedUIImage:[self createQRFromDICToString:qrString] withSize:size];
    
    return [self imageBlackToTransParent:resultImage withRed:red andGreen:green andBlur:blue];
    
}
//MARK:实现方法
- (UIImage *)createInterPolatedUIImage:(CIImage *)ciimage withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(ciimage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent),size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef  = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciimage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(cs);
    UIImage *img = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return img;
}
- (CIImage *)createQRFromDICToString:(NSString*)dicSring {
//  NSString * QRSring=[self returnJSONStringWithDictionary:dicSring];

  NSData *stringData = [dicSring dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // set内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    return qrFilter.outputImage;
}

- (CIImage *)createQRFromNSDic:(NSDictionary*)qrSring {

    NSError*parseError =nil;
//   NSString * QRSring=[self DeleteTheBlankSpace:[self DicToString:qrSring]];
    
    NSData*stringData =[NSJSONSerialization dataWithJSONObject:qrSring options:NSJSONWritingPrettyPrinted error:&parseError];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // set内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    return qrFilter.outputImage;
}
- (UIImage *)imageBlackToTransParent:(UIImage *)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlur:(CGFloat)blue {
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)    // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProViderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}
void ProViderReleaseData (void *info,const void *data,size_t size) {
    free((void *)data);
}
-(NSDictionary*)QrCodeImageFromDic:(NSString*)QrCodeString fromVC:(UIViewController*)VC oldQrCodeDic:(NSDictionary*)oldDic{
    NSDictionary *dic =[self dictionaryWithJsonString:QrCodeString];
    self.QRCoreDic=[NSMutableDictionary dictionaryWithDictionary:oldDic];
    if ([self ToDetectWhetherTheSame:dic withFromeVC:VC]) {
        return nil;
    }else{
        [self QRCoreDicAddData:dic withVC:VC];
    }
    return self.QRCoreDic;
    
}
-(NSMutableDictionary *)QRCoreDic{
    if (!_QRCoreDic) {
        _QRCoreDic =[[NSMutableDictionary alloc]init];
    }
    return _QRCoreDic;
}
-(BOOL)ToDetectWhetherTheSame:(NSDictionary*)dic withFromeVC:(UIViewController*)vc{
 
    if (![self.QRCoreDic[@"extra"] isEqualToValue:dic[@"extra"]]) {
        return NO;
    }
    if ([self.QRCoreDic[@"total"] integerValue]!=[dic[@"total"] integerValue]) {
        return NO;
    }
    NSInteger index=[self.QRCoreDic[@"index"] integerValue]+1;
    if (index!=[dic[@"index"] integerValue]) {
        return NO;
    }
   
    
    [self QRCoreDicAddData:dic[@"data"] withVC:vc];
    
    return YES;
}
-(void)QRCoreDicAddData:(NSDictionary*)dic withVC:(UIViewController*)VC{
    
    [self.QRCoreDic setObject:dic[@"total"] forKey:@"total"];
    [self.QRCoreDic setObject:[NSString stringWithFormat:@"%@",[VC class]] forKey:@"VC"];
     [self.QRCoreDic setObject:dic[@"total"] forKey:@"total"];
    [self.QRCoreDic setObject:dic[@"index"] forKey:@"index"];
     [self.QRCoreDic setObject:dic[@"md5"] forKey:@"md5"];
     [self.QRCoreDic setObject:dic[@"extra"] forKey:@"extra"];
    NSString *dataString=self.QRCoreDic[@"data"];
    if (dataString.length==0) {
         [self.QRCoreDic setObject:dic[@"data"] forKey:@"data"];
    }else{
        [self.QRCoreDic setObject:[NSString stringWithFormat:@"%@%@",dataString,dic[@"data"]] forKey:@"data"];
    }
}
-(BOOL)SCanQRCodeWithDicCode:(NSDictionary*)dic{
    
    if (dic) {
        if ([dic[@"total"] integerValue]==[dic[@"index"] integerValue]) {
            return YES;
        }
    }
    return NO;
    
}
-(NSString*)http_IpFast{
    
//    #ifdef DEBUG
//    return Http_IP;
//    #elif PrvNet
//     return Http_IP;
//     #elif TestNet
//    return Http_IP;
//    #else
   //   @"RegTest",@"PrvNet",@"TestNet",@"MainNet"
        if ([SDKNET isEqualToString:@"RegTest"] ) {
             return Http_IP;
        }else if ([SDKNET isEqualToString:@"PrvNet"] ){
             return Http_IP;
        }else if ([SDKNET isEqualToString:@"TestNet"] ){
             return Http_IP;
        }else if ([SDKNET isEqualToString:@"MainNet"] ){
            NSString *http_ip =[STANDARD_USER_DEFAULT valueForKey:@"Http_IP"];
               if (http_ip.length>0) {
                   return http_ip;
               }
        }
        return  Http_IP;
//   #endif

}
-(NSString *)http_ipString:(NSString *)sdknet{

    if ([sdknet isEqualToString:@"RegTest"] ) {
           return @"http://54.223.244.60";
           }else if ([sdknet isEqualToString:@"PrvNet"] ){
               return @"http://172.26.0.207:3000";
              
           }else if ([sdknet isEqualToString:@"TestNet"] ){
               return @"http://54.223.244.60";
              
           }else if ([sdknet isEqualToString:@"MainNet"]){
               return @"http://54.223.158.189:5739/";
           }
     return @"http://54.223.158.189:5739/";
}
-(NSString*)http_transUrl:(NSString*)sdknet{
    if ([sdknet isEqualToString:@"RegTest"] ) {
             return  @"https://blockchain-beta.elastos.org/tx/";
             }else if ([sdknet isEqualToString:@"PrvNet"] ){
                 return  @"http://172.26.0.207:3000";
                
             }else if ([sdknet isEqualToString:@"TestNet"] ){
                 return  @"https://blockchain-beta.elastos.org/tx/";
                
             }else if ([sdknet isEqualToString:@"MainNet"]){
                 return @"https://blockchain.elastos.org/tx/";
             }
       return @"https://blockchain.elastos.org/tx/";
    
}
-(NSString*)http_PongUrl:(NSString*)sdknet{
    return @"http://54.223.158.189:5739/";
}

-(NSArray*)theInterceptionHttpWithArray:(NSArray*)array{
    
    NSMutableArray *IPArray=[[NSMutableArray alloc]init];
    NSString *httpsString=@"://";
   
    for (NSString *https_IP in array) {
       NSArray  *array = [https_IP componentsSeparatedByString:httpsString];
        [IPArray addObject:array.lastObject];
    }
    return IPArray;
    
}
-(NSString*)DeleteTheBlankSpace:(NSString*)needString{
    
       needString = [needString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除首位空格
    
       needString = [needString stringByReplacingOccurrencesOfString:@" "withString:@""];  //去除中间空格
    
        needString = [needString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return needString;
}
-(NSString *)returnJSONStringWithDictionary:(NSDictionary *)dictionary{

        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString;
        if (!jsonData) {
            NSLog(@"%@",error);
        }else{
            jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
        NSRange range = {0,jsonString.length};
        //去掉字符串中的空格
        [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
        NSRange range2 = {0,mutStr.length};
        //去掉字符串中的换行符
        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        return mutStr;
}
-(NSString*)WhetherTheCurrentTypeWithDataString:(NSString*)dataString withType:(NSString*)type{
    NSString*data;
    NSDictionary *dic=[self dictionaryWithJsonString:dataString];
    if (dic) {
        if([[dic allKeys] containsObject:@"extra"]){
            NSDictionary *extraDic=dic[@"extra"];
            if ([[extraDic allKeys] containsObject:@"Type"]) {
                if ([[NSString stringWithFormat:@"%@",extraDic[@"Type"]] isEqualToString:type]) {
                    
                    if ([type isEqualToString:@"1"]) {
                        
                        data=[self DicToString:dic[@"data"]];
                    }else if([type isEqualToString:@"2"]){
                        
                        data=dic[@"data"];
                    }
                   
                }
            }
        }
    }
    return data;
}
-(BOOL)WhetherTheCurrentTypeNeedType:(NSString*)dataString withType:(NSString*)type{

    NSDictionary *dic=[self dictionaryWithJsonString:dataString];
    if (dic) {
        if([[dic allKeys] containsObject:@"extra"]){
            NSDictionary *extraDic=dic[@"extra"];
            if ([[extraDic allKeys] containsObject:@"Type"]) {
                if ([[NSString stringWithFormat:@"%@",extraDic[@"Type"]] isEqualToString:type]) {
                    return YES;
                }
            }
        }
    }
    return NO;
}
-(BOOL)connectedToNetwork{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    
    struct sockaddr_storage zeroAddress;//IP地址
    
    bzero(&zeroAddress, sizeof(zeroAddress));//将地址转换为0.0.0.0
    zeroAddress.ss_len = sizeof(zeroAddress);//地址长度
    zeroAddress.ss_family = AF_INET;//地址类型为UDP, TCP, etc.
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}
-(BOOL)APPIntegrity{
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:@"SignerIdentity"] != nil)
    {
        return YES;
    }
    return NO;
}
////获得所有资源文件名
-(BOOL)allHasNameAndHas{

    NSString *bundlePath =[[NSBundle mainBundle]resourcePath];
    NSFileManager *manger=[NSFileManager defaultManager];
    NSString *path=[NSString stringWithFormat:@"%@/_CodeSignature/CodeResources",bundlePath];
    NSData *data=[manger contentsAtPath:path];
    NSString *hashStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"\n %@",hashStr);
    return YES;
}
//生成资源文件名及对应的hash的字典， eg:@{@"appicon":@"wegdfser45t643232324234"}；
//-(NSDictionary *)getBundleFileHash{
//    NSMutableDictionary * dicHash = [NSMutableDictionary dictionary];
//    NSArray * fileArr = [self allFilesAtPath:[[NSBundle mainBundle]resourcePath]];
//    for (NSString * fileName in fileArr) {
//        //对应的文件生成hash
//        NSString * HashString = [FileMD5Hash computeMD5HashOfFileInPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName]];
//        if (HashString != nil) {
//            [dicHash setObject:HashString forKey:fileName];
//        }
//    }
// //所有资源文件的hash就保存在这数组里
//  return dicHash;
//}
//返回值格式:1555642454396
-(NSString*)timeSwitchTimestamp:(NSString *)formatTime{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
//    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    NSString * timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]*1000] stringValue];
    
    NSLog(@"将某个时间转化成 时间戳timeSp:%ld",(long)timeSp); //时间戳的值
    
    return timeSp;
    
}
- (BOOL)isBlankString:(NSString *)str{
    NSString *string = str;
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}
-(NSString*)genderStringWithType:(NSString*)type{
    if ([type isEqualToString:@"0"]) {
        return NSLocalizedString(@"男", nil);
    }else if ([type isEqualToString:@"1"]){
        return NSLocalizedString(@"女", nil);
    }
    return @"";
    
}
@end
