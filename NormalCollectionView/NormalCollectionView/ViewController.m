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
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
@end

@implementation ViewController
#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Normal";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.myCollection];
    [self addLongGesture];
}

- (void)addLongGesture{
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.myCollection addGestureRecognizer:longGesture];
}

- (void)dealloc{
    self.myCollection.delegate = nil;
    self.myCollection.dataSource = nil;
}

#pragma mark - Event Response
- (void)longPress:(UILongPressGestureRecognizer *)recognizer{
    CGPoint currentPoint = [recognizer locationInView:self.myCollection];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        /*获取当先选中的itemCell*/
        NSIndexPath *selectedIndexPath = [self.myCollection indexPathForItemAtPoint:currentPoint];
        [self.myCollection beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self.myCollection updateInteractiveMovementTargetPosition:currentPoint];
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        [self.myCollection endInteractiveMovement];
    }else{
        [self.myCollection cancelInteractiveMovement];
    }
}

#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.dataDictionary allKeys].count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSString *sectionTitle = [self.dataDictionary allKeys][section];
    NSArray *itemArray = self.dataDictionary[sectionTitle];
    return itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *sectionTitle = [self.dataDictionary allKeys][indexPath.section];
    NSArray *itemArray = self.dataDictionary[sectionTitle];
    NSString *itermString = itemArray[indexPath.item];
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionViewCell" forIndexPath:indexPath];
    cell.tip = itermString;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableViewHeader" forIndexPath:indexPath];
        header.tip = [NSString stringWithFormat:@"Header%ld",indexPath.section];
        header.backgroundColor = [UIColor orangeColor];
        return header;
    }else{
        ReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ReusableViewFooter" forIndexPath:indexPath];
        footer.tip = [NSString stringWithFormat:@"Footer%ld",indexPath.section];
        footer.backgroundColor = [UIColor orangeColor];
        return footer;
    }
}

#pragma mark - UICollectionViewDelegate
//iOS 9增加了重排功能
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
    //只有重排完成后才对数据源进行修改
    if (destinationIndexPath) {
        //将起点的数据删除
        NSString *sectionTitle = [self.dataDictionary allKeys][sourceIndexPath.section];
        NSMutableArray *itemArray = self.dataDictionary[sectionTitle];
        NSString *originalStr = itemArray[sourceIndexPath.item];
        [itemArray removeObjectAtIndex:sourceIndexPath.item];
        
        //将终点的数据插入
        NSString *destinationSectionTitle = [self.dataDictionary allKeys][destinationIndexPath.section];
        NSMutableArray *destinationItemArray = self.dataDictionary[destinationSectionTitle];
        [destinationItemArray insertObject:originalStr atIndex:destinationIndexPath.item];
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
        _myCollection.delegate = self;
    }
    return _myCollection;
}

- (NSMutableDictionary *)dataDictionary{
    if (!_dataDictionary) {
        _dataDictionary = [[NSMutableDictionary alloc]init];
        NSArray *sectionArray = @[@"0",@"1",@"2"];
        for (int i = 0; i < sectionArray.count; i++) {
            NSString *sectionTitle = sectionArray[i];
            NSMutableArray *itermArray = [NSMutableArray array];
            for (int n = 0; n < 8; n++) {
                NSString *iterm = [NSString stringWithFormat:@"%d-%d",i,n];
                [itermArray addObject:iterm];
            }
            [_dataDictionary setValue:itermArray forKey:sectionTitle];
        }
    }
    return _dataDictionary;
}

@end
