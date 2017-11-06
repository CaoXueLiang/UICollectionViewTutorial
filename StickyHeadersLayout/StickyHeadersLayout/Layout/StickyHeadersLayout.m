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
    NSArray *visiableArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *totalAttributeArray = [visiableArray mutableCopy];

    
    NSMutableIndexSet *Sections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *attributes in totalAttributeArray) {
        //找出当前cell对应的section索引
        NSLog(@"%ld---%ld",attributes.representedElementCategory,attributes.indexPath.section);
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            if (![Sections containsIndex:attributes.indexPath.section]) {
                [Sections addIndex:attributes.indexPath.section];
            }
        }
    }

    for (UICollectionViewLayoutAttributes *attributes in totalAttributeArray) {
        //遍历当前屏幕上显示的所有Header，然后将还显示在屏幕上的header的对应索引从Sections删除，这样就只保持了对刚刚移除屏幕header的追踪。
        if (attributes.representedElementKind == UICollectionElementKindSectionHeader) {
            if ([Sections containsIndex:attributes.indexPath.section]) {
                [Sections removeIndex:attributes.indexPath.section];
            }
        }
    }

    /*将刚移出屏幕的 header (missing headers) 加入到 totalAttributeArray*/
    [Sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:path];
        [totalAttributeArray addObject:layoutAttributes];
    }];

    
    
    //经过上面的操作，totalAttributeArray只保存着当前屏幕上所有元素 + 上一个 section header 的 attributes

    for (UICollectionViewLayoutAttributes *attribute in totalAttributeArray) {
        // 找出 header 的 attributes 如果是 Cell 的话 representedElementKind 就为 nil
        if (attribute.representedElementKind == UICollectionElementKindSectionHeader) {

            /*找出header当前所在的section*/
            NSInteger section = attribute.indexPath.section;
            NSInteger numberOfItermsInSection = [self.collectionView numberOfItemsInSection:section];

            NSIndexPath *firstObjectIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastObjectIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItermsInSection - 1) inSection:section];

            /*获取当前section中第一个item和最后一个item所对应的attributes*/
            UICollectionViewLayoutAttributes *firstObjectAttributes = [self layoutAttributesForItemAtIndexPath:firstObjectIndexPath];
            UICollectionViewLayoutAttributes *lastObjectAttributes = [self layoutAttributesForItemAtIndexPath:lastObjectIndexPath];

            //得到header的frame
            CGRect headerFrame = attribute.frame;

            //获取当前的滚动距离
            CGFloat offSet = self.collectionView.contentOffset.y;

            CGFloat minY = CGRectGetMinY(firstObjectAttributes.frame) - headerFrame.size.height;
            CGFloat maxY = CGRectGetMaxY(lastObjectAttributes.frame) + headerFrame.size.height;

            // minY ≤ offset ≤ maxY
            CGFloat Y = MIN(MAX(offSet, minY), maxY);
            headerFrame.origin.y = Y;
            attribute.frame = headerFrame;
            attribute.zIndex = NSIntegerMax;
        }
    }
    return totalAttributeArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end

