//
//  HMWtransferTransactionMultipleAddressDetailsView.m
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import "HMWtransferTransactionMultipleAddressDetailsView.h"


static NSString *cellString=@"HMWtransferTransactionMultipleAddressDetailsTableViewCell";
@interface HMWtransferTransactionMultipleAddressDetailsView ()<UITableViewDelegate,UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UITableView *baseTableView;

@end

@implementation HMWtransferTransactionMultipleAddressDetailsView
//-(instancetype)init{
//    self =[super init];
//    if (self) {
//        self =[[NSBundle mainBundle]loadNibNamed:@"HMWtransferTransactionMultipleAddressDetailsView" owner:nil options:nil].firstObject;
//        self.baseTableView.delegate=self;
//        self.baseTableView.dataSource=self;
//        [[HMWCommView share]makeBordersWithView:self.baseTableView];
//        self.baseTableView registerNib:[UINib nibWithNibName:cellString bundle:<#(nullable NSBundle *)#>] forCellReuseIdentifier:<#(nonnull NSString *)#>
//
//    }

//    return self;
//}

@end
