//
//  ViewController.m
//  PinterestLayout
//
//  Created by bjovov on 2017/10/20.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "ViewController.h"
#import "PinterestLauout.h"
#import "NormalPhotoCell.h"
#import "PhotoModel.h"

@interface ViewController ()<UICollectionViewDataSource,PinterestLauoutDelegate>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.myCollection];
}

#pragma mark - UICollectionView M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoModel *model = self.dataArray[indexPath.item];
    NormalPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalPhotoCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (CGFloat)heightForPhotoAtIndexPath:(NSIndexPath *)path{
    PhotoModel *model = self.dataArray[path.item];
    UIImage *tmpImage = [UIImage imageNamed:model.imageName];
    return tmpImage.size.height;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        PinterestLauout *layout = [[PinterestLauout alloc]init];
        layout.delegate = self;
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[NormalPhotoCell class] forCellWithReuseIdentifier:@"NormalPhotoCell"];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        NSArray *tmpArray = @[
                              @{ @"Photo" : @"01",
                                 @"Caption" : @"VCON?",
                                 @"Comment" : @"Is Ray hinting that perhaps it's Vicki's turn next year?",
                                  },
                              ];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *tmp = obj;
            PhotoModel *model = [[PhotoModel alloc]init];
            model.imageName = tmp[@"Photo"];
            model.title = tmp[@"Caption"];
            model.detail = tmp[@"Comment"];
            [_dataArray addObject:model];
        }];
    }
    return _dataArray;
}
@end

