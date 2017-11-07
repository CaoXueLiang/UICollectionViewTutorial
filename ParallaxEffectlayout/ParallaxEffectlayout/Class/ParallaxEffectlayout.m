//
//  ParallaxEffectlayout.m
//  ParallaxEffectlayout
//
//  Created by bjovov on 2017/11/7.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ParallaxEffectlayout.h"

@implementation ParallaxEffectlayout
#pragma mark - OverVide Menthod
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    /*获取当前可视区域内的布局属性*/
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *layoutArray =  [[NSArray alloc]initWithArray:original copyItems:YES];
    
    CGFloat angle = M_PI *(-14/180.0);
    for (UICollectionViewLayoutAttributes *attributes in layoutArray) {

        /*cell按逆时针旋转14°*/
        attributes.transform = CGAffineTransformMakeRotation(angle);
    }
    return layoutArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
