//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
#import "ELAUtils.h"

@implementation ELAUtils

+ (NSString *)localizedString:(NSString *)key
{
    return NSLocalizedString(key, nil);
}
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (NSString *)getNationality:(NSInteger )location
{
    NSString *result = @"";
    
    NSString *codeString = [NSString stringWithFormat:@"%ld", location];
    NSDictionary *contryName =
    @{
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
        @"中国香港":@"852",
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
        @"中国澳门":@"853",
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
        @"中国台湾":@"886",
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
    
    NSArray *contryArray = [contryName allKeysForObject:codeString];
    if (contryArray.count > 0)
    {
        result = ELALocalizedString(contryArray.firstObject);
    }
    else
    {
        result = ELALocalizedString(@"未知");
    }
    return result;
}


#pragma mark - time
+ (NSString *)getTime:(NSString *)timeStr
{
    
    NSTimeInterval time = [timeStr longLongValue];
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    if(time > 0)
    {
        NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy.MM.dd"];
        
        NSString *timeString = [formatter stringFromDate:date];
        
        return timeString;
    }
    return @"";
}

+ (NSString *)getTimeWithNumber:(double)time
{
    
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    if(time > 0)
    {
        NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy.MM.dd"];
        
        NSString *timeString = [formatter stringFromDate:date];
        
        return timeString;
    }
    return @"";
}
@end
