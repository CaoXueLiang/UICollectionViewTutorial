//
//  PageScrollowLayout.m
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "PageScrollowLayout.h"

@interface PageScrollowLayout()
/*一共有多少页*/
@property (nonatomic,assign) NSUInteger numberOfPages;
@property (nonatomic,strong) NSMutableArray *itermAttributes;
@end

@implementation PageScrollowLayout
#pragma mark - Init Menthod
- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.pageInset = UIEdgeInsetsZero;
        self.numberOfItemsInPage = 0;
        self.columnsInPage = 0;
        self.numberOfPages = 0;
    }
    return self;
}

#pragma mark - OverVide Menthod
- (void)prepareLayout{
    [super prepareLayout];
    [self.itermAttributes removeAllObjects];
    
    /*一共有多少iterm*/
    NSInteger numberOfIterms = [self.collectionView numberOfItemsInSection:0];
    /*求显示有多少页*/
    CGFloat itermsInPage = [[NSString stringWithFormat:@"%ld",self.numberOfItemsInPage] floatValue];
    self.numberOfPages = ceil(numberOfIterms / itermsInPage);
    
    for (int i = 0; i < numberOfIterms; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:path];
        [self.itermAttributes addObject:attribute];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return (self.itermAttributes.count > 0) ? self.itermAttributes : [super layoutAttributesForElementsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    /*当前cell所在的页码*/
    NSInteger currentPage = floor(indexPath.item / self.numberOfItemsInPage);
    
    /*当前cell在当前页的index*/
    NSInteger currentIndex = indexPath.item - currentPage * self.numberOfItemsInPage;
    
    /*当前cell所在当前页的列*/
    NSInteger currentColumn = currentIndex % self.columnsInPage;
    
    /*当前cell所在当前页的行*/
    NSInteger currentRow = currentIndex / self.columnsInPage;
 
    //调整attributes(大小不变，位置不变)
    CGRect rect = attributes.frame;
    CGFloat point_X = self.collectionView.bounds.size.width *currentPage + self.pageInset.left + currentColumn * (self.itemSize.width + self.minimumLineSpacing);
    CGFloat point_Y = self.pageInset.top + currentRow * (self.itemSize.height + self.minimumInteritemSpacing);
    attributes.frame = CGRectMake(point_X, point_Y, rect.size.width, rect.size.height);
    return attributes;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds) * self.numberOfPages, [super collectionViewContentSize].height);
}

#pragma mark - Setter && Getter
- (NSMutableArray *)itermAttributes{
    if (!_itermAttributes) {
        _itermAttributes = [[NSMutableArray alloc]init];
    }
    return _itermAttributes;
}

@end
