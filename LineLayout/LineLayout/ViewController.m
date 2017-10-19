//
//  ViewController.m
//  LineLayout
//
//  Created by bjovov on 2017/10/19.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "ViewController.h"
#import "LineLayout.h"
#import "LineCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *myCollection;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"LineLayout";
    [self.view addSubview:self.myCollection];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LineCollectionViewCell" forIndexPath:indexPath];
    cell.tip = [NSString stringWithFormat:@"%ld",indexPath.item];
    return cell;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        LineLayout *layout = [[LineLayout alloc]init];
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[LineCollectionViewCell class] forCellWithReuseIdentifier:@"LineCollectionViewCell"];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

@end
