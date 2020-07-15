
#import "NENSinglePinger.h"

@interface NENAddressItem : NSObject

@property (nonatomic, copy, readonly) NSString *hostName;
/// average delay time
@property (nonatomic, assign, readonly) double delayMillSeconds;

@property (nonatomic, strong) NSMutableArray *delayTimes;

- (instancetype)initWithHostName:(NSString *)hostName;

@end

typedef void(^CompletionHandler)(NSString *, NSArray *);

NS_ASSUME_NONNULL_BEGIN

@interface NENPingManager : NSObject

- (void)getFatestAddress:(NSArray *)addressList completionHandler:(CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
