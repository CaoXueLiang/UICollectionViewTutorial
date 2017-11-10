//
//  AnimationEditeLayout.m
//  CollectionViewAnimation
//
//  Created by bjovov on 2017/11/10.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "AnimationEditeLayout.h"

@interface AnimationEditeLayout()
/*正在进行动画的indexPath*/
@property (nonatomic,strong) NSMutableArray *indexPathsToAnimate;
/*当前捏合的cell的索引*/
@property (nonatomic,strong) NSIndexPath *pinchedItem;
/*当前捏合的cell的大小*/
@property (nonatomic,assign) CGSize pinchedItemSize;
@end

@implementation AnimationEditeLayout
#pragma mark - Init Menthod
- (instancetype)init{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(50, 50);
        self.minimumLineSpacing = 16;
        self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        self.pinchedItem = nil;
        self.pinchedItemSize = CGSizeZero;
    }
    return self;
}

#pragma mark - OverVide Menthod
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributesArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    if (self.pinchedItem) {
        UICollectionViewLayoutAttributes *attr = [[attributesArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"indexPath == %@", self.pinchedItem]] firstObject];
        attr.size = self.pinchedItemSize;
        attr.zIndex = 100;
    }
    return attributesArray;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    if ([indexPath isEqual:self.pinchedItem]) {
        attr.size = self.pinchedItemSize;
        attr.zIndex = 100;
    }
    return attr;
}

/*
 将当前将要变换的iterm的indexpath保存下来
 */
- (void)prepareForCollectionViewUpdates:(NSArray<UICollectionViewUpdateItem *> *)updateItems{
    [super prepareForCollectionViewUpdates:updateItems];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (UICollectionViewUpdateItem *iterm in updateItems) {
        if (iterm.updateAction == UICollectionUpdateActionInsert) {
            [indexPaths addObject:iterm.indexPathAfterUpdate];
        }else if (iterm.updateAction == UICollectionUpdateActionDelete){
            [indexPaths addObject:iterm.indexPathBeforeUpdate];
        }else if (iterm.updateAction == UICollectionUpdateActionMove){
            [indexPaths addObject:iterm.indexPathBeforeUpdate];
            [indexPaths addObject:iterm.indexPathAfterUpdate];
        }
    }
    self.indexPathsToAnimate = indexPaths;
}

/*
 插入动画
 */
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    if ([self.indexPathsToAnimate containsObject:itemIndexPath]) {
        /*只对需要变换的indexPath的cell的属性进行变换*/
        CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
        transform = CGAffineTransformRotate(transform, M_PI);
        attributes.transform = transform;
        attributes.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMaxY(self.collectionView.bounds));
        [self.indexPathsToAnimate removeObject:itemIndexPath];
    }
    return attributes;
}

/*
 删除动画
 */
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    if ([self.indexPathsToAnimate containsObject:itemIndexPath]) {
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -1.0/20000;
        transform = CATransform3DTranslate(transform, 0, 0, 19500);
        attributes.transform3D = transform;
        attributes.center = CGPointMake(CGRectGetMidX(self.collectionView.bounds), CGRectGetMidY(self.collectionView.bounds));
        attributes.alpha = 0.2;
        attributes.zIndex = 1;
        [self.indexPathsToAnimate removeObject:itemIndexPath];
    }else{
        attributes.alpha = 1.0;
    }
    return attributes;
}

/**
 变换结束后将保存的indexPath设置为nil
 */
- (void)finalizeCollectionViewUpdates{
    [super finalizeCollectionViewUpdates];
    self.indexPathsToAnimate = nil;
}

#pragma mark - Public Menthod
- (void)resizeItemAtIndexPath:(NSIndexPath*)indexPath withPinchDistance:(CGFloat)distance{
    self.pinchedItem = indexPath;
    self.pinchedItemSize = CGSizeMake(distance, distance);
}

- (void)resetPinchedItem{
    self.pinchedItem = nil;
    self.pinchedItemSize = CGSizeZero;
}

@end

