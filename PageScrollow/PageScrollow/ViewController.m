//
//  ViewController.m
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ViewController.h"
#import "PageScrollowLayout.h"
#import "NormalCollectionCell.h"
#import "ImageModel.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.myCollection];
    [self.view addSubview:self.pageControl];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageModel *model = self.dataArray[indexPath.item];
    NormalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger curentIndex =  floor(self.myCollection.contentOffset.x / CGRectGetWidth(self.view.bounds));
    self.pageControl.currentPage = curentIndex;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        CGFloat width = CGRectGetWidth(self.view.bounds);
        PageScrollowLayout *layout = [[PageScrollowLayout alloc]init];
        layout.itemSize = CGSizeMake((width - 4*3)/4.0, 100);
        layout.numberOfItemsInPage = 8.0;
        layout.columnsInPage = 4;
        layout.minimumInteritemSpacing = 4;
        layout.minimumLineSpacing = 4;
        _myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.bounds), 200 + 4) collectionViewLayout:layout];
        _myCollection.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_myCollection registerClass:[NormalCollectionCell class] forCellWithReuseIdentifier:@"NormalCollectionCell"];
        _myCollection.dataSource = self;
        _myCollection.delegate = self;
        _myCollection.showsHorizontalScrollIndicator = NO;
        _myCollection.pagingEnabled = YES;
    }
    return _myCollection;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PropertyList" ofType:@"plist"];
        NSArray *tmpArray = [NSArray arrayWithContentsOfFile:path];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            ImageModel *model = [ImageModel initWithDictionary:dict];
            [_dataArray addObject:model];
        }];
    }
    return _dataArray;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.myCollection.frame), CGRectGetWidth(self.view.bounds), 25)];
        _pageControl.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.numberOfPages = ceil(self.dataArray.count / 8.0);
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

@end

