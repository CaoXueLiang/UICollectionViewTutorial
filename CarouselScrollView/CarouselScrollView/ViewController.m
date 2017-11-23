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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setScrollView];
}

- (void)setScrollView{
    NSArray *urlArray = @[@"http://upload-images.jianshu.io/upload_images/1714291-6c664d526b380115.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/700",@"http://upload-images.jianshu.io/upload_images/6486956-a0c75e83255105c9?imageMogr2/auto-orient/strip%7CimageView2/2/w/583",@"http://upload-images.jianshu.io/upload_images/3580598-482508548410c111.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    _horScrollView = [[CarouselScrollView alloc]initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 200)];
    _horScrollView.imageArray = urlArray;
    _horScrollView.delegate = self;
    [self.view addSubview:_horScrollView];
    
}

#pragma mark - CarouselScrollViewDelegate
- (void)didSelectedIndex:(NSInteger)index{
    NSLog(@"点击了第%ld个",index);
}

@end
