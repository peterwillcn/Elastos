//
//  HMWtransferTransactionMultipleAddressDetailsTableViewCell.h
//  ELA
//
//  Created by  on 2018/12/27.
//  Copyright © 2018 HMW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMWtransferTransactionMultipleAddressDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDetailsLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textOffset;
@end

NS_ASSUME_NONNULL_END
