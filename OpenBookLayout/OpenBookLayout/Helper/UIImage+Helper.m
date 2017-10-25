//
//  UIImage+Helper.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/25.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "UIImage+Helper.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation UIImage (Helper)
- (UIImage *)imageWithRoundedCornerRadius:(CGFloat)radius corners:(UIRectCorner)corner{
    UIGraphicsBeginImageContext(self.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    [path addClip];
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
