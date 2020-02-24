//
//  HWMDIDManager.h
//  elastos wallet
//
//  Created by 韩铭文 on 2020/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDManager : NSObject
+(instancetype)shareDIDManager;
-(void)copyDirToSharedDir;
-(BOOL)saveDir;

@end

NS_ASSUME_NONNULL_END
