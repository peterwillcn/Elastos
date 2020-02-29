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

   
//
//- (void)viewDidLoad
//{
//    [
//    // Do any additional setup after loading the view.
//    self.title =  @"拷贝文件到Sandbox";
//
//    //文件类型
//    NSString * docPath = [[NSBundle mainBundle] pathForResource:@"save1" ofType:@"dat"];
//
//    // 沙盒Documents目录
//    //    NSString * appDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//
//    // 沙盒Library目录
//    NSString * appDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    //appLib  Library/Caches目录
//    NSString *appLib = [appDir stringByAppendingString:@"/Caches"];
//
//    BOOL filesPresent = [self copyMissingFile:docPath toPath:appLib];
//    if (filesPresent) {
//        NSLog(@"OK");
//    }
//    else
//    {
//        NSLog(@"NO");
//    }
//
//    // 创建文件夹
//    NSString *createDir =  [NSHomeDirectory() stringByAppendingString:@"/test"];
//    [self createFolder:createDir];
//
//    // 把文件拷贝到Test目录
//    BOOL filesPresent1 = [self copyMissingFile:docPath toPath:createDir];
//    if (filesPresent1) {
//        NSLog(@"OK");
//    }
//    else
//    {
//        NSLog(@"NO");
//    }
//
//
//}
//
///**
// *    @brief    把Resource文件夹下的save1.dat拷贝到沙盒
// *
// *    @param     sourcePath     Resource文件路径
// *    @param     toPath     把文件拷贝到XXX文件夹
// *
// *    @return    BOOL
// */
//- (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath
//{
//    BOOL retVal = YES; // If the file already exists, we'll return success…
//    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
//    {
//        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
//    }
//    return retVal;
//}
//
///**
// *    @brief    创建文件夹
// *
// *    @param     createDir     创建文件夹路径
// */
//+ (void)createFolder:(NSString *)createDir
//{
//    BOOL isDir = NO;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    BOOL existed = [fileManager fileExistsAtPath:createDir isDirectory:&isDir];
//    if ( !(isDir == YES && existed == YES) )
//    {
//        [fileManager createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//}

        
@end
