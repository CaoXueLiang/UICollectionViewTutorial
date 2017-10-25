//
//  BookLayout.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookLayout.h"
#import <YYCategories/YYCategories.h>

#define ItemWidth 140
#define ItermHeight 140 *1.30
#define Padding 50
#define ACTIVE_DISTANCE 190
#define ZOOM_FACTOR 0.3
@implementation BookLayout
#pragma mark - Init Menthod
- (instancetype)init{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ItemWidth, ItermHeight);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = Padding;
        self.collectionView.pagingEnabled = YES;
    }
    return self;
}

#pragma mark - Override Menthod
- (void)prepareLayout{
    self.collectionView.contentInset = UIEdgeInsetsMake(kScreenHeight/2.0 - ItermHeight/2.0,CGRectGetWidth(self.collectionView.bounds)/2.0 - ItemWidth/2.0, kScreenHeight/2.0 - ItermHeight/2.0, CGRectGetWidth(self.collectionView.bounds)/2.0 - ItemWidth/2.0);
}

/*返回滚动停止的点，自动对齐到网格*/
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    NSLog(@"%@",NSStringFromCGPoint(proposedContentOffset));
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置
    CGFloat offsetAdjustment = MAXFLOAT;
    
    //预期滚动停止时水平方向的中心点
    CGFloat horizontalCenter = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    
    //预期滚动停止时显示在屏幕上的区域
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes *attribute in array) {
        CGFloat currrentCentX = attribute.center.x;
        if (ABS(currrentCentX - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = currrentCentX - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

/*返回所有cell和附加试图的attributes*/
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attribute in array) {
        //只处理可视区域内的item
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            //可视区域中心点与item中心点距离
            CGFloat distance = CGRectGetMidX(visibleRect) - attribute.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                //当可视区域中心点和item中心点距离为0时达到最大放大倍数1.3
                //距离在0~200之间时放大倍数在1.3~1
                CGFloat zoom = 1 + ZOOM_FACTOR * (1- ABS(normalizedDistance));
                attribute.transform3D = CATransform3DMakeScale(zoom, zoom, 1);
                attribute.zIndex = 1.0;
            }
        }
    }
    return array;
}

/*返回YES，这样当边界改变的时候，-invalidateLayout会自动被发送，才能让layout得到刷新*/
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds{
    return YES;
}

@end

