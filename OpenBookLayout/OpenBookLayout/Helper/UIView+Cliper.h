//
//  UIView+Cliper.h
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/25.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Cliper)

/**
 对UIView任一边添加圆角
 @param corner 圆角方向
 @param radius 圆角半径
 */
- (void)clipWithCorners:(UIRectCorner)corner radius:(CGFloat)radius;
@end
