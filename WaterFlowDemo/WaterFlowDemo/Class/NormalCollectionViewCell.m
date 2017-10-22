//
//  NormalCollectionViewCell.m
//  WaterFlowDemo
//
//  Created by 曹学亮 on 2017/10/22.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "NormalCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "PhotoModel.h"
#import "CHTCollectionViewWaterfallLayout.h"

#define LabelHeight 20
@interface NormalCollectionViewCell()
@property (nonatomic,strong) UIImageView *topImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@end

@implementation NormalCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.topImageView];
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.topImageView.mas_bottom);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(LabelHeight);
    }];
}

#pragma mark - Public Menthod
- (void)setModel:(PhotoModel *)model layout:(UICollectionViewLayout *)layout{
    if (!model) {
        return;
    }
    UIImage *image = [UIImage imageNamed:model.imageName];
    self.topImageView.image = image;
    self.titleLabel.text = @"标题";
    self.detailLabel.text = @"detaildetaildetail";
    
    UIInterfaceOrientation Orientation = [UIApplication sharedApplication].statusBarOrientation;
    CHTCollectionViewWaterfallLayout *currentLayout = (CHTCollectionViewWaterfallLayout *)layout;
    CGFloat width = Orientation == UIInterfaceOrientationPortrait ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
    CGFloat cellWidth = (width - (currentLayout.columnCount - 1) *currentLayout.minimumColumnSpacing - currentLayout.sectionInset.left - currentLayout.sectionInset.right)/currentLayout.columnCount;
    CGFloat cellHeight = cellWidth * (image.size.height/image.size.width);
    
    //更新约束
    [self.topImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(cellHeight);
    }];
}

+ (CGSize)sizeWithModel:(PhotoModel*)model layout:(UICollectionViewLayout *)layout{
    UIInterfaceOrientation Orientation = [UIApplication sharedApplication].statusBarOrientation;
    CHTCollectionViewWaterfallLayout *currentLayout = (CHTCollectionViewWaterfallLayout *)layout;
    CGFloat width = Orientation == UIInterfaceOrientationPortrait ? [UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height;
    CGFloat cellWidth = (width - (currentLayout.columnCount - 1) *currentLayout.minimumColumnSpacing - currentLayout.sectionInset.left - currentLayout.sectionInset.right)/currentLayout.columnCount;
    UIImage *image = [UIImage imageNamed:model.imageName];
    CGFloat cellHeight = cellWidth * (image.size.height/image.size.width) + LabelHeight*2;
    return CGSizeMake(cellWidth, cellHeight);
}

#pragma mark - Setter && Getter
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]init];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topImageView.layer.masksToBounds = YES;
    }
    return _topImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
@end
