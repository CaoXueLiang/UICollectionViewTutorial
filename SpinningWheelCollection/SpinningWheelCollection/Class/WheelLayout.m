//
//  WheelLayout.m
//  SpinningWheelCollection
//
//  Created by bjovov on 2017/10/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "WheelLayout.h"
#import "WheelCollectionLayoutAttributes.h"

@interface WheelLayout()
/*圆形半径*/
@property (nonatomic,assign) CGFloat radius;
/**itemCell的大小*/
@property (nonatomic,assign) CGSize itermSize;
/*每两个item之间的旋转角度*/
@property (nonatomic,assign) CGFloat anglePerItem;
/*所有的item的属性数组*/
@property (nonatomic,strong) NSMutableArray *allAttributeArray;
@end

@implementation WheelLayout
/*
 使用自定义的WheelCollectionLayoutAttributes
 不用系统自带的UICollectionViewLayoutAttributes
 */
+ (Class)layoutAttributesClass{
    return [WheelCollectionLayoutAttributes class];
}

#pragma mark - Init Menthod
- (instancetype)init{
    self = [super init];
    if (self) {
        self.radius = 500.0;
        self.itermSize = CGSizeMake(133, 173);
        self.anglePerItem = atan(self.itermSize.width / self.radius);
    }
    return self;
}

#pragma mark - Overvide Menthod
- (void)prepareLayout{
    [super prepareLayout];
    
    [self.allAttributeArray removeAllObjects];
    NSUInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    if (numberOfItem == 0) {
        return;
    }
    CGFloat angleAtExtreme = (numberOfItem - 1) * self.anglePerItem;
    CGFloat angle = -angleAtExtreme * self.collectionView.contentOffset.x / (self.collectionView.contentSize.width - CGRectGetWidth(self.collectionView.bounds));
    //NSLog(@"---%f---",self.collectionView.contentOffset.x);

    for (int i = 0; i < numberOfItem; i++) {
        CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
        CGFloat anchorPointY = (self.itermSize.height/2.0 + self.radius) / self.itermSize.height;
        WheelCollectionLayoutAttributes *attribute = [WheelCollectionLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attribute.anchorPoint = CGPointMake(0.5, anchorPointY);
        attribute.size = self.itermSize;
        attribute.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds));
        attribute.angle = angle + self.anglePerItem *i;
        attribute.transform = CGAffineTransformMakeRotation(attribute.angle);
        attribute.zIndex = (int)attribute.angle *100;
        [self.allAttributeArray addObject:attribute];
    }
}

- (CGSize)collectionViewContentSize{
    CGFloat numberOfIterm = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(numberOfIterm *self.itermSize.width, CGRectGetHeight(self.collectionView.bounds) - 64);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.allAttributeArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.allAttributeArray[indexPath.item];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

#pragma mark - Setter && Getter
- (NSMutableArray *)allAttributeArray{
    if (!_allAttributeArray) {
        _allAttributeArray = [[NSMutableArray alloc]init];
    }
    return _allAttributeArray;
}

@end
