//
//  ViewController.m
//  NormalCollectionView
//
//  Created by 曹学亮 on 2017/10/19.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "ViewController.h"
#import "NormalCollectionViewCell.h"
#import "ReusableView.h"
#import <Masonry/Masonry.h>

#define Iterm_Size (self.view.bounds.size.width - 20 *2)/3.0
#define MinHorizontalSpace 10
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewHeader" forIndexPath:indexPath];
        header.tip = [NSString stringWithFormat:@"Header"];
        header.backgroundColor = [UIColor purpleColor];
        return header;
    }else{
        ReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableViewFooter" forIndexPath:indexPath];
        footer.tip = [NSString stringWithFormat:@"Footer"];
        footer.backgroundColor = [UIColor purpleColor];
        return footer;
    }
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(Iterm_Size, Iterm_Size);
        layout.minimumLineSpacing = MinHorizontalSpace;
        layout.minimumInteritemSpacing = MinVerticalSpace;
        layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 30);
        layout.footerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.bounds), 30);
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        [_myCollection registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewHeader"];
        [_myCollection registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableViewFooter"];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

@end
