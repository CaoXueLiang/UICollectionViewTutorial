//
//  ViewController.m
//  StickyHeadersLayout
//
//  Created by bjovov on 2017/11/6.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ViewController.h"
#import "StickyHeadersLayout.h"
#import "NormalCell.h"
#import "HeaderView.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *myCollection;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"StickyHeader";
    [self.view addSubview:self.myCollection];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 9;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCell" forIndexPath:indexPath];
    [cell setTip:[NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [cell setTip:[NSString stringWithFormat:@"section:%ld",indexPath.section]];
        return cell;
    }else{
        return nil;
    }
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        StickyHeadersLayout *layout = [[StickyHeadersLayout alloc]init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 45);
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _myCollection.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_myCollection registerClass:[NormalCell class] forCellWithReuseIdentifier:@"NormalCell"];
        [_myCollection registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}


@end
