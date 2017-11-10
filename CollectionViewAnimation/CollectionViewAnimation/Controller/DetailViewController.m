//
//  DetailViewController.m
//  CollectionViewAnimation
//
//  Created by bjovov on 2017/11/10.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "DetailViewController.h"
#import "NormalCollectionViewCell.h"
#import "AnimationEditeLayout.h"
#import <Masonry/Masonry.h>

@interface DetailViewController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *myCollection;
/*当前的iterm的个数*/
@property (nonatomic,assign) NSInteger currentItermCount;
/*当前选中的iterm的颜色*/
@property (nonatomic,strong) UIColor *currentColor;
/*当前选中的itermPath*/
@property (nonatomic,strong) NSIndexPath *selectedIndexPath;
@end

@implementation DetailViewController
#pragma mark - Life Cycle
+ (instancetype)initWithItermCount:(NSInteger)count color:(UIColor*)color selectedIterm:(NSIndexPath *)indexPath{
    DetailViewController *controller = [[DetailViewController alloc]init];
    controller.currentItermCount = count;
    controller.currentColor = color;
    controller.selectedIndexPath = indexPath;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"详情";
    [self.view addSubview:self.myCollection];
    [self.myCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    /*滑动到选中的那个iterm*/
    [self.myCollection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndexPath.item inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.currentItermCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionViewCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.currentColor;
    return cell;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        AnimationEditeLayout *layout = [[AnimationEditeLayout alloc]init];
        _myCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_myCollection registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}
@end
