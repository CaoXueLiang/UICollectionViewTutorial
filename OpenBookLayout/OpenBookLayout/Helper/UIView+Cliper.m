//
//  UIView+Cliper.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/25.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "UIView+Cliper.h"

@implementation UIView (Cliper)
- (void)clipWithCorners:(UIRectCorner)corner radius:(CGFloat)radius{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = path.CGPath;
    self.layer.mask = shapLayer;
}

@end
