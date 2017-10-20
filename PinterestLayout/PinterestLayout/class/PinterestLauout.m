//
//  PinterestLauout.m
//  PinterestLayout
//
//  Created by bjovov on 2017/10/20.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "PinterestLauout.h"

@interface PinterestLauout()
/*一共有几列*/
@property (nonatomic,assign) NSInteger numberOfColumns;
/*iterm间距*/
@property (nonatomic,assign) CGFloat cellPading;
/*collectionContent总高度*/
@property (nonatomic,assign) CGFloat contentHeight;
/*collectionContent宽度*/
@property (nonatomic,assign) CGFloat contentWidth;
/*缓存属性数组*/
@property (nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes*> *cacheArray;
@end

@implementation PinterestLauout
#pragma mark - override Menthod
- (void)prepareLayout{
    [super prepareLayout];
    self.numberOfColumns = 2.0;
    self.cellPading = 6.0;
    self.contentHeight = 0;
    UIEdgeInsets insets = self.collectionView.contentInset;
    self.contentWidth = self.collectionView.bounds.size.width - (insets.left + insets.right);
    
    CGFloat columnWidth = self.contentWidth / self.numberOfColumns;
    if (!self.cacheArray) {
        self.cacheArray = [[NSMutableArray alloc]init];
    }
    
    //每个cell初始的X轴和Y轴坐标
    NSMutableArray *xOffset = [[NSMutableArray alloc]init];
    NSMutableArray *yOffSet = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.numberOfColumns; i++) {
        [xOffset addObject:[NSNumber numberWithFloat:i*columnWidth]];
        [yOffSet addObject:[NSNumber numberWithFloat:0]];
    }
    
    NSInteger column = 0;
    NSInteger itermNum = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itermNum; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
        CGFloat photoHeight = [self.delegate heightForPhotoAtIndexPath:path];
        CGFloat height = self.cellPading *2 + photoHeight;
        CGRect frame = CGRectMake([xOffset[column] floatValue], [yOffSet[column] floatValue], columnWidth, height);
        CGRect insetFrame = CGRectInset(frame, _cellPading, _cellPading);
        
        //创建UICollectionViewLayoutAttributes
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        attributes.frame = insetFrame;
        [self.cacheArray addObject:attributes];
        
        //更新UICollectionView的contentHeight
        self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame));
        yOffSet[column] = [NSNumber numberWithFloat:[yOffSet[column] floatValue] + height];
        column = column < self.numberOfColumns - 1 ? column + 1 : 0;
    }
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (UICollectionViewLayoutAttributes *attributes in self.cacheArray) {
        //只对可视区域进行布局
        if (CGRectEqualToRect(attributes.frame, rect)) {
            [array addObject:attributes];
        }
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.cacheArray[indexPath.item];
}

@end

