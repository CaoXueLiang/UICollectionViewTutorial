//
//  ViewController.m
//  CarouselScrollView
//
//  Created by bjovov on 2017/11/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ViewController.h"
#import "CarouselScrollView.h"

@interface ViewController ()<CarouselScrollViewDelegate>
@property (nonatomic,strong) CarouselScrollView *horScrollView;
@property (nonatomic,strong) CarouselScrollView *verScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setScrollView];
    [self setVerScrollView];
}

- (void)setScrollView{
    NSArray *urlArray = @[@"http://upload-images.jianshu.io/upload_images/1714291-6c664d526b380115.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700",@"http://upload-images.jianshu.io/upload_images/6486956-a0c75e83255105c9?imageMogr2/auto-orient/strip%7CimageView2/2/w/583",@"http://upload-images.jianshu.io/upload_images/3580598-482508548410c111.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    _horScrollView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 50, CGRectGetWidth(self.view.bounds), 200)];
    _horScrollView.imageArray = urlArray;
    _horScrollView.delegate = self;
    [self.view addSubview:_horScrollView];
}

- (void)setVerScrollView{
    NSArray *imageArray = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"2"]];
    _verScrollView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 200)];
    _verScrollView.imageArray = imageArray;
    _verScrollView.delegate = self;
    _verScrollView.direction = UICollectionViewScrollDirectionVertical;
    [self.view addSubview:_verScrollView];
}

#pragma mark - CarouselScrollViewDelegate
- (void)didSelectedIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个",index);
}

@end
