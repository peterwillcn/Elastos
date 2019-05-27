//
//  HMWSelectCountriesOrRegionsViewController.h
//  FLWALLET
//
//  Created by  on 2018/10/31.
//  Copyright © 2018年 HMW. All rights reserved.
//

#import "HMWChooseTheCountryAreasModel.h"

@protocol HMWSelectCountriesOrRegionsViewControllerDelegate <NSObject>

-(void)selectTheCountryAreasModel:(NSDictionary*)modelDic;

@end
NS_ASSUME_NONNULL_BEGIN

@interface HMWSelectCountriesOrRegionsViewController : UIViewController
/*
 *
 */
@property(strong,nonatomic)id<HMWSelectCountriesOrRegionsViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
