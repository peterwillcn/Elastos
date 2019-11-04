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
    
    
if ([languageString  containsString:@"en"]) {
        [formatter setDateFormat:@"MM-dd-YYYY HH:mm:ss"];
  }else if ([languageString  containsString:@"zh"]){
        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
    }
    //将时间转换为字符串
    
    NSString *timeS = [formatter stringFromDate:myDate];
    
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
    
    
    if ([languageString  containsString:@"en"]) {

        [formatter setDateFormat:@"MM-dd-YYYY HH:mm:ss"];
        
    }else if ([languageString  containsString:@"zh"]){
        
        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
        
    }
   
   
    
    //将时间转换为字符串
    
    NSString *timeS = [formatter stringFromDate:myDate];
    
    return timeS;
}
-(NSString *)TimeFormatConversion:(NSString *)timeStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    // 设置为UTC时区
    // 这里如果不设置为UTC时区，会把要转换的时间字符串定为当前时区的时间（东八区）转换为UTC时区的时间
//    NSTimeZone *timezone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    
 
    NSString *languageString=[DAConfig userLanguage];
    
    
    if ([languageString  containsString:@"en"]) {
        
        [formatter setDateFormat:@"MM-dd-YYYY HH:mm:ss"];
        
    }else if ([languageString  containsString:@"zh"]){
        
        [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];
        
    }
    NSDate *someDay = [formatter dateFromString:timeStr];
    NSString *timeS = [formatter stringFromDate:someDay];
    
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
    
     [self showErrorInfo:NSLocalizedString(@"密码格式错误", nil)];
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
 
    NSArray *A=[NSArray arrayWithObjects:
                @{@"countries":@"阿富汗",@"mobileCode":@"93"},
                @{@"countries":@"阿尔巴尼亚",@"mobileCode":@"355"},
                @{@"countries":@"阿尔及利亚",@"mobileCode":@"213"},
                @{@"countries":@"萨摩亚",@"mobileCode":@"684"},
                @{@"countries":@"安道尔共和国",@"mobileCode":@"376"},
                @{@"countries":@"安哥拉",@"mobileCode":@"244"},
                @{@"countries":@"安圭拉岛",@"mobileCode":@"1264"},
                @{@"countries":@"安提瓜和巴布达",@"mobileCode":@"1268"},
                @{@"countries":@"阿根廷",@"mobileCode":@"54"},
                @{@"countries":@"亚美尼亚",@"mobileCode":@"374"},
                @{@"countries":@"阿鲁巴",@"mobileCode":@"297"},
                @{@"countries":@"澳大利亚",@"mobileCode":@"61"},
                @{@"countries":@"奥地利",@"mobileCode":@"43"},
                @{@"countries":@"阿塞拜疆",@"mobileCode":@"994"},
                nil];
    NSArray *B=[NSArray arrayWithObjects:
                @{@"countries":@"巴哈马",@"mobileCode":@"1242"},
                @{@"countries":@"巴林",@"mobileCode":@"973"},
                @{@"countries":@"孟加拉国",@"mobileCode":@"880"},
                @{@"countries":@"巴巴多斯",@"mobileCode":@"1246"},
                @{@"countries":@"白俄罗斯",@"mobileCode":@"375"},
                @{@"countries":@"比利时",@"mobileCode":@"32"},
                @{@"countries":@"伯利兹城",@"mobileCode":@"501"},
                @{@"countries":@"贝宁",@"mobileCode":@"229"},
                @{@"countries":@"百慕大",@"mobileCode":@"1441"},
                @{@"countries":@"不丹",@"mobileCode":@"975"},
                @{@"countries":@"玻利维亚",@"mobileCode":@"591"},
                @{@"countries":@"波斯尼亚和黑塞哥维那",@"mobileCode":@"387"},
                @{@"countries":@"博茨瓦纳",@"mobileCode":@"267"},
                @{@"countries":@"巴西",@"mobileCode":@"55"},
                @{@"countries":@"英属印度洋领地",@"mobileCode":@"246"},
                @{@"countries":@"文莱达鲁萨兰国",@"mobileCode":@"673"},
                @{@"countries":@"保加利亚",@"mobileCode":@"359"},
                @{@"countries":@"布基纳法索",@"mobileCode":@"226"},
                @{@"countries":@"布隆迪",@"mobileCode":@"257"},
                @{@"countries":@"泽西岛",@"mobileCode":@"1044"}, nil];
    NSArray *C=[NSArray arrayWithObjects:
                @{@"countries":@"柬埔寨",@"mobileCode":@"855"},
                @{@"countries":@"喀麦隆",@"mobileCode":@"237"},
                @{@"countries":@"加拿大",@"mobileCode":@"1"},
                @{@"countries":@"佛得角",@"mobileCode":@"238"},
                @{@"countries":@"开曼群岛",@"mobileCode":@"1345"},
                @{@"countries":@"中非共和国",@"mobileCode":@"236"},
                @{@"countries":@"乍得",@"mobileCode":@"235"},
                @{@"countries":@"智利",@"mobileCode":@"56"},
                @{@"countries":@"中国",@"mobileCode":@"86"},
                @{@"countries":@"圣延岛",@"mobileCode":@"6724"},
                @{@"countries":@"科科斯群岛",@"mobileCode":@"61891"},
                @{@"countries":@"哥伦比亚",@"mobileCode":@"57"},
                @{@"countries":@"科摩罗",@"mobileCode":@"269"},
                @{@"countries":@"刚果",@"mobileCode":@"242"},
                @{@"countries":@"库克群岛",@"mobileCode":@"682"},
                @{@"countries":@"哥斯达黎加",@"mobileCode":@"506"},
                @{@"countries":@"Cote D'Ivoire",@"mobileCode":@"225"},
                @{@"countries":@"克罗地亚",@"mobileCode":@"385"},
                @{@"countries":@"古巴",@"mobileCode":@"53"},
                @{@"countries":@"塞浦路斯",@"mobileCode":@"357"},
                @{@"countries":@"捷克",@"mobileCode":@"420"},
                nil];
    NSArray *D=[NSArray arrayWithObjects:
                @{@"countries":@"丹麦",@"mobileCode":@"45"},
                @{@"countries":@"吉布提",@"mobileCode":@"253"},
                @{@"countries":@"多米尼克国",@"mobileCode":@"1767"},
                //                @{@"countries":@"多米尼加共和国",@"mobileCode":@"1849"},
                
                nil];
    NSArray *E=[NSArray arrayWithObjects:
                @{@"countries":@"东帝汶",@"mobileCode":@"670"},
                @{@"countries":@"厄瓜多尔",@"mobileCode":@"593"},
                @{@"countries":@"埃及",@"mobileCode":@"20"},
                @{@"countries":@"萨尔瓦多",@"mobileCode":@"503"},
                @{@"countries":@"赤道几内亚",@"mobileCode":@"240"},
                @{@"countries":@"厄立特里亚国",@"mobileCode":@"291"},
                @{@"countries":@"爱沙尼亚",@"mobileCode":@"372"},
                @{@"countries":@"埃塞俄比亚",@"mobileCode":@"251"},
                nil];
    NSArray *F=[NSArray arrayWithObjects:
                @{@"countries":@"法罗群岛",@"mobileCode":@"298"},
                @{@"countries":@"斐济",@"mobileCode":@"679"},
                @{@"countries":@"芬兰",@"mobileCode":@"358"},
                @{@"countries":@"法国",@"mobileCode":@"33"},
                //          @{@"countries":@"法国大都会",@"mobileCode":@"33"},
                @{@"countries":@"法属圭亚那",@"mobileCode":@"594"},
                @{@"countries":@"法属玻里尼西亚",@"mobileCode":@"689"},
                nil];
    NSArray *G=[NSArray arrayWithObjects:
                @{@"countries":@"加蓬",@"mobileCode":@"241"},
                @{@"countries":@"冈比亚",@"mobileCode":@"220"},
                @{@"countries":@"格鲁吉亚",@"mobileCode":@"995"},
                @{@"countries":@"德国",@"mobileCode":@"49"},
                @{@"countries":@"加纳",@"mobileCode":@"233"},
                @{@"countries":@"直布罗陀",@"mobileCode":@"350"},
                @{@"countries":@"希腊",@"mobileCode":@"30"},
                @{@"countries":@"格陵兰",@"mobileCode":@"10045"},
                @{@"countries":@"格林纳达",@"mobileCode":@"1473"},
                @{@"countries":@"瓜德罗普岛",@"mobileCode":@"590"},
                @{@"countries":@"关岛",@"mobileCode":@"1671"},
                @{@"countries":@"危地马拉",@"mobileCode":@"502"},
                @{@"countries":@"几内亚",@"mobileCode":@"224"},
                @{@"countries":@"几内亚比绍",@"mobileCode":@"245"},
                @{@"countries":@"圭亚那",@"mobileCode":@"592"},
                nil];
    NSArray *H=[NSArray arrayWithObjects:
                @{@"countries":@"海地",@"mobileCode":@"509"},
                @{@"countries":@"洪都拉斯",@"mobileCode":@"504"},
                @{@"countries":@"香港",@"mobileCode":@"852"},
                @{@"countries":@"匈牙利",@"mobileCode":@"36"},
                nil];
    NSArray *I=[NSArray arrayWithObjects:
                @{@"countries":@"冰岛",@"mobileCode":@"354"},
                @{@"countries":@"印度",@"mobileCode":@"91"},
                @{@"countries":@"印度尼西亚",@"mobileCode":@"62"},
                @{@"countries":@"伊朗（伊斯兰共和国)",@"mobileCode":@"98"},
                @{@"countries":@"伊拉克",@"mobileCode":@"964"},
                @{@"countries":@"爱尔兰",@"mobileCode":@"353"},
                @{@"countries":@"以色列",@"mobileCode":@"972"},
                @{@"countries":@"意大利",@"mobileCode":@"39"},
                nil];
    NSArray *J=[NSArray arrayWithObjects:
                @{@"countries":@"牙买加",@"mobileCode":@"1876"},
                @{@"countries":@"日本",@"mobileCode":@"81"},
                @{@"countries":@"约旦",@"mobileCode":@"962"},
                nil];
    NSArray *K=[NSArray arrayWithObjects:
                @{@"countries":@"哈萨克",@"mobileCode":@"7"},
                @{@"countries":@"肯尼亚",@"mobileCode":@"254"},
                @{@"countries":@"科威特",@"mobileCode":@"965"},
                @{@"countries":@"吉尔吉斯",@"mobileCode":@"996"},
                nil];
    NSArray *L=[NSArray arrayWithObjects:
                @{@"countries":@"拉脱维亚",@"mobileCode":@"371"},
                @{@"countries":@"黎巴嫩",@"mobileCode":@"961"},
                @{@"countries":@"莱索托",@"mobileCode":@"266"},
                @{@"countries":@"利比里亚",@"mobileCode":@"231"},
                @{@"countries":@"利比亚",@"mobileCode":@"218"},
                @{@"countries":@"列支敦士登",@"mobileCode":@"423"},
                @{@"countries":@"立陶宛",@"mobileCode":@"370"},
                @{@"countries":@"卢森堡",@"mobileCode":@"352"},
                @{@"countries":@"老挝",@"mobileCode":@"856"},
                nil];
    NSArray *M=[NSArray arrayWithObjects:
                @{@"countries":@"澳门地区",@"mobileCode":@"853"},
                @{@"countries":@"马达加斯加",@"mobileCode":@"261"},
                @{@"countries":@"马拉维",@"mobileCode":@"265"},
                @{@"countries":@"马来西亚",@"mobileCode":@"60"},
                @{@"countries":@"马尔代夫",@"mobileCode":@"960"},
                @{@"countries":@"马里",@"mobileCode":@"223"},
                @{@"countries":@"马尔他",@"mobileCode":@"356"},
                @{@"countries":@"马提尼克岛",@"mobileCode":@"596"},
                @{@"countries":@"毛里塔尼亚",@"mobileCode":@"222"},
                @{@"countries":@"毛里求斯",@"mobileCode":@"230"},
                @{@"countries":@"马约特",@"mobileCode":@"262"},
                @{@"countries":@"墨西哥",@"mobileCode":@"52"},
                @{@"countries":@"密克罗尼西亚",@"mobileCode":@"691"},
                @{@"countries":@"摩尔多瓦",@"mobileCode":@"373"},
                @{@"countries":@"摩纳哥",@"mobileCode":@"377"},
                @{@"countries":@"外蒙古",@"mobileCode":@"976"},
                @{@"countries":@"黑山共和国",@"mobileCode":@"382"},
                @{@"countries":@"蒙特塞拉特",@"mobileCode":@"1664"},
                @{@"countries":@"摩洛哥",@"mobileCode":@"212"},
                @{@"countries":@"莫桑比克",@"mobileCode":@"258"},
                @{@"countries":@"缅甸",@"mobileCode":@"95"},
                nil];
    NSArray *N=[NSArray arrayWithObjects:
                @{@"countries":@"那米比亚",@"mobileCode":@"264"},
                @{@"countries":@"瑙鲁",@"mobileCode":@"674"},
                @{@"countries":@"尼泊尔",@"mobileCode":@"977"},
                @{@"countries":@"荷兰",@"mobileCode":@"31"},
                @{@"countries":@"荷兰安的列斯群岛",@"mobileCode":@"599"},
                @{@"countries":@"新喀里多尼亚",@"mobileCode":@"687"},
                @{@"countries":@"新西兰",@"mobileCode":@"64"},
                @{@"countries":@"尼加拉瓜",@"mobileCode":@"505"},
                @{@"countries":@"尼日尔",@"mobileCode":@"227"},
                @{@"countries":@"尼日利亚",@"mobileCode":@"234"},
                @{@"countries":@"诺福克岛",@"mobileCode":@"6723"},
                @{@"countries":@"朝鲜",@"mobileCode":@"850"},
                @{@"countries":@"北马里亚纳群岛",@"mobileCode":@"1670"},
                @{@"countries":@"挪威",@"mobileCode":@"47"},
                nil];
    NSArray *O=[NSArray arrayWithObjects:
                @{@"countries":@"阿曼",@"mobileCode":@"968"},
                
                nil];
    NSArray *P=[NSArray arrayWithObjects:
                @{@"countries":@"巴基斯坦",@"mobileCode":@"92"},
                @{@"countries":@"帛琉",@"mobileCode":@"680"},
                @{@"countries":@"巴勒斯坦",@"mobileCode":@"970"},
                @{@"countries":@"巴拿马",@"mobileCode":@"507"},
                @{@"countries":@"巴布亚新几内亚",@"mobileCode":@"675"},
                @{@"countries":@"巴拉圭",@"mobileCode":@"595"},
                @{@"countries":@"秘鲁",@"mobileCode":@"51"},
                @{@"countries":@"菲律宾共和国",@"mobileCode":@"63"},
                @{@"countries":@"皮特凯恩岛",@"mobileCode":@"10064"},
                @{@"countries":@"波兰",@"mobileCode":@"48"},
                @{@"countries":@"葡萄牙",@"mobileCode":@"351"},
                @{@"countries":@"波多黎各",@"mobileCode":@"1787"},
                nil];
    NSArray *Q=[NSArray arrayWithObjects:
                @{@"countries":@"卡塔尔",@"mobileCode":@"974"},
                nil];
    NSArray *R=[NSArray arrayWithObjects:
                @{@"countries":@"留尼汪岛",@"mobileCode":@"262"},
                @{@"countries":@"罗马尼亚",@"mobileCode":@"40"},
                @{@"countries":@"俄罗斯联邦",@"mobileCode":@"1007"},
                @{@"countries":@"卢旺达",@"mobileCode":@"250"},
                nil];
    NSArray *S=[NSArray arrayWithObjects:
                @{@"countries":@"美属萨摩亚",@"mobileCode":@"10684"},
                @{@"countries":@"圣马力诺共和国",@"mobileCode":@"378"},
                @{@"countries":@"沙特阿拉伯",@"mobileCode":@"966"},
                @{@"countries":@"塞内加尔",@"mobileCode":@"221"},
                @{@"countries":@"塞尔维亚共和国",@"mobileCode":@"381"},
                @{@"countries":@"塞舌尔",@"mobileCode":@"248"},
                @{@"countries":@"塞拉利昂",@"mobileCode":@"232"},
                @{@"countries":@"新加坡",@"mobileCode":@"65"},
                @{@"countries":@"斯洛伐克（斯洛伐克人的共和国）",@"mobileCode":@"421"},
                @{@"countries":@"斯洛文尼亚",@"mobileCode":@"386"},
                @{@"countries":@"索罗门群岛",@"mobileCode":@"677"},
                @{@"countries":@"索马里",@"mobileCode":@"252"},
                @{@"countries":@"南非",@"mobileCode":@"27"},
                @{@"countries":@"韩国",@"mobileCode":@"82"},
                @{@"countries":@"西班牙",@"mobileCode":@"34"},
                @{@"countries":@"斯里兰卡",@"mobileCode":@"94"},
                @{@"countries":@"苏丹",@"mobileCode":@"249"},
                @{@"countries":@"苏里南",@"mobileCode":@"597"},
                @{@"countries":@"斯威士兰",@"mobileCode":@"268"},
                @{@"countries":@"瑞典",@"mobileCode":@"46"},
                @{@"countries":@"瑞士",@"mobileCode":@"41"},
                @{@"countries":@"叙利亚",@"mobileCode":@"963"},
                @{@"countries":@"圣文森特和格林纳丁斯",@"mobileCode":@"1784"},
                @{@"countries":@"圣多美和普林西比",@"mobileCode":@"239"},
                nil];
    NSArray *T=[NSArray arrayWithObjects:
                @{@"countries":@"台湾地区",@"mobileCode":@"886"},
                @{@"countries":@"塔吉克",@"mobileCode":@"992"},
                @{@"countries":@"坦桑尼亚",@"mobileCode":@"255"},
                @{@"countries":@"泰国",@"mobileCode":@"66"},
                @{@"countries":@"多哥",@"mobileCode":@"228"},
                @{@"countries":@"托克劳",@"mobileCode":@"690"},
                @{@"countries":@"汤加",@"mobileCode":@"676"},
                @{@"countries":@"特立尼达和多巴哥",@"mobileCode":@"1868"},
                @{@"countries":@"突尼斯",@"mobileCode":@"216"},
                @{@"countries":@"土耳其",@"mobileCode":@"90"},
                @{@"countries":@"土库曼",@"mobileCode":@"993"},
                @{@"countries":@"土克斯及开科斯群岛",@"mobileCode":@"1809"},
                @{@"countries":@"图瓦卢",@"mobileCode":@"688"},
                @{@"countries":@"阿布哈兹",@"mobileCode":@"2007"},
                @{@"countries":@"南奥赛梯",@"mobileCode":@"3007"},
                
                @{@"countries":@"马其顿",@"mobileCode":@"389"},
                @{@"countries":@"圣基茨和尼维斯",@"mobileCode":@"1869"},
                @{@"countries":@"南苏丹共和国",@"mobileCode":@"211"},
                @{@"countries":@"刚果民主共和国",@"mobileCode":@"243"},
                nil];
    
    NSArray *U=[NSArray arrayWithObjects:
                @{@"countries":@"乌干达",@"mobileCode":@"256"},
                @{@"countries":@"乌克兰",@"mobileCode":@"380"},
                @{@"countries":@"阿拉伯联合酋长国",@"mobileCode":@"971"},
                @{@"countries":@"英国",@"mobileCode":@"44"},
                @{@"countries":@"美国",@"mobileCode":@"1001"},
                @{@"countries":@"乌拉圭",@"mobileCode":@"598"},
                @{@"countries":@"乌兹别克斯坦",@"mobileCode":@"998"},
                nil];
    NSArray *V=[NSArray arrayWithObjects:
                @{@"countries":@"瓦努阿图",@"mobileCode":@"678"},
                @{@"countries":@"梵蒂冈(罗马教廷)",@"mobileCode":@"10039"},
                @{@"countries":@"委内瑞拉",@"mobileCode":@"58"},
                @{@"countries":@"越南",@"mobileCode":@"84"},
                //                @{@"countries":@"维尔京群岛(英国)",@"mobileCode":@"01284"},
                nil];
    NSArray *W=[NSArray arrayWithObjects:
                @{@"countries":@"沃利斯和富图纳群岛",@"mobileCode":@"681"},
                @{@"countries":@"西撒哈拉",@"mobileCode":@"685"},
                nil];
    NSArray *X=[[NSArray alloc]init];
    NSArray *Y=[NSArray arrayWithObjects:
                @{@"countries":@"也门",@"mobileCode":@"967"},
                @{@"countries":@"南斯拉夫",@"mobileCode":@"338"},
                nil];
    NSArray *Z=[NSArray arrayWithObjects:
                @{@"countries":@"赞比亚",@"mobileCode":@"260"},
                @{@"countries":@"津巴布韦",@"mobileCode":@"263"},
                nil];
    
    

    NSArray *CountryCodeArray=@[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z];
    NSDictionary  *paramdata ;
    NSInteger LocationNum = code;
    for (NSArray *AZArray in CountryCodeArray) {
        for (NSDictionary *dic in AZArray) {
            NSInteger  mobileCode  = [dic[@"mobileCode"] integerValue];
            if (mobileCode ==LocationNum) {
                paramdata = dic;
            }
            
        }
    }
    
    if (paramdata) {
        return  NSLocalizedString(paramdata[@"countries"], nil);
    }
    return @"";

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
-(NSString *)getImageViewURLWithURL:(NSString*)urlString{
    NSString *urlLaString=[urlString substringFromIndex:[urlString length]-1];
    if ([urlLaString isEqualToString:@"/"] ) {
        urlString= [NSString stringWithFormat:@"%@bpinfo.json",urlString];
    }else{
        urlString= [NSString stringWithFormat:@"%@/bpinfo.json",urlString];
    }
    NSURL *url=  [NSURL URLWithString:urlString];
    NSData *data=[NSData dataWithContentsOfURL:url];
    if (data==nil) {
        return @"";
    }
    NSError *error;
    id jsonClass = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    return [NSString stringWithFormat:@"%@",jsonClass[@"org"][@"branding"][@"logo_256"]];
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
    
    #ifdef DEBUG
    return Http_IP;
    #elif PrvNet
     return Http_IP;
     #elif TestNet
    return Http_IP;
    #else
    NSString *http_ip =[STANDARD_USER_DEFAULT valueForKey:@"Http_IP"];
    if (http_ip.length>0) {
        return http_ip;
    }
    return  Http_IP;
   #endif

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

@end
