//
//  CarouselScrollView.m
//  CarouselScrollView
//
//  Created by bjovov on 2017/11/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "CarouselScrollView.h"
#import "ImageCollectionViewCell.h"

@interface CarouselScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,assign) NSInteger totalItermCount;
@end

@implementation CarouselScrollView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
        [self setUp];
    }
    return self;
}

- (void)_initViews{
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize = self.bounds.size;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _myCollection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    [_myCollection registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    _myCollection.backgroundColor = [UIColor grayColor];
    _myCollection.showsHorizontalScrollIndicator = NO;
    _myCollection.showsVerticalScrollIndicator = NO;
    _myCollection.pagingEnabled = YES;
    _myCollection.delegate = self;
    _myCollection.dataSource = self;
    [self addSubview:_myCollection];
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 30, self.bounds.size.width, 30)];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
}

- (void)setUp{
    _isinFiniteLoop = YES;
    _isAutoScroll = YES;
}

- (void)_initTimer{
    [self invalidateTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc{
    _myCollection.delegate = nil;
    _myCollection = nil;
}

#pragma mark - Setter Menthod
- (void)setDirection:(UICollectionViewScrollDirection)direction{
    _flowLayout.scrollDirection = direction;
}

- (void)setIsinFiniteLoop:(BOOL)isinFiniteLoop{
    _isinFiniteLoop = isinFiniteLoop;
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll{
    _isAutoScroll = isAutoScroll;
    [self invalidateTimer];
    if (_isAutoScroll) {
        [self _initTimer];
    }
}

- (void)setImageArray:(NSArray *)imageArray{
    if (!imageArray || imageArray.count == 0) {
        return;
    }
    _imageArray = imageArray;
    _pageControl.numberOfPages = _imageArray.count;
    _totalItermCount = self.isAutoScroll ? _imageArray.count * 100 : _imageArray.count;
    if (_imageArray.count > 1) {
        _myCollection.scrollEnabled = YES;
        [self setIsAutoScroll:_isAutoScroll];
    }else{
        _myCollection.scrollEnabled = NO;
        [self setIsAutoScroll:NO];
    }
    [_myCollection reloadData];
    
    if (_myCollection.contentOffset.x == 0 && _totalItermCount) {
        int targetIndex = 0;
        if (self.isAutoScroll) {
            targetIndex = _totalItermCount * 0.5;
        }else{
            targetIndex = 0;
        }
        [_myCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
}

#pragma mark - Private Menthod
- (void)automaticScroll{
    if (_totalItermCount == 0) return;
    int currentIndex = [self currentIndex];
    int targetIndex = currentIndex + 1;
    [self scrollToIndex:targetIndex];
}

- (void)scrollToIndex:(int)targetIndex{
    if (targetIndex >= _totalItermCount) {
        if (self.isAutoScroll) {
            targetIndex = _totalItermCount * 0.5;
            [_myCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        }
        return;
    }
    [_myCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (int)currentIndex{
    if (_myCollection.bounds.size.width == 0 || _myCollection.bounds.size.height == 0) {
        return 0;
    }
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_myCollection.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_myCollection.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    return MAX(0, index);
}

- (NSInteger)pageControlIndexWithCurrentCellIndex:(NSInteger)index{
    return index % self.imageArray.count;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _totalItermCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    NSInteger  currentIndex = [self pageControlIndexWithCurrentCellIndex:indexPath.item];
    if ([self.imageArray[currentIndex] isKindOfClass:[UIImage class]]) {
        cell.image = self.imageArray[currentIndex];
    }else if ([self.imageArray[currentIndex] isKindOfClass:[NSString class]]){
        cell.imageURL = self.imageArray[currentIndex];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [self.delegate didSelectedIndex:[self pageControlIndexWithCurrentCellIndex:indexPath.item]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentIndex = [self currentIndex];
    _pageControl.currentPage = [self pageControlIndexWithCurrentCellIndex:currentIndex];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.isAutoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isAutoScroll) {
        [self _initTimer];
    }
}

@end

