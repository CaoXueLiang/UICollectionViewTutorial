//
//  BookFlippingLayout.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookFlippingLayout.h"

#define ItemWidth 120
#define ItermHeight 120 *1.6
@interface BookFlippingLayout()
/*item的个数*/
@property (nonatomic,assign) NSInteger numberOfItem;
@end

@implementation BookFlippingLayout
#pragma mark - Override Menthod
- (void)prepareLayout{
    self.numberOfItem = [self.collectionView numberOfItemsInSection:0];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.numberOfItem/2.0 *CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.numberOfItem; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:path];
        if (attributes) {
            [array addObject:attributes];
        }
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *layout = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    layout.frame = [self getFrame];
    return layout;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

#pragma mark - Private Menthod
/*获取iterm的frame*/
- (CGRect)getFrame{
    CGRect frame = CGRectZero;
    frame.origin.x = CGRectGetWidth(self.collectionView.bounds)/2.0 - ItemWidth/2.0 + self.collectionView.contentOffset.x;
    frame.origin.y = CGRectGetHeight(self.collectionView.bounds)/2.0 - ItermHeight/2.0;
    frame.size = CGSizeMake(ItemWidth, ItermHeight);
    return frame;
}

/*获取旋转比率(-1~1)*/
//- (CGFloat)getRadioWithCollection:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath{
//    //计算页码
//    CGFloat page
//}

@end
