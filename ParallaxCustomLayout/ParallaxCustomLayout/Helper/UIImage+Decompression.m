//
//  UIImage+Decompression.m
//  ParallaxCustomLayout
//
//  Created by bjovov on 2017/11/3.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "UIImage+Decompression.h"

@implementation UIImage (Decompression)
- (UIImage *)decompressedImage{
    UIGraphicsBeginImageContextWithOptions(self.size, YES, 0);
    [self drawAtPoint:CGPointZero];
    UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return currentImage;
}

@end
