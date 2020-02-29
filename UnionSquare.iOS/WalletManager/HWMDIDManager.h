//
//  HWMDIDManager.h
//  elastos wallet
//
//  Created by  on 2020/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWMDIDManager : NSObject{
    NSString *rootPath;
}
+(instancetype)shareDIDManager;
-(void)copyDirToSharedDir;
-(BOOL)saveDir;

@end

NS_ASSUME_NONNULL_END
