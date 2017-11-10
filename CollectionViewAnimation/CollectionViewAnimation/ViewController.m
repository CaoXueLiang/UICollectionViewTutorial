//
//  ViewController.m
//  CollectionViewAnimation
//
//  Created by bjovov on 2017/11/10.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ViewController.h"
#import "NormalTableViewCell.h"
#import <Masonry/Masonry.h>
#import "AnimationCollectionController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *mytable;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.mytable];
    [self.mytable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalTableViewCell" forIndexPath:indexPath];
    [cell setTip:self.dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.mytable deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AnimationCollectionController *controller = [[AnimationCollectionController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Setter && Getter
- (UITableView *)mytable{
    if (!_mytable) {
        _mytable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_mytable registerClass:[NormalTableViewCell class] forCellReuseIdentifier:@"NormalTableViewCell"];
        _mytable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mytable.dataSource = self;
        _mytable.delegate = self;
        _mytable.tableFooterView = [UIView new];
    }
    return _mytable;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"CollectionView插入/删除动画"];
    }
    return _dataArray;
}

@end
