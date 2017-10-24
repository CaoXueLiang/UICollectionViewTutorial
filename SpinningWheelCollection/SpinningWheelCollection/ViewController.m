//
//  ViewController.m
//  SpinningWheelCollection
//
//  Created by bjovov on 2017/10/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ViewController.h"
#import "WheelLayout.h"
#import "NormalCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCollection];
    self.myCollection.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - UICollectionView M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *imageName = self.dataArray[indexPath.item];
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionViewCell" forIndexPath:indexPath];
    cell.imageName = imageName;
    return cell;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        WheelLayout *layout = [[WheelLayout alloc]init];
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        _myCollection.backgroundColor = [UIColor blackColor];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        for (int i = 1; i < 15; i++) {
            [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _dataArray;
}

@end
