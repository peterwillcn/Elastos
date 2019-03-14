//
//  HMWSelectCountriesOrRegionsViewController.m
//  FLWALLET
//
//  Created by 韩铭文 on 2018/10/31.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import "HMWSelectCountriesOrRegionsViewController.h"
#import "HMWChooseTheCountryAreasTableViewCell.h"

static NSString *cellString=@"HMWChooseTheCountryAreasTableViewCell";
@interface HMWSelectCountriesOrRegionsViewController ()<UITableViewDelegate,UITableViewDataSource>
/*
 *<# #>
 */
@property(strong,nonatomic)UITableView *baseTableView;
/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *headSectionArray;

/*
 *<# #>
 */
@property(strong,nonatomic)NSArray *CountryCodeArray;

@end

@implementation HMWSelectCountriesOrRegionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=NSLocalizedString(@"选择国家/地区", nil);
    self.baseTableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    [self setBackgroundImg:@"tab_bg"];
}
-(NSArray *)CountryCodeArray{
    if (!_CountryCodeArray) {
//        NSString *path=[[NSBundle mainBundle]pathForResource:@"nationalMobilePhoneAreaCode" ofType:@"plist"];
//        NSDictionary *nationalMobilePhoneAreaCodeDict = [NSDictionary dictionaryWithContentsOfFile:path];
//        NSArray *allArra=[NSArray arrayWithArray:nationalMobilePhoneAreaCodeDict[@"allMobileCode"]];
//        //        NSLog(@"%@",allArra);
        
        NSArray *A=[NSArray arrayWithObjects:
                    @{@"countries":@"阿富汗",@"mobileCode":@"0093"},
                    @{@"countries":@"阿尔巴尼亚",@"mobileCode":@"00355"},
                    @{@"countries":@"阿尔及利亚",@"mobileCode":@"00213"},
                    @{@"countries":@"萨摩亚",@"mobileCode":@"00684"},
                    @{@"countries":@"安道尔共和国",@"mobileCode":@"00376"},
                    @{@"countries":@"安哥拉",@"mobileCode":@"00244"},
                    @{@"countries":@"安圭拉岛",@"mobileCode":@"001264"},
                    @{@"countries":@"安提瓜和巴布达",@"mobileCode":@"001268"},
                    @{@"countries":@"阿根廷",@"mobileCode":@"0054"},
                    @{@"countries":@"亚美尼亚",@"mobileCode":@"00374"},
                    @{@"countries":@"阿鲁巴",@"mobileCode":@"00374"},
                    @{@"countries":@"澳大利亚",@"mobileCode":@"0061"},
                    @{@"countries":@"奥地利",@"mobileCode":@"0043"},
                    @{@"countries":@"阿塞拜疆",@"mobileCode":@"00994"},
                    nil];
        NSArray *B=[NSArray arrayWithObjects:
                    @{@"countries":@"巴哈马",@"mobileCode":@"001242"},
                    @{@"countries":@"巴林",@"mobileCode":@"00973"},
                    @{@"countries":@"孟加拉国",@"mobileCode":@"00880"},
                    @{@"countries":@"巴巴多斯",@"mobileCode":@"001246"},
                    @{@"countries":@"白俄罗斯",@"mobileCode":@"00375"},
                    @{@"countries":@"比利时",@"mobileCode":@"0032"},
                    @{@"countries":@"伯利兹城",@"mobileCode":@"00501"},
                    @{@"countries":@"贝宁",@"mobileCode":@"00229"},
                    @{@"countries":@"百慕大",@"mobileCode":@"001441"},
                    @{@"countries":@"不丹",@"mobileCode":@"00975"},
                    @{@"countries":@"玻利维亚",@"mobileCode":@"00591"},
                    @{@"countries":@"波斯尼亚和黑塞哥维那",@"mobileCode":@"00387"},
                    @{@"countries":@"博茨瓦纳",@"mobileCode":@"00267"},
                    @{@"countries":@"巴西",@"mobileCode":@"0055"},
                    @{@"countries":@"英属印度洋领地",@"mobileCode":@"00246"},
                    @{@"countries":@"文莱达鲁萨兰国",@"mobileCode":@"00673"},
                    @{@"countries":@"保加利亚",@"mobileCode":@"00359"},
                    @{@"countries":@"布基纳法索",@"mobileCode":@"00226"},
                    @{@"countries":@"布隆迪",@"mobileCode":@"00257"},
                    @{@"countries":@"泽西岛",@"mobileCode":@"0044"},
                    
                    nil];
        NSArray *C=[NSArray arrayWithObjects:
                    @{@"countries":@"柬埔寨",@"mobileCode":@"00855"},
                    @{@"countries":@"喀麦隆",@"mobileCode":@"00237"},
                    @{@"countries":@"加拿大",@"mobileCode":@"001"},
                    @{@"countries":@"佛得角",@"mobileCode":@"00238"},
                    @{@"countries":@"开曼群岛",@"mobileCode":@"001345"},
                    @{@"countries":@"中非共和国",@"mobileCode":@"00236"},
                    @{@"countries":@"乍得",@"mobileCode":@"00235"},
                    @{@"countries":@"智利",@"mobileCode":@"0056"},
                    @{@"countries":@"中国",@"mobileCode":@"0086"},
                    @{@"countries":@"圣延岛",@"mobileCode":@"0061"},
                    @{@"countries":@"科科斯群岛",@"mobileCode":@"0061"},
                    @{@"countries":@"哥伦比亚",@"mobileCode":@"0057"},
                    @{@"countries":@"科摩罗",@"mobileCode":@"00269"},
                    @{@"countries":@"刚果",@"mobileCode":@"00242"},
                    @{@"countries":@"刚果民主共和国",@"mobileCode":@"00243"},
                    @{@"countries":@"库克群岛",@"mobileCode":@"00682"},
                    @{@"countries":@"哥斯达黎加",@"mobileCode":@"00506"},
                    @{@"countries":@"Cote D'Ivoire",@"mobileCode":@"00225"},
                    @{@"countries":@"克罗地亚",@"mobileCode":@"00385"},
                    @{@"countries":@"古巴",@"mobileCode":@"0053"},
                    @{@"countries":@"塞浦路斯",@"mobileCode":@"00357"},
                    @{@"countries":@"捷克",@"mobileCode":@"00420"},
                    nil];
        NSArray *D=[NSArray arrayWithObjects:
                    @{@"countries":@"丹麦",@"mobileCode":@"0045"},
                    @{@"countries":@"吉布提",@"mobileCode":@"00253"},
                    @{@"countries":@"多米尼克国",@"mobileCode":@"001767"},
                    //                @{@"countries":@"多米尼加共和国",@"mobileCode":@"001849"},
                    
                    nil];
        NSArray *E=[NSArray arrayWithObjects:
                    @{@"countries":@"东帝汶",@"mobileCode":@"00670"},
                    @{@"countries":@"厄瓜多尔",@"mobileCode":@"00593"},
                    @{@"countries":@"埃及",@"mobileCode":@"0020"},
                    @{@"countries":@"萨尔瓦多",@"mobileCode":@"00503"},
                    @{@"countries":@"赤道几内亚",@"mobileCode":@"00240"},
                    @{@"countries":@"厄立特里亚国",@"mobileCode":@"00291"},
                    @{@"countries":@"爱沙尼亚",@"mobileCode":@"00372"},
                    @{@"countries":@"埃塞俄比亚",@"mobileCode":@"00251"},
                    nil];
        NSArray *F=[NSArray arrayWithObjects:
                    @{@"countries":@"法罗群岛",@"mobileCode":@"00298"},
                    @{@"countries":@"斐济",@"mobileCode":@"00679"},
                    @{@"countries":@"芬兰",@"mobileCode":@"00358"},
                    @{@"countries":@"法国",@"mobileCode":@"0033"},
                    @{@"countries":@"法国大都会",@"mobileCode":@"0033"},
                    @{@"countries":@"法属圭亚那",@"mobileCode":@"00594"},
                    @{@"countries":@"法属玻里尼西亚",@"mobileCode":@"00689"},
                    nil];
        NSArray *G=[NSArray arrayWithObjects:
                    @{@"countries":@"加蓬",@"mobileCode":@"00241"},
                    @{@"countries":@"冈比亚",@"mobileCode":@"00220"},
                    @{@"countries":@"格鲁吉亚",@"mobileCode":@"00995"},
                    @{@"countries":@"德国",@"mobileCode":@"0049"},
                    @{@"countries":@"加纳",@"mobileCode":@"00233"},
                    @{@"countries":@"直布罗陀",@"mobileCode":@"00350"},
                    @{@"countries":@"希腊",@"mobileCode":@"0030"},
                    @{@"countries":@"格陵兰",@"mobileCode":@"0045"},
                    @{@"countries":@"格林纳达",@"mobileCode":@"001473"},
                    @{@"countries":@"瓜德罗普岛",@"mobileCode":@"00590"},
                    @{@"countries":@"关岛",@"mobileCode":@"001671"},
                    @{@"countries":@"危地马拉",@"mobileCode":@"00502"},
                    @{@"countries":@"几内亚",@"mobileCode":@"00224"},
                    @{@"countries":@"几内亚比绍",@"mobileCode":@"00245"},
                    @{@"countries":@"圭亚那",@"mobileCode":@"00592"},
                    nil];
        NSArray *H=[NSArray arrayWithObjects:
                    @{@"countries":@"海地",@"mobileCode":@"00509"},
                    @{@"countries":@"洪都拉斯",@"mobileCode":@"00504"},
                    @{@"countries":@"香港",@"mobileCode":@"00852"},
                    @{@"countries":@"匈牙利",@"mobileCode":@"0036"},
                    nil];
        NSArray *I=[NSArray arrayWithObjects:
                    @{@"countries":@"冰岛",@"mobileCode":@"00354"},
                    @{@"countries":@"印度",@"mobileCode":@"0091"},
                    @{@"countries":@"印度尼西亚",@"mobileCode":@"0062"},
                    @{@"countries":@"伊朗（伊斯兰共和国)",@"mobileCode":@"0098"},
                    @{@"countries":@"伊拉克",@"mobileCode":@"00964"},
                    @{@"countries":@"爱尔兰",@"mobileCode":@"00353"},
                    @{@"countries":@"以色列",@"mobileCode":@"00972"},
                    @{@"countries":@"意大利",@"mobileCode":@"0039"},
                    nil];
        NSArray *J=[NSArray arrayWithObjects:
                    @{@"countries":@"牙买加",@"mobileCode":@"001876"},
                    @{@"countries":@"日本",@"mobileCode":@"0081"},
                    @{@"countries":@"约旦",@"mobileCode":@"00962"},
                    nil];
        NSArray *K=[NSArray arrayWithObjects:
                    @{@"countries":@"哈萨克",@"mobileCode":@"007"},
                    @{@"countries":@"肯尼亚",@"mobileCode":@"00254"},
                    @{@"countries":@"科威特",@"mobileCode":@"00965"},
                    @{@"countries":@"吉尔吉斯",@"mobileCode":@"00996"},
                    nil];
        NSArray *L=[NSArray arrayWithObjects:
                    @{@"countries":@"拉脱维亚",@"mobileCode":@"00371"},
                    @{@"countries":@"黎巴嫩",@"mobileCode":@"00961"},
                    @{@"countries":@"莱索托",@"mobileCode":@"00266"},
                    @{@"countries":@"利比里亚",@"mobileCode":@"00231"},
                    @{@"countries":@"利比亚",@"mobileCode":@"00218"},
                    @{@"countries":@"列支敦士登",@"mobileCode":@"00423"},
                    @{@"countries":@"立陶宛",@"mobileCode":@"00370"},
                    @{@"countries":@"卢森堡",@"mobileCode":@"00352"},
                    @{@"countries":@"老挝",@"mobileCode":@"00856"},
                    nil];
        NSArray *M=[NSArray arrayWithObjects:
                    @{@"countries":@"澳门地区",@"mobileCode":@"00853"},
                    @{@"countries":@"马达加斯加",@"mobileCode":@"00261"},
                    @{@"countries":@"马拉维",@"mobileCode":@"00265"},
                    @{@"countries":@"马来西亚",@"mobileCode":@"0060"},
                    @{@"countries":@"马尔代夫",@"mobileCode":@"00960"},
                    @{@"countries":@"马里",@"mobileCode":@"00223"},
                    @{@"countries":@"马尔他",@"mobileCode":@"00356"},
                    @{@"countries":@"马提尼克岛",@"mobileCode":@"00596"},
                    @{@"countries":@"毛里塔尼亚",@"mobileCode":@"00222"},
                    @{@"countries":@"毛里求斯",@"mobileCode":@"00230"},
                    @{@"countries":@"马约特",@"mobileCode":@"00262"},
                    @{@"countries":@"墨西哥",@"mobileCode":@"0052"},
                    @{@"countries":@"密克罗尼西亚",@"mobileCode":@"00691"},
                    @{@"countries":@"摩尔多瓦",@"mobileCode":@"00373"},
                    @{@"countries":@"摩纳哥",@"mobileCode":@"00377"},
                    @{@"countries":@"外蒙古",@"mobileCode":@"00976"},
                    @{@"countries":@"黑山共和国",@"mobileCode":@"00382"},
                    @{@"countries":@"蒙特塞拉特",@"mobileCode":@"001664"},
                    @{@"countries":@"摩洛哥",@"mobileCode":@"00212"},
                    @{@"countries":@"莫桑比克",@"mobileCode":@"00258"},
                    @{@"countries":@"缅甸",@"mobileCode":@"0095"},
                    nil];
        NSArray *N=[NSArray arrayWithObjects:
                    @{@"countries":@"那米比亚",@"mobileCode":@"00264"},
                    @{@"countries":@"瑙鲁",@"mobileCode":@"00674"},
                    @{@"countries":@"尼泊尔",@"mobileCode":@"00977"},
                    @{@"countries":@"荷兰",@"mobileCode":@"0031"},
                    @{@"countries":@"荷兰安的列斯群岛",@"mobileCode":@"00599"},
                    @{@"countries":@"新喀里多尼亚",@"mobileCode":@"00687"},
                    @{@"countries":@"新西兰",@"mobileCode":@"0064"},
                    @{@"countries":@"尼加拉瓜",@"mobileCode":@"00505"},
                    @{@"countries":@"尼日尔",@"mobileCode":@"00227"},
                    @{@"countries":@"尼日利亚",@"mobileCode":@"00234"},
                    @{@"countries":@"诺福克岛",@"mobileCode":@"006723"},
                    @{@"countries":@"朝鲜",@"mobileCode":@"00850"},
                    @{@"countries":@"北马里亚纳群岛",@"mobileCode":@"001670"},
                    @{@"countries":@"挪威",@"mobileCode":@"0047"},
                    nil];
        NSArray *O=[NSArray arrayWithObjects:
                    @{@"countries":@"阿曼",@"mobileCode":@"00968"},
                    
                    nil];
        NSArray *P=[NSArray arrayWithObjects:
                    @{@"countries":@"巴基斯坦",@"mobileCode":@"0092"},
                    @{@"countries":@"帛琉",@"mobileCode":@"00680"},
                    @{@"countries":@"巴勒斯坦",@"mobileCode":@"00970"},
                    @{@"countries":@"巴拿马",@"mobileCode":@"00507"},
                    @{@"countries":@"巴布亚新几内亚",@"mobileCode":@"00675"},
                    @{@"countries":@"巴拉圭",@"mobileCode":@"00595"},
                    @{@"countries":@"秘鲁",@"mobileCode":@"0051"},
                    @{@"countries":@"菲律宾共和国",@"mobileCode":@"0063"},
                    @{@"countries":@"皮特凯恩岛",@"mobileCode":@"0064"},
                    @{@"countries":@"波兰",@"mobileCode":@"0048"},
                    @{@"countries":@"葡萄牙",@"mobileCode":@"00351"},
                    @{@"countries":@"波多黎各",@"mobileCode":@"001787"},
                    nil];
        NSArray *Q=[NSArray arrayWithObjects:
                    @{@"countries":@"卡塔尔",@"mobileCode":@"00974"},
                    nil];
        NSArray *R=[NSArray arrayWithObjects:
                    @{@"countries":@"留尼汪岛",@"mobileCode":@"00262"},
                    @{@"countries":@"罗马尼亚",@"mobileCode":@"0040"},
                    @{@"countries":@"俄罗斯联邦",@"mobileCode":@"007"},
                    @{@"countries":@"卢旺达",@"mobileCode":@"00250"},
                    nil];
        NSArray *S=[NSArray arrayWithObjects:
                    @{@"countries":@"美属萨摩亚",@"mobileCode":@"00685"},
                    @{@"countries":@"圣马力诺共和国",@"mobileCode":@"00378"},
                    @{@"countries":@"沙特阿拉伯",@"mobileCode":@"00966"},
                    @{@"countries":@"塞内加尔",@"mobileCode":@"00221"},
                    @{@"countries":@"塞尔维亚共和国",@"mobileCode":@"00381"},
                    @{@"countries":@"塞舌尔",@"mobileCode":@"00248"},
                    @{@"countries":@"塞拉利昂",@"mobileCode":@"00232"},
                    @{@"countries":@"新加坡",@"mobileCode":@"0065"},
                    @{@"countries":@"斯洛伐克（斯洛伐克人的共和国）",@"mobileCode":@"00421"},
                    @{@"countries":@"斯洛文尼亚",@"mobileCode":@"00386"},
                    @{@"countries":@"索罗门群岛",@"mobileCode":@"00677"},
                    @{@"countries":@"索马里",@"mobileCode":@"00252"},
                    @{@"countries":@"南非",@"mobileCode":@"0027"},
                    @{@"countries":@"韩国",@"mobileCode":@"0082"},
                    @{@"countries":@"西班牙",@"mobileCode":@"0034"},
                    @{@"countries":@"斯里兰卡",@"mobileCode":@"0094"},
                    @{@"countries":@"苏丹",@"mobileCode":@"00249"},
                    @{@"countries":@"苏里南",@"mobileCode":@"    00597"},
                    @{@"countries":@"斯威士兰",@"mobileCode":@"00268"},
                    @{@"countries":@"瑞典",@"mobileCode":@" 0046"},
                    @{@"countries":@"瑞士",@"mobileCode":@"0041"},
                    @{@"countries":@"叙利亚",@"mobileCode":@"00963"},
                    @{@"countries":@"圣文森特和格林纳丁斯",@"mobileCode":@"001784"},
                    @{@"countries":@"圣多美和普林西比",@"mobileCode":@"00239"},
                    nil];
        NSArray *T=[NSArray arrayWithObjects:
                    @{@"countries":@"台湾地区",@"mobileCode":@"00886"},
                    @{@"countries":@"塔吉克",@"mobileCode":@"00992"},
                    @{@"countries":@"坦桑尼亚",@"mobileCode":@"00255"},
                    @{@"countries":@"泰国",@"mobileCode":@"0066"},
                    @{@"countries":@"多哥",@"mobileCode":@"00228"},
                    @{@"countries":@"托克劳",@"mobileCode":@"00690"},
                    @{@"countries":@"汤加",@"mobileCode":@"00676"},
                    @{@"countries":@"特立尼达和多巴哥",@"mobileCode":@"001868"},
                    @{@"countries":@"突尼斯",@"mobileCode":@"00216"},
                    @{@"countries":@"土耳其",@"mobileCode":@"0090"},
                    @{@"countries":@"土库曼",@"mobileCode":@"00993"},
                    @{@"countries":@"土克斯及开科斯群岛",@"mobileCode":@"001809"},
                    @{@"countries":@"图瓦卢",@"mobileCode":@"00688"},
                    @{@"countries":@"阿布哈兹",@"mobileCode":@"007"},
                    @{@"countries":@"南奥赛梯",@"mobileCode":@"007"},
                    @{@"countries":@"马其顿",@"mobileCode":@"00389"},
                    @{@"countries":@"圣基茨和尼维斯",@"mobileCode":@"001869"},
                    @{@"countries":@"南苏丹共和国",@"mobileCode":@"00211"},
                    nil];
        
        NSArray *U=[NSArray arrayWithObjects:
                    @{@"countries":@"乌干达",@"mobileCode":@"00256"},
                    @{@"countries":@"乌克兰",@"mobileCode":@"00380"},
                    @{@"countries":@"阿拉伯联合酋长国",@"mobileCode":@"00971"},
                    @{@"countries":@"英国",@"mobileCode":@"0044"},
                    @{@"countries":@"美国",@"mobileCode":@"001"},
                    @{@"countries":@"乌拉圭",@"mobileCode":@"00598"},
                    @{@"countries":@"乌兹别克斯坦",@"mobileCode":@"00998"},
                    nil];
        NSArray *V=[NSArray arrayWithObjects:
                    @{@"countries":@"瓦努阿图",@"mobileCode":@"00678"},
                    @{@"countries":@"梵蒂冈(罗马教廷)",@"mobileCode":@"0039"},
                    @{@"countries":@"委内瑞拉",@"mobileCode":@"0058"},
                    @{@"countries":@"越南",@"mobileCode":@"0084"},
                    //                @{@"countries":@"维尔京群岛(英国)",@"mobileCode":@"01284"},
                    @{@"countries":@"维尔京群岛(美国)",@"mobileCode":@"001340"},
                    nil];
        NSArray *W=[NSArray arrayWithObjects:
                    @{@"countries":@"沃利斯和富图纳群岛",@"mobileCode":@"00681"},
                    @{@"countries":@"西撒哈拉",@"mobileCode":@"00685"},
                    nil];
        NSArray *X=[[NSArray alloc]init];
        NSArray *Y=[NSArray arrayWithObjects:
                    @{@"countries":@"也门",@"mobileCode":@"00967"},
                    @{@"countries":@"南斯拉夫",@"mobileCode":@"00381"},
                    nil];
        NSArray *Z=[NSArray arrayWithObjects:
                    @{@"countries":@"赞比亚",@"mobileCode":@"00260"},
                    @{@"countries":@"津巴布韦",@"mobileCode":@"00263"},
                    nil];
        
        
        
       _CountryCodeArray=@[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z];
        
    
        
    }
    return _CountryCodeArray;
    
    
}
-(NSArray *)headSectionArray{
    if (!_headSectionArray) {
//        NSString *path=[[NSBundle mainBundle]pathForResource:@"nationalMobilePhoneAreaCode" ofType:@"plist"];
//        NSDictionary *nationalMobilePhoneAreaCodeDict = [NSDictionary dictionaryWithContentsOfFile:path];
//        NSArray *allArra=[NSArray arrayWithArray:nationalMobilePhoneAreaCodeDict[@"allMobileCode"]];
////        NSLog(@"%@",allArra);
        _headSectionArray =[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G",@"H",@"I",@"J",@"K",@"M",@"L",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
    }
    return _headSectionArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self defultWhite];
    
}

