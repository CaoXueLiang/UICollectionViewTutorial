//
//  BookListController.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookListController.h"
#import "BookCollectionViewCell.h"
#import "BookLayout.h"
#import "BookDetailController.h"

@interface BookListController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation BookListController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"书籍列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCollection];
    self.myCollection.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
        self.myCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
#endif
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookCollectionViewCell" forIndexPath:indexPath];
    cell.imageName = self.dataArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *imageName = self.dataArray[indexPath.item];
    BookDetailController *controller = [BookDetailController initWithImageName:imageName];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        BookLayout *layout = [[BookLayout alloc]init];
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[BookCollectionViewCell class] forCellWithReuseIdentifier:@"BookCollectionViewCell"];
        _myCollection.backgroundColor = [UIColor colorWithRed:62/255.0 green:72/255.0 blue:84/255.0 alpha:1];
        _myCollection.dataSource = self;
        _myCollection.delegate = self;
    }
    return _myCollection;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        NSArray *tmpArray = @[@"CoreData-cover",@"iOS8-cover",@"Swift-cover"];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *str = obj;
            [_dataArray addObject:str];
        }];
    }
    return _dataArray;
}
@end

