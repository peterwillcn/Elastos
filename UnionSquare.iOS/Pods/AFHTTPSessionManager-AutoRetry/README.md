# AFHTTPSessionManager-AutoRetry
AFNetworking AutoRetry 3rd-party lib
## Installation with CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. See the ["Getting Started" guide for more information](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking). You can install it with the following command:

```bash
    $ gem install cocoapods
```

To integrate AFHTTPSessionManager-AutoRetry into your Xcode project using CocoaPods, specify it in your `Podfile`:

    pod 'AFHTTPSessionManager-AutoRetry'

Then, run the following command:

    pod install
    
## Usage
```objective-c
#import <AFHTTPSessionManager-AutoRetry/AFHTTPSessionManager+AutoRetry.h>
```
```objective-c
NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"data",@"key", nil];
AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
NSInteger autoretryCount = 3;
[sessionManager POST:@"url" parameters:params progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
//success
} failure:^(NSURLSessionDataTask * task, NSError * error) {
//fail
}autoretry:autoretryCount];
```
