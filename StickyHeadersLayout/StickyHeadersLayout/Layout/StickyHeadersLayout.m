//
//  StickyHeadersLayout.m
//  StickyHeadersLayout
//
//  Created by bjovov on 2017/11/6.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "StickyHeadersLayout.h"
#import "YYModel.h"

@implementation StickyHeadersLayout
#pragma mark - OverVide Menthod
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    /*返回当前可视范围内元素的attributes,包括cells, supplementary views, 和 decoration views*/
    NSMutableArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    UICollectionView * const collectionView = self.collectionView;
    
    //定义一个 NSMutableIndexSet 对象来保持对 header 的索引
    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        //找出当前cell对应的section索引
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            [missingSections addIndex:layoutAttributes.indexPath.section];
        }
    }
    
    /*遍历当前屏幕上显示的所有Header，然后将还显示在屏幕上的header的对应索引从Sections删除，
     这样就只保持了对刚刚移除屏幕header的追踪。*/
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
            [missingSections removeIndex:layoutAttributes.indexPath.section];
        }
    }
    
    /*将刚移出屏幕的 header (missing headers) 加入到 totalAttributeArray*/
    [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        [answer addObject:layoutAttributes];
    }];
    
    /*经过上面的操作，totalAttributeArray只保存着当前屏幕上所有元素 + 上一个 section header 的 attributes*/
    //-----------------------------------------------------------------------------------------
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        // 找出 header 的 attributes 如果是 Cell 的话 representedElementKind 就为 nil
       if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
           
            /*找出header当前所在的section*/
            NSInteger section = layoutAttributes.indexPath.section;
            NSInteger numberOfItemsInSection = [collectionView numberOfItemsInSection:section];
            
            NSIndexPath *firstObjectIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastObjectIndexPath = [NSIndexPath indexPathForItem:MAX(0, (numberOfItemsInSection - 1)) inSection:section];
            
            /*获取当前section中第一个item和最后一个item所对应的attributes*/
            UICollectionViewLayoutAttributes *firstObjectAttrs = [self layoutAttributesForItemAtIndexPath:firstObjectIndexPath];
            UICollectionViewLayoutAttributes *lastObjectAttrs = [self layoutAttributesForItemAtIndexPath:lastObjectIndexPath];
            
            /*得到header的frame*/
            CGFloat sectionHeaderHeight = CGRectGetHeight(layoutAttributes.frame);
            CGRect frameWithEdgeInsets = UIEdgeInsetsInsetRect(layoutAttributes.frame,
                                                               collectionView.contentInset);
            
            CGPoint origin = frameWithEdgeInsets.origin;
            UIEdgeInsets sectionInset = self.sectionInset;
           
            /*获取当前sectionHeaderY轴的最小值和最大值*/
            CGFloat minY = CGRectGetMinY(firstObjectAttrs.frame) - sectionHeaderHeight - sectionInset.top;
            CGFloat maxY = CGRectGetMaxY(lastObjectAttrs.frame) - sectionHeaderHeight + sectionInset.bottom;
            CGFloat currentY = MIN(MAX(self.collectionView.contentOffset.y + self.collectionView.contentInset.top, minY), maxY);
            
            origin.y = currentY;
            layoutAttributes.zIndex = NSIntegerMax;
            layoutAttributes.frame = (CGRect){
                .origin = origin,
                .size = layoutAttributes.frame.size
            };
        }
    }
    return answer;
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound{
    return YES;
}

@end

