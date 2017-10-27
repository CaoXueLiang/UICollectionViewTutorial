//
//  BookListController.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookListController.h"
#import "BookLayout.h"
#import "BookDetailController.h"
#import "BookOpeningTransition.h"

@interface BookListController ()<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate>
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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - Public
/*获取当前选中的cell*/
- (BookCollectionViewCell *)selectedCell{
    NSIndexPath *indexPath = [self.myCollection indexPathForItemAtPoint:CGPointMake(self.myCollection.contentOffset.x + CGRectGetWidth(self.myCollection.bounds)/2.0, CGRectGetHeight(self.myCollection.bounds)/2.0)];
    if ([self.myCollection cellForItemAtIndexPath:indexPath]) {
        BookCollectionViewCell *cell = (BookCollectionViewCell *)[self.myCollection cellForItemAtIndexPath:indexPath];
        return cell;
    }else{
        return nil;
    }
}

- (void)openBookWithController:(BookDetailController *)controller{
    [controller.view snapshotViewAfterScreenUpdates:YES];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:controller animated:YES];
        return ;
    });
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
    [self openBookWithController:controller];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return nil;
        //[BookOpeningTransition initWithAnimationType:AnimationTypePush];
    }else{
        return nil;
    }
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

