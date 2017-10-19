//
//  CircleLayout.m
//  CircleLayout
//
//  Created by bjovov on 2017/10/19.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "CircleLayout.h"

#define ITEM_SIZE 80
@implementation CircleLayout
- (void)prepareLayout{
    //和init相似，必须call super的prepareLayout以保证初始化正确
    [super prepareLayout];
    CGSize size = self.collectionView.frame.size;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    _center = CGPointMake(size.width/2.0, size.height/2.0);
    _radius = MIN(size.width, size.height)/2.8;
}

- (CGSize)collectionViewContentSize{
    //整个collectionView的内容大小就是collectionView的大小（没有滚动）
    return self.collectionView.frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path{
    //初始化一个UICollectionViewLayoutAttributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    //设置attributes的属性
    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
    attributes.center = CGPointMake(_center.x + _radius *cosf(2*M_PI *path.item/_cellCount), _center.y + _radius *sinf(2*M_PI *path.item/_cellCount));
    return attributes;
}

/*返回rect中的所有的元素的布局属性*/
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributeArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < self.cellCount; i++) {
        [attributeArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
    return attributeArray;
}

/*插入前，cell在圆心位置，全透明*/
- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.alpha = 0;
    return attributes;
}

/*删除时，cell在圆心位置，全透明，且只有原来的1/10大*/
- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath{
    UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.alpha = 0;
    attributes.transform3D = CATransform3DMakeScale(1/10.0,1/10.0, 1);
    return attributes;
}

@end

