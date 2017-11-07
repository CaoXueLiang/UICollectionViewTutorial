//
//  ViewController.m
//  ParallaxEffectlayout
//
//  Created by bjovov on 2017/11/7.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ViewController.h"
#import "ParallaxEffectlayout.h"
#import "NormalCollectionViewCell.h"
#import "InspirationModel.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCollection];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InspirationModel *model = self.dataArray[indexPath.item];
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionViewCell" forIndexPath:indexPath];
    cell.model = model;
    [cell parallaxOffsetForCollectionBounds:self.myCollection.bounds];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSArray *cellArray = [self.myCollection visibleCells];
    [cellArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NormalCollectionViewCell *cell = obj;
        [cell parallaxOffsetForCollectionBounds:self.myCollection.bounds];
    }];
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        ParallaxEffectlayout *layout = [[ParallaxEffectlayout alloc]init];
        layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 110);
        layout.minimumLineSpacing = 13;
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        _myCollection.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myCollection.dataSource = self;
        _myCollection.delegate = self;
        //解决 first cell 和 last cell 旋转时超出 top 和 bottom问题
        _myCollection.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
    }
    return _myCollection;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Inspirations" ofType:@"plist"];
        NSArray *tmpArray = [NSArray arrayWithContentsOfFile:path];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            InspirationModel *model = [InspirationModel initWithDictionary:dict];
            [_dataArray addObject:model];
        }];
    }
    return _dataArray;
}
@end

