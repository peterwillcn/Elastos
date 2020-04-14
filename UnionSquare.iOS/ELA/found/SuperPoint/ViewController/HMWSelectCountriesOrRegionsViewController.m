//
//  HMWSelectCountriesOrRegionsViewController.m
//  FLWALLET
//
//  Created by  on 2018/10/31.
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
    [self setBackgroundImg:@""];
}
-(NSArray *)CountryCodeArray{
    if (!_CountryCodeArray) {
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
                    @{@"countries":@"中国香港",@"mobileCode":@"852"},
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
                    @{@"countries":@"苏里南",@"mobileCode":@"    00597"},
                    @{@"countries":@"斯威士兰",@"mobileCode":@"268"},
                    @{@"countries":@"瑞典",@"mobileCode":@" 0046"},
                    @{@"countries":@"瑞士",@"mobileCode":@"41"},
                    @{@"countries":@"叙利亚",@"mobileCode":@"963"},
                    @{@"countries":@"圣文森特和格林纳丁斯",@"mobileCode":@"1784"},
                    @{@"countries":@"圣多美和普林西比",@"mobileCode":@"239"},
                    nil];
        NSArray *T=[NSArray arrayWithObjects:
                    @{@"countries":@"中国台湾",@"mobileCode":@"886"},
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
       _CountryCodeArray=@[A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z];
    }
    return _CountryCodeArray;
}
-(NSArray *)headSectionArray{
    if (!_headSectionArray) {
//        NSString *path=[[NSBundle mainBundle]pathForResource:@"nationalMobilePhoneAreaCode" ofType:@"plist"];
//        NSDictionary *nationalMobilePhoneAreaCodeDict = [NSDictionary dictionaryWithContentsOfFile:path];
//        NSArray *allArra=[NSArray arrayWithArray:nationalMobilePhoneAreaCodeDict[@"allMobileCode"]];
        _headSectionArray =[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
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
