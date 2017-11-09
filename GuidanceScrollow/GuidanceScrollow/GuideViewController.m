//
//  GuideViewController.m
//  GuidanceScrollow
//
//  Created by bjovov on 2017/11/9.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "GuideViewController.h"
#import "ImageCollectionViewCell.h"

@interface GuideViewController()
<UICollectionViewDataSource,UICollectionViewDelegate,ImageCollectionViewCellDelegate>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation GuideViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"IsFirst"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCollection];
    [self.view addSubview:self.pageControl];
    self.pageControl.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2.0 - 150/2.0, CGRectGetHeight(self.view.bounds) - 50, 150, 30);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    BOOL isHiden = indexPath.item == self.dataArray.count - 1 ? NO : YES;
    [cell setImage:self.dataArray[indexPath.item] enterButtonIsHiden:isHiden];
    cell.delegate = self;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = floor(self.myCollection.contentOffset.x / CGRectGetWidth(self.view.bounds));
    self.pageControl.currentPage = currentPage;
}

#pragma mark - ImageCollectionViewCellDelegate
- (void)didClickedEnterButton{
    if ([self.delegate respondsToSelector:@selector(didClickedEnterButtonMenthod)]) {
        [self.delegate didClickedEnterButtonMenthod];
    }
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _myCollection.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myCollection.dataSource = self;
        _myCollection.delegate = self;
        _myCollection.pagingEnabled = YES;
        _myCollection.showsHorizontalScrollIndicator = NO;
        [_myCollection registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    }
    return _myCollection;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.numberOfPages = self.dataArray.count;
    }
    return _pageControl;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        for(int i=1;i<5;i++){
            NSString *imageName = @"";
            if(self.view.frame.size.height==480){
                imageName = [NSString stringWithFormat:@"welcome%d_640x960",i];
            }else if(self.view.frame.size.height==567){
                imageName = [NSString stringWithFormat:@"welcome%d_640x1136",i];
            }else if(self.view.frame.size.height==667){
                imageName = [NSString stringWithFormat:@"welcome%d_750x1334",i];
            }else if (self.view.frame.size.height==1104){
                imageName = [NSString stringWithFormat:@"welcome%d_1242x2208",i];
            }else{
                imageName = [NSString stringWithFormat:@"welcome%d_640x1136",i];
            }
           [_dataArray addObject:imageName];
        }
    }
    return _dataArray;
}


@end

