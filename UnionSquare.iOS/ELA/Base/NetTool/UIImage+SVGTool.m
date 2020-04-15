//
/*
 * Copyright (c) 2020 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


#import "UIImage+SVGTool.h"
#import "SVGKImage.h"
#import "SVGKit.h"

@implementation UIImage (SVGTool)
/**
 @param name svg name-->xxx.svg
 @param size image size
 @return svg image
 */
+(UIImage *)svgImgNamed:(NSString *)name size:(CGSize)size{
    
    SVGKImage *svgImg = [SVGKImage imageNamed:name];
    svgImg.size = size;
    return svgImg.UIImage;
}
+(UIImage *)svgimagURL:(NSString*)URL size:(CGSize)size{
    SVGKImage *svgImg = [SVGKImage imageWithContentsOfURL:[NSURL URLWithString:URL]];
    svgImg.size = size;
    return svgImg.UIImage;
    

}
+(UIImage *)svgimagFile:(NSString*)file size:(CGSize)size{
    @try {
        SVGKImage *svgImage = [SVGKImage imageWithContentsOfFile:file];
        //
//            svgImg.size = size;
        //    return svgImg.UIImage;
        //    SVGKImage *svgImage = [SVGKImage imageNamed:name];
//            svgImage.size = size;
        return svgImage.UIImage;
//        CGRect rect = CGRectMake(0, 0,size.width, size.height);
//
//            CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.UIImage.CGImage);
//            BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
//            || alphaInfo == kCGImageAlphaNoneSkipFirst
//            || alphaInfo == kCGImageAlphaNone;
//            UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
//            CGContextRef context = UIGraphicsGetCurrentContext();
//            CGContextTranslateCTM(context, 0, svgImage.size.height);
//            CGContextScaleCTM(context, 1.0, -1.0);
//            CGContextSetBlendMode(context, kCGBlendModeNormal);
//            CGContextClipToMask(context, rect, svgImage.UIImage.CGImage);
//        //    CGContextSetFillColorWithColor(context, color.CGColor);
//            CGContextFillRect(context, rect);
//            UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            return imageOut;
    } @catch (NSException *exception) {
        //NSLog(@"exception-----%@",exception);
        return nil;
    } @finally {
        
    }
    
    
    
    
}

/**
 @param name svg name -->xxx.svg
 @param size image size
 @param color image color
 @return svg image
 */
+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size imageColor:(UIColor *)color {
    
    SVGKImage *svgImage = [SVGKImage imageNamed:name];
    svgImage.size = size;
    CGRect rect = CGRectMake(0, 0, svgImage.size.width, svgImage.size.height);
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(svgImage.UIImage.CGImage);
    BOOL opaque = alphaInfo == kCGImageAlphaNoneSkipLast
    || alphaInfo == kCGImageAlphaNoneSkipFirst
    || alphaInfo == kCGImageAlphaNone;
    UIGraphicsBeginImageContextWithOptions(svgImage.size, opaque, svgImage.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, svgImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextClipToMask(context, rect, svgImage.UIImage.CGImage);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}


@end
