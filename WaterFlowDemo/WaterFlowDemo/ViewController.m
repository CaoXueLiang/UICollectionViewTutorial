//
//  ViewController.m
//  WaterFlowDemo
//
//  Created by 曹学亮 on 2017/10/22.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "ViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "NormalCollectionViewCell.h"
#import "CollectionHeaderFooter.h"
#import "PhotoModel.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.collectionView];
    [self addLongGesture];
}

- (void)addLongGesture{
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.collectionView addGestureRecognizer:longGesture];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLayoutForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)dealloc{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self updateLayoutForOrientation:toInterfaceOrientation];
}

- (void)updateLayoutForOrientation:(UIInterfaceOrientation)orientation {
    CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
    layout.columnCount = UIInterfaceOrientationIsPortrait(orientation) ? 2 : 3;
    [self.collectionView reloadData];
}

#pragma mark - Event Response
- (void)longPress:(UILongPressGestureRecognizer *)recognizer{
    CGPoint currentPoint = [recognizer locationInView:self.collectionView];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        /*获取当先选中的itemCell*/
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:currentPoint];
        [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self.collectionView updateInteractiveMovementTargetPosition:currentPoint];
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        [self.collectionView endInteractiveMovement];
    }else{
        [self.collectionView cancelInteractiveMovement];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionViewCell" forIndexPath:indexPath];
    PhotoModel *model = self.dataArray[indexPath.item];
    [cell setModel:model layout:collectionView.collectionViewLayout];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CollectionHeaderFooter *reusableView = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor orangeColor];
        reusableView.tip = @"Header";
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor purpleColor];
        reusableView.tip = @"Footer";
    }
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoModel *model = self.dataArray[indexPath.item];
    return [NormalCollectionViewCell sizeWithModel:model layout:collectionViewLayout];
}

#pragma mark - UICollectionViewDelegate
//iOS 9增加了重排功能
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
    //只有重排完成后才对数据源进行修改
  
}

- (void)moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
    //只有重排完成后才对数据源进行修改
    if (destinationIndexPath) {
        //将起点的数据删除
        PhotoModel *model = self.dataArray[sourceIndexPath.item];
        [self.dataArray removeObjectAtIndex:sourceIndexPath.item];
        
        //将终点的数据插入
        [self.dataArray insertObject:model atIndex:destinationIndexPath.item];
    }
}

#pragma mark - Setter && Getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc]init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.headerHeight = 35;
        layout.footerHeight = 35;
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_collectionView registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        [_collectionView registerClass:[CollectionHeaderFooter class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[CollectionHeaderFooter class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        for (int i = 1; i < 14; i++) {
            NSMutableString *string = [[NSMutableString alloc]init];
            PhotoModel *model = [[PhotoModel alloc]init];
            model.imageName = [NSString stringWithFormat:@"%d",i];
            model.title = @"标题";
            for (int n = 0; n < i; n++) {
                [string appendString:@"测试测试"];
            }
            model.detail = string;
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

@end