-(UITableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _baseTableView.delegate=self;
        _baseTableView.dataSource=self;
        _baseTableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 10);
        _baseTableView.separatorColor = [UIColor whiteColor];
        _baseTableView.rowHeight=40;
        [_baseTableView registerNib:[UINib nibWithNibName:cellString bundle:nil] forCellReuseIdentifier:cellString];
        
        [_baseTableView setSectionIndexColor: [UIColor whiteColor]];
        _baseTableView.sectionIndexBackgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_baseTableView];
        [_baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuideBottom);
        }];
     

    }
    
    return _baseTableView;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HMWChooseTheCountryAreasTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellString];
    cell.moDict=self.CountryCodeArray[indexPath.section][indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return self.headSectionArray.count;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array=self.CountryCodeArray[section];
   
    return array.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSDictionary *modelDic=self.CountryCodeArray[indexPath.section][indexPath.row];
    if (self.delegate) {
        [self.delegate selectTheCountryAreasModel:modelDic];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return 28;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    return 0.01;
//}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *view= [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
    if (!view) {
        view = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
        view.textLabel.alpha=0.f;
        UIView *backView = [[UIView alloc]init];
        view.backgroundView = backView;
        view.backgroundView.backgroundColor = [UIColor clearColor];
//        sectionView.backgroundColor=RGB(245, 245, 245);
        UILabel *Label =[[UILabel alloc]initWithFrame:CGRectMake(18, 0, 100, 26)];
        Label.textColor = [UIColor whiteColor];
        Label.tag =100 ;
        [view addSubview:Label];
        view.tintColor = [UIColor whiteColor];
    }
        UILabel *title = [view viewWithTag:100];

    title.text = self.headSectionArray[section];
    return view;
}

//显示每组标题索引

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.headSectionArray;
}

//返回每个索引的内容

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return self.headSectionArray[section];

}
//点击索引栏标题时执行
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //这里是为了指定索引index对应的是哪个section的，默认的话直接返回index就好。其他需要定制的就针对性处理
    if ([title isEqualToString:UITableViewIndexSearch])
    {
        [tableView setContentOffset:CGPointZero animated:NO];//tabview移至顶部
        return NSNotFound;
    }
    else
    {
        return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index] ; // -1 添加了搜索标识
    }
}

@end
