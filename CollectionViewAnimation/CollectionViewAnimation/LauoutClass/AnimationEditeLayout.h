//
//  AnimationEditeLayout.h
//  CollectionViewAnimation
//
//  Created by bjovov on 2017/11/10.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationEditeLayout : UICollectionViewFlowLayout
/*
 根据移动距离，调整当前itermCell的大小
 */
- (void)resizeItemAtIndexPath:(NSIndexPath*)indexPath withPinchDistance:(CGFloat)distance;
/*
 重新调整捏合的Iterm
 */
- (void)resetPinchedItem;

@end

