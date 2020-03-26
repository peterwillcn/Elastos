//
//  FMDBWalletModel.m
//  elastos wallet
//
//  Created by  on 2019/1/16.
//

#import "FMDBWalletModel.h"

@implementation FMDBWalletModel

NSString * NSStringFromTransactionState(walletSignType state) {
    switch (state) {
        case SingleSign:
            return @"SingleSign";
        case SingleSignReadonly:
            return @"SingleSignReadonly";
        case HowSign:
            return @"HowSign";
        case HowSignReadonly:
            return @"HowSignReadonly";
        default:
            return nil;
    }
}
@end
