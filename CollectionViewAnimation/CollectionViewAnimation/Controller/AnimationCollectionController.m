//
//  AnimationCollectionController.m
//  CollectionViewAnimation
//
//  Created by bjovov on 2017/11/10.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "AnimationCollectionController.h"
#import "NormalCollectionViewCell.h"
#import "AnimationEditeLayout.h"
#import <Masonry/Masonry.h>
#import "DetailViewController.h"

@interface AnimationCollectionController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,assign) BOOL isBigLayout;
/*section个数*/
@property (nonatomic,assign) NSInteger sectionCount;
/*section中对应的Iterms个数*/
@property (nonatomic,strong) NSMutableArray *itermCounts;
/*捏合手势*/
@property (nonatomic,strong) UIPinchGestureRecognizer *recognizer;
@end

@implementation AnimationCollectionController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.sectionCount = 3;
    self.itermCounts = [NSMutableArray arrayWithArray:@[@100,@60,@60]];
    [self addNavigation];
    [self.view addSubview:self.myCollection];
    [self.myCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    //添加手势
    [self addGesture];
}

- (void)addNavigation{
    self.navigationItem.title = @"首页";
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchIterm)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addIterm)];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteIterm)];
    self.navigationItem.rightBarButtonItems = @[searchButton,addButton,deleteButton];
}

- (void)addGesture{
    self.recognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [self.myCollection addGestureRecognizer:self.recognizer];
}

#pragma mark - Event Response
- (void)searchIterm{
    if (self.isBigLayout) {
        AnimationEditeLayout *layout = [[AnimationEditeLayout alloc]init];
        layout.itemSize = CGSizeMake(50, 50);
        [self.myCollection setCollectionViewLayout:layout animated:YES];
    }else{
        AnimationEditeLayout *layout = [[AnimationEditeLayout alloc]init];
        layout.itemSize = CGSizeMake(200, 200);
        [self.myCollection setCollectionViewLayout:layout animated:YES];
    }
    self.isBigLayout = !self.isBigLayout;
}

- (void)addIterm{
    //获取要插入的随机的section索引，和indexpath.iterm索引
    int insertSectionIndex = arc4random() % self.sectionCount;
    int insertItermIndex = arc4random() % ([self.itermCounts[insertSectionIndex] intValue] + 1);
    
    //更新数据源
    self.itermCounts[insertSectionIndex] = @([self.itermCounts[insertSectionIndex] integerValue] + 1);
    [self.myCollection performBatchUpdates:^{
        [self.myCollection insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:insertItermIndex inSection:insertSectionIndex]]];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)deleteIterm{
    //获取要插入的随机的section索引，和indexpath.iterm索引
    int insertSectionIndex = arc4random() % self.sectionCount;
    int insertItermIndex = arc4random() % ([self.itermCounts[insertSectionIndex] intValue]);
    
    //更新数据源
    self.itermCounts[insertSectionIndex] = @([self.itermCounts[insertSectionIndex] integerValue] - 1);
    [self.myCollection performBatchUpdates:^{
        [self.myCollection deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:insertItermIndex inSection:insertSectionIndex]]];
    } completion:^(BOOL finished) {
        
    }];
}

/*
 这个捏合操作需要计算捏合距离并找出被捏合的元素，并且在用户捏合的时候通知布局以实现自身更新。
 当捏合手势结束的时候，布局会做一个批量更新动画返回原始尺寸。
 */
- (void)pinch:(UIPinchGestureRecognizer *)recognizer{
    if (recognizer.numberOfTouches != 2) {
        return;
    }
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        //获取捏合的起始点的两个位置
        CGPoint startPoint1 = [recognizer locationOfTouch:0 inView:self.myCollection];
        CGPoint startPoint2 = [recognizer locationOfTouch:1 inView:self.myCollection];
        
        //计算两个点之间的距离
        CGFloat xd = startPoint2.x - startPoint1.x;
        CGFloat yd = startPoint2.y - startPoint1.y;
        CGFloat distance = sqrt(xd*xd + yd*yd);
        
        //根据移动距离更新约束
        AnimationEditeLayout *layout = (AnimationEditeLayout *)[self.myCollection collectionViewLayout];
        NSIndexPath *pinchIndexPath = [self.myCollection indexPathForItemAtPoint:CGPointMake(0.5*(startPoint1.x + startPoint2.x), 0.5*(startPoint2.y + startPoint2.y))];
        [layout resizeItemAtIndexPath:pinchIndexPath withPinchDistance:distance];
        [layout invalidateLayout];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged || recognizer.state == UIGestureRecognizerStateEnded){
        AnimationEditeLayout *layout = (AnimationEditeLayout *)[self.myCollection collectionViewLayout];
        [self.myCollection performBatchUpdates:^{
            [layout resetPinchedItem];
        } completion:nil];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.itermCounts[section] integerValue];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NormalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NormalCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.contentView.backgroundColor = [UIColor redColor];
    }else if (indexPath.section == 1){
        cell.contentView.backgroundColor = [UIColor greenColor];
    }else if (indexPath.section == 2){
        cell.contentView.backgroundColor = [UIColor blueColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.myCollection deselectItemAtIndexPath:indexPath animated:YES];
    NSInteger count = [self.itermCounts[indexPath.section] integerValue];;
    UIColor *currentColor;
    if (indexPath.section == 0) {
        currentColor = [UIColor redColor];
    }else if (indexPath.section == 1){
        currentColor = [UIColor greenColor];
    }else if (indexPath.section == 2){
        currentColor = [UIColor blueColor];
    }
    DetailViewController *controller = [DetailViewController initWithItermCount:count color:currentColor selectedIterm:indexPath];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        AnimationEditeLayout *layout = [[AnimationEditeLayout alloc]init];
        _myCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [_myCollection registerClass:[NormalCollectionViewCell class] forCellWithReuseIdentifier:@"NormalCollectionViewCell"];
        _myCollection.dataSource = self;
        _myCollection.delegate = self;
    }
    return _myCollection;
}

@end

