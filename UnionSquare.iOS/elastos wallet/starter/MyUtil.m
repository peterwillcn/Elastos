//
//  MyUtil.m
//  elastos wallet
//
//  Created by  on 2018/12/9.
//

#import "MyUtil.h"

@implementation MyUtil

+ (NSString *)getRootPath
{
    NSString *pathStr = [[NSBundle mainBundle] bundlePath];
    NSString *path = [NSString stringWithFormat:@"%@/Data", pathStr];
    
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSString *toPath = [toPathStr stringByAppendingString:@"/Data"];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:NO attributes:nil error:nil];
    [MyUtil copyFileFromPath:path toPath:toPath];
    
    return toPath;
}

+ (void)copyFileFromPath:(NSString *)sourcePath toPath:(NSString *)toPath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray* array = [fileManager contentsOfDirectoryAtPath:sourcePath error:&error];
    if(error)
    {
        //        NSLog(@"%@", error.localizedDescription);
    }
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [sourcePath stringByAppendingPathComponent:[array objectAtIndex:i]];
        NSString *fullToPath = [toPath stringByAppendingPathComponent:[array objectAtIndex:i]];
        //
        //判断是不是文件夹
        BOOL isFolder = NO;
        //判断是不是存在路径 并且是不是文件夹
        BOOL isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isFolder];
        if (isExist)
        {
            NSError *err = nil;[[NSFileManager defaultManager] copyItemAtPath:fullPath toPath:fullToPath error:&err];
            if (isFolder){
                
                [self copyFileFromPath:fullPath toPath:fullToPath];
                
            }
            
        }
        
    }
    
}
+(NSString*)DIDRootPath{
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *toPath = [NSString stringWithFormat:@"%@/DID/",toPathStr];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:toPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return toPath;
    
}
+(NSArray*)ReadCommDIDPath{
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *toPath = [NSString stringWithFormat:@"%@/Inbox",toPathStr];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:toPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //新建数组，存放各个文件路径
    NSMutableArray *allfilesAarry = [[NSMutableArray alloc]init];
    
    NSArray *filesAarry = [fileManager subpathsOfDirectoryAtPath:toPath error:nil];
    //遍历目录迭代器，获取各个文件路径
    for (NSString *fN in filesAarry) {
        if ([[fN pathExtension] isEqualToString:@"jwt"]) {
            NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",toPath,fN] error:nil];
            NSDate *fileCreateDate = [fileAttributes objectForKey:NSFileModificationDate];
            NSString *timeString=[[FLTools share]YMDWithDate:fileCreateDate];
            NSDictionary *filesDic=@{@"fileName":fN,@"date":timeString};
            [allfilesAarry addObject:filesDic];
        }
    }
    
    return allfilesAarry;
}
+(NSString*)readFlieCommDIDWithFlieName:(NSString*)FlieName{
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *toPath = [NSString stringWithFormat:@"%@/Inbox",toPathStr];
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:[NSString stringWithFormat:@"%@/%@",toPath ,FlieName]];
    NSData * data = [fh readDataToEndOfFile];
    NSString* TheFileContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return TheFileContent;
}
+(BOOL)AddCommDIDWithJWT:(NSString*)fromePath{
    BOOL hasFir=NO;
    if (![[fromePath pathExtension] isEqualToString:@"jwt"]) {
        return   hasFir;
    }
    NSString *FfileName=[NSString GetFileName:fromePath];
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *toPath = [NSString stringWithFormat:@"%@/Inbox",toPathStr];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:toPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //新建数组，存放各个文件路径
    
    NSArray *filesAarry = [fileManager subpathsOfDirectoryAtPath:toPath error:nil];
    //遍历目录迭代器，获取各个文件路径
    for (NSString *fN in filesAarry) {
        if ([fN isEqualToString:FfileName]) {
            return YES;
        }
    }
    
    return hasFir;
}
+(NSArray*)ReadDIDPathWithWalletID:(NSString*)walletID{
    
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *toPath = [NSString stringWithFormat:@"%@/Credentials/%@",toPathStr,walletID];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:toPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSMutableArray *allfilesAarry = [[NSMutableArray alloc]init];
    
    NSArray *filesAarry = [fileManager subpathsOfDirectoryAtPath:toPath error:nil];
    //遍历目录迭代器，获取各个文件路径
    for (NSString *fN in filesAarry) {
        if ([[fN pathExtension] isEqualToString:@"jwt"]) {
            NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@",toPath,fN] error:nil];
            NSDate *fileCreateDate = [fileAttributes objectForKey:NSFileModificationDate];
            NSString *timeString=[[FLTools share]YMDWithDate:fileCreateDate];
            NSDictionary *filesDic=@{@"fileName":fN,@"date":timeString};
            [allfilesAarry addObject:filesDic];
        }
    }
    return  allfilesAarry;
}
+(BOOL)saveDIDPathWithWalletID:(NSString*)walletID withString:(NSString*)jwtString WithFielName:(NSString*)fielName{
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *toPath = [NSString stringWithFormat:@"%@/Credentials/%@",toPathStr,walletID];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:toPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:toPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSError *error;
    NSArray *filesAarry = [fileManager subpathsOfDirectoryAtPath:toPath error:nil];
    NSString *newFileName=fielName;
    //遍历目录迭代器，获取各个文件路径
    for (NSString *fN in filesAarry) {
        NSString*nfn=fN;
        NSArray *felChange=[fN componentsSeparatedByString:@"-"];
        if (felChange.count>1) {
            nfn=felChange.firstObject;
            
        }
        if ([nfn isEqualToString:fielName]) {
            newFileName=[[FLTools share]getFileIndexCount:nfn];
        }
    }
    [jwtString writeToFile:[NSString stringWithFormat:@"%@/%@",toPath,fielName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    
    if  (error == nil) {
        
        NSString *fPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *fPath = [NSString stringWithFormat:@"%@/Inbox/%@",fPathStr,fielName];
        if (fPath) {
            [fileManager removeItemAtPath:fPath error:&error];
        }
        
        
    }else{
        NSLog(@"error = %@",error);
        NSLog(@"存储失败！！！");
        return NO;
    }
    
    return YES;
    
}
+(NSString*)jwtPathWithWalletID:(NSString*)walletID withFileName:(NSString*)fileName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *toPathStr = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *toPath = [NSString stringWithFormat:@"%@/Credentials/%@/",toPathStr,walletID];
    
    NSString * testDirectory = [toPath stringByAppendingPathComponent:fileName];
    BOOL res = [fileManager fileExistsAtPath:testDirectory];
    
    if (res== NO){
        return @"";
    }
    return testDirectory;
    
    
    
    
    
}


@end
