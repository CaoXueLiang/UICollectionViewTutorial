//
//  InspirationLayout.m
//  ParallaxCustomLayout
//
//  Created by bjovov on 2017/11/2.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "InspirationLayout.h"

/*默认情况下iterm的高度*/
CGFloat const standardHeight = 100.0;
/*滚动时item的最大高度*/
CGFloat const featuredHeight = 280.0;

@interface InspirationLayout()
@property (nonatomic,strong) NSMutableArray *attributesArray;
/*standard -> featured拖拽的距离*/
@property (nonatomic,assign) CGFloat dragOffset;
@end

@implementation InspirationLayout
#pragma mark - Init Menthod
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dragOffset = 180.0;
    }
    return self;
}

#pragma mark - Overvide Menthod
- (void)prepareLayout{
    [super prepareLayout];
    [self.attributesArray removeAllObjects];
    
    CGRect frame = CGRectZero;
    CGFloat y = 0;
    
    NSInteger numberOfIterm = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < numberOfIterm; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        /*下一个cell都在之前的cell之上*/
        attribute.zIndex = path.item;
        /*初始化时设置cell的高度都为标准高度*/
        CGFloat height = standardHeight;
        
        if (path.item == [self featuredItemIndex]) {
            /*featured Cell*/
            CGFloat yOffSet = standardHeight * [self nextItemPercentageOffset];
            y = self.collectionView.contentOffset.y - yOffSet;
            height = featuredHeight;

        }else if (path.item == [self featuredItemIndex] + 1 && path.item != numberOfIterm){
            /*在featuredCell之下，随着用户滚动逐渐变大*/
            CGFloat maxY = y + standardHeight;
            height = standardHeight + MAX((featuredHeight - standardHeight) * [self nextItemPercentageOffset], 0);
            y = maxY - height;
        }
        frame = CGRectMake(0, y, CGRectGetWidth(self.collectionView.bounds), height);
        attribute.frame = frame;
        [self.attributesArray addObject:attribute];
        NSLog(@"--%f--",self.collectionView.contentOffset.y);
        y = CGRectGetMaxY(frame);
    }
}

- (CGSize)collectionViewContentSize{
    NSInteger numberOfIterm = [self.collectionView numberOfItemsInSection:0];
    CGFloat contentHeight = (numberOfIterm * self.dragOffset) + (CGRectGetHeight(self.collectionView.bounds) - self.dragOffset);
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attributesArray;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

#pragma mark - Private Menthod
/*返回当前featuredCell的索引*/
- (int)featuredItemIndex{
   int index = (int)(self.collectionView.contentOffset.y / self.dragOffset);
   return MAX(0, index);
}

/*standardCell -> featuredCell*/
- (CGFloat)nextItemPercentageOffset{
    CGFloat percent = (self.collectionView.contentOffset.y / self.dragOffset) - [self featuredItemIndex];
    return percent;
}

#pragma mark - Setter && Getter
- (NSMutableArray *)attributesArray{
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc]init];
    }
    return _attributesArray;
}

@end
