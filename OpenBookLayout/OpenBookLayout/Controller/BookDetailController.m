//
//  BookDetailController.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookDetailController.h"
#import "DetailCollectionCell.h"
#import "BookFlippingLayout.h"

@interface BookDetailController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *imageName;
@end

@implementation BookDetailController
#pragma mark - init
+ (instancetype)initWithImageName:(NSString *)imageName{
    BookDetailController *controller = [[BookDetailController alloc]init];
    controller.imageName = imageName;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCollection];
    self.myCollection.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCollectionCell" forIndexPath:indexPath];
    [cell setImageName:self.dataArray[indexPath.item] row:indexPath.item];
    return cell;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        BookFlippingLayout *layout = [[BookFlippingLayout alloc]init];
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[DetailCollectionCell class] forCellWithReuseIdentifier:@"DetailCollectionCell"];
        _myCollection.backgroundColor = [UIColor colorWithRed:67/255.0 green:71/255.0 blue:83/255.0 alpha:1];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        [_dataArray addObject:self.imageName];
        [_dataArray addObject:@"page-blank"];
        for (int i = 0; i < 7; i++) {
            [_dataArray addObject:@"page-img"];
        }
    }
    return _dataArray;
}

@end

