//
//  BookFlippingLayout.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookFlippingLayout.h"
#import <YYCategories/YYCategories.h>

#define ItemWidth 140 *1.3
#define ItermHeight 140 *1.30 *1.3
@interface BookFlippingLayout()
/*item的个数*/
@property (nonatomic,assign) NSInteger numberOfItem;
@end

@implementation BookFlippingLayout
#pragma mark - Override Menthod
- (void)prepareLayout{
    self.numberOfItem = [self.collectionView numberOfItemsInSection:0];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.numberOfItem/2.0 *CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.numberOfItem; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:path];
        if (attributes) {
            [array addObject:attributes];
        }
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *layout = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
   // NSLog(@"%@",NSStringFromCGRect([self getFrame]));
   // NSLog(@"item:%ld--offSetX:%f--",indexPath.item,self.collectionView.contentOffset.x);
    layout.frame = [self getFrame];
    CGFloat ratio = [self getRadioWithCollection:self.collectionView indexPath:indexPath];
    if ((ratio > 0 && indexPath.item % 2 == 1) || (ratio < 0 && indexPath.item % 2 == 0)) {
        if (indexPath.row != 0) {
            return nil;
        }
    }
    CATransform3D ratation = [self transformWithIndexpath:indexPath ratio:MIN(MAX(ratio, -1), 1)];
    layout.transform3D = ratation;
    if (indexPath.row == 0) {
        layout.zIndex = INT_MAX;
    }
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
- (CGFloat)getRadioWithCollection:(UICollectionView *)collection indexPath:(NSIndexPath *)indexPath{
    //计算页码(0~4)
    CGFloat page = (indexPath.item - indexPath.item%2) *0.5;
    /*
     计算比率self.numberOfItem = 9;
     (collection.contentOffset.x / collection.bounds.size.width)变换范围是0~3.5
     page的变换范围是0~4
     */
    CGFloat ratio = -0.5 + page - (collection.contentOffset.x / collection.bounds.size.width);
    
    //每张page的变换系数为0.1，让其看起来有层次感
    if (ratio > 0.5) {
        ratio = 0.5 + 0.1*(ratio - 0.5);
    }
    
    if (ratio < - 0.5){
        ratio = -0.5 + 0.1*(ratio + 0.5);
    }
    return ratio;
}

/*获取旋转的角度*/
- (CGFloat)getAngleWithIndexPath:(NSIndexPath *)indexPath radio:(CGFloat)radio{
    CGFloat angle = 0;
    if (indexPath.item % 2 == 0) {
        //旋转轴在page的左侧
        angle = (1 - radio) * (-M_PI_2);
    }
    
    if (indexPath.item % 2 == 1){
        //旋转轴在page的右侧
        angle = (1 + radio) *M_PI_2;
    }
    angle += (indexPath.row % 2) / 1000;
    return angle;
}

- (CATransform3D)transformWithIndexpath:(NSIndexPath *)indexPath ratio:(CGFloat)ratio{
    //增加透视效果
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/2000.0;
    CGFloat angle = [self getAngleWithIndexPath:indexPath radio:ratio];
    transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    return transform;
}

@end
