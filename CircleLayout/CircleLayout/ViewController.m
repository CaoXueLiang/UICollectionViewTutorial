//
//  ViewController.m
//  CircleLayout
//
//  Created by bjovov on 2017/10/19.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "ViewController.h"
#import "CircleLayout.h"
#import "CircleCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *myCollection;
@property (nonatomic,assign) NSUInteger cellCount;
@end

@implementation ViewController
#pragma mark - Init Menthod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"circleLayout";
    self.cellCount = 7;
    [self.view addSubview:self.myCollection];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [self.myCollection addGestureRecognizer:tap];
}

#pragma mark - Event Response
- (void)handleGesture:(UITapGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint currentPoint = [recognizer locationInView:recognizer.view];
        NSIndexPath *path = [self.myCollection indexPathForItemAtPoint:currentPoint];
        if (path) {
            self.cellCount = self.cellCount - 1;
            [self.myCollection performBatchUpdates:^{
                [self.myCollection deleteItemsAtIndexPaths:@[path]];
            } completion:^(BOOL finished) {
                
            }];
        }else{
            self.cellCount = self.cellCount + 1;
            [self.myCollection performBatchUpdates:^{
                [self.myCollection insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CircleCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        CircleLayout *layout = [[CircleLayout alloc]init];
        _myCollection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_myCollection registerClass:[CircleCollectionViewCell class] forCellWithReuseIdentifier:@"CircleCollectionViewCell"];
        _myCollection.dataSource = self;
    }
    return _myCollection;
}

@end
