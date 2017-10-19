//
//  ViewController.m
//  NormalCollectionView
//
//  Created by 曹学亮 on 2017/10/19.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "ViewController.h"
#import "NormalCollectionViewCell.h"

#define Iterm_Size 80
#define MinHorizontalSpace 8
#define MinVerticalSpace 15
@interface ViewController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *myCollection;
@end

@implementation ViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Normal";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.myCollection];
}

#pragma mark - UICollectionView M
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionViewCell" forIndexPath:indexPath];
    cell.tip = [NSString stringWithFormat:@"{%ld,%ld}",indexPath.section,indexPath.item];
    return cell;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(Iterm_Size, Iterm_Size);
        layout.minimumLineSpacing = MinHorizontalSpace;
        layout.minimumInteritemSpacing = MinVerticalSpace;
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

@end
