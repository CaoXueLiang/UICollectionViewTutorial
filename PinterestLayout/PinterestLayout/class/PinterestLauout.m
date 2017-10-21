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
/*sectionInset*/
@property (nonatomic,assign) UIEdgeInsets sectionInset;
/*列间距*/
@property (nonatomic,assign) CGFloat minColumnSpacing;
/*行间距*/
@property (nonatomic,assign) CGFloat minInteritemSpacing;
/*存储每一列的高度*/
@property (nonatomic,strong) NSMutableArray *columnHeightsArray;
/*所有iterm的frame*/
@property (nonatomic,strong) NSMutableArray *unionRectsArray;
/*所有Collectioncell的属性数组*/
@property (nonatomic,strong) NSMutableArray *allItermAttributesArray;
@end

@implementation PinterestLauout
#pragma mark - Init
- (instancetype)init{
    self = [super init];
    if (self) {
        _numberOfColumns = 2;
        _minColumnSpacing = 10;
        _minInteritemSpacing = 10;
        _sectionInset = UIEdgeInsetsMake(10, 20, 10, 20);
    }
    return self;
}

#pragma mark - override Menthod
- (void)prepareLayout{
    [super prepareLayout];
    
    //将数组清空
    [self.columnHeightsArray removeAllObjects];
    [self.unionRectsArray removeAllObjects];
    [self.allItermAttributesArray removeAllObjects];
    
    CGFloat width = self.collectionView.bounds.size.width - _sectionInset.left - _sectionInset.right;
    CGFloat itermWidth = (width - (_numberOfColumns - 1) *_minColumnSpacing) / _numberOfColumns;
    NSInteger numberOfIterm = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < numberOfIterm; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        NSUInteger columnIndex = numberOfIterm % _numberOfColumns;
        CGFloat offSetX = _sectionInset.left + columnIndex * (itermWidth + _minColumnSpacing);
        CGFloat offSetY = 2;
        CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
        CGFloat itermHeight = 0;
        if (itemSize.width > 0 && itemSize.height > 0) {
            itermHeight = itemSize.height *itermWidth / itemSize.width;
        }
        
        //将所有铺的ItermAttribute保存下来
        UICollectionViewLayoutAttributes *attributes =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(offSetX, offSetY, itermWidth, itermHeight);
        [self.allItermAttributesArray addObject:attributes];
//        self.columnHeightsArray
//        self.columnHeightsArray[columnIndex] = @(CGRectGetMaxX(attributes.frame) + _minInteritemSpacing);
    }
}

- (CGSize)collectionViewContentSize{
    CGSize contentSize = self.collectionView.bounds.size;
    contentSize.height = [self.columnHeightsArray.lastObject floatValue];
    return contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.allItermAttributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.allItermAttributesArray[indexPath.item];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

#pragma mark - Setter && Getter
- (NSMutableArray *)columnHeightsArray{
    if (!_columnHeightsArray) {
        _columnHeightsArray = [[NSMutableArray alloc]init];
    }
    return _columnHeightsArray;
}

- (NSMutableArray *)unionRectsArray{
    if (!_unionRectsArray) {
        _unionRectsArray = [[NSMutableArray alloc]init];
    }
    return _unionRectsArray;
}

- (NSMutableArray *)allItermAttributesArray{
    if (!_allItermAttributesArray) {
        _allItermAttributesArray = [[NSMutableArray alloc]init];
    }
    return _allItermAttributesArray;
}

@end

