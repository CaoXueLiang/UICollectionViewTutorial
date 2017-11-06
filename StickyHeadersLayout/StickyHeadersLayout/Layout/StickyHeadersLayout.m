//
//  StickyHeadersLayout.m
//  StickyHeadersLayout
//
//  Created by bjovov on 2017/11/6.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "StickyHeadersLayout.h"

@implementation StickyHeadersLayout
#pragma mark - OverVide Menthod
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    /*返回当前可视范围内元素的attributes,包括cells, supplementary views, 和 decoration views*/
    NSMutableArray *totalAttributeArray = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    
    NSMutableIndexSet *Sections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *attributes in totalAttributeArray) {
        //找出当前cell对应的section索引
        if (attributes.representedElementCategory == UICollectionElementCategoryCell) {
            [Sections addIndex:attributes.indexPath.section];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attributes in totalAttributeArray) {
        //遍历当前屏幕上显示的所有Header，然后将还显示在屏幕上的header的对应索引从Sections删除，这样就只保持了对刚刚移除屏幕header的追踪。
        if (attributes.representedElementKind == UICollectionElementKindSectionHeader) {
            [Sections removeIndex:attributes.indexPath.section];
        }
    }
    
    /*将刚移出屏幕的 header (missing headers) 加入到 totalAttributeArray*/
    [Sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:path];
        [totalAttributeArray addObject:layoutAttributes];
    }];
    
    for (UICollectionViewLayoutAttributes *attribute in totalAttributeArray) {
        if (attribute.representedElementKind == UICollectionElementKindSectionHeader) {
            NSInteger section = attribute.indexPath.section;
            NSInteger numberOfItermsInSection = [self.collectionView numberOfItemsInSection:section];
            
            NSIndexPath *firstObjectIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastObjectIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItermsInSection - 1) inSection:section];
            
            BOOL cellsExist;
            UICollectionViewLayoutAttributes *firstObjectAttributes;
            UICollectionViewLayoutAttributes *lastObjectAttributes;
            
            if (numberOfItermsInSection > 0) {
                //cell存在时
                cellsExist = YES;
                firstObjectAttributes = [self layoutAttributesForItemAtIndexPath:firstObjectIndexPath];
                lastObjectAttributes = [self layoutAttributesForItemAtIndexPath:lastObjectIndexPath];
            }else{
                //显示SectionHeader
                cellsExist = NO;
                firstObjectAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:firstObjectIndexPath];
                lastObjectAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:lastObjectIndexPath];
            }
            
            CGFloat topHeaderHeight = cellsExist ? CGRectGetHeight(attribute.frame) : 0;
            CGFloat bottomHeaderHeight = CGRectGetHeight(attribute.frame);
            CGRect frameWithEdgeInsets = UIEdgeInsetsInsetRect(attribute.frame, self.collectionView.contentInset);
            
            CGPoint original = frameWithEdgeInsets.origin;
            UIEdgeInsets sectionInsets = self.sectionInset;
            CGFloat firstY = MAX(self.collectionView.contentOffset.y + self.collectionView.contentInset.top, CGRectGetMinY(firstObjectAttributes.frame) - topHeaderHeight - sectionInsets.top);
            original.y = MIN(firstY, CGRectGetMaxY(lastObjectAttributes.frame) - bottomHeaderHeight + sectionInsets.bottom);
            
            attribute.zIndex = NSIntegerMax;
            attribute.frame = CGRectMake(original.x, original.y, attribute.frame.size.width, attribute.size.height);
        }
    }
    return totalAttributeArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

/*- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *answer = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    UICollectionView * const collectionView = self.collectionView;
    CGPoint const contentOffset = collectionView.contentOffset;
    
    NSMutableIndexSet *missingSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        if (layoutAttributes.representedElementCategory == UICollectionElementCategoryCell) {
            [missingSections addIndex:layoutAttributes.indexPath.section];
        }
    }
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [missingSections removeIndex:layoutAttributes.indexPath.section];
        }
    }
 
    [missingSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        
        UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        [answer addObject:layoutAttributes];
        
    }];
    
    for (UICollectionViewLayoutAttributes *layoutAttributes in answer) {
        
        if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            NSInteger section = layoutAttributes.indexPath.section;
            NSInteger numberOfItemsInSection = [collectionView numberOfItemsInSection:section];
            
            NSIndexPath *firstObjectIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            NSIndexPath *lastObjectIndexPath = [NSIndexPath indexPathForItem:MAX(0, (numberOfItemsInSection - 1)) inSection:section];
            
            BOOL cellsExist;
            UICollectionViewLayoutAttributes *firstObjectAttrs;
            UICollectionViewLayoutAttributes *lastObjectAttrs;
            
            if (numberOfItemsInSection > 0) { // use cell data if items exist
                cellsExist = YES;
                firstObjectAttrs = [self layoutAttributesForItemAtIndexPath:firstObjectIndexPath];
                lastObjectAttrs = [self layoutAttributesForItemAtIndexPath:lastObjectIndexPath];
            } else { // else use the header and footer
                cellsExist = NO;
                firstObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                        atIndexPath:firstObjectIndexPath];
                lastObjectAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                       atIndexPath:lastObjectIndexPath];
                
            }
            
            CGFloat topHeaderHeight = (cellsExist) ? CGRectGetHeight(layoutAttributes.frame) : 0;
            CGFloat bottomHeaderHeight = CGRectGetHeight(layoutAttributes.frame);
            CGRect frameWithEdgeInsets = UIEdgeInsetsInsetRect(layoutAttributes.frame,
                                                               collectionView.contentInset);
            
            CGPoint origin = frameWithEdgeInsets.origin;
            UIEdgeInsets sectionInset = self.sectionInset;
            
            origin.y = MIN(
                           MAX(
                               contentOffset.y + collectionView.contentInset.top,
                               (CGRectGetMinY(firstObjectAttrs.frame) - topHeaderHeight - sectionInset.top)
                               ),
                           (CGRectGetMaxY(lastObjectAttrs.frame) - bottomHeaderHeight + sectionInset.bottom)
                           );
            
            
            layoutAttributes.zIndex = NSIntegerMax;
            layoutAttributes.frame = (CGRect){
                .origin = origin,
                .size = layoutAttributes.frame.size
            };
            
        }
        
    }
    
    return answer;
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}*/

@end

