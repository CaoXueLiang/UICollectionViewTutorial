//
//  NormalPhotoCell.m
//  PinterestLayout
//
//  Created by bjovov on 2017/10/20.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "NormalPhotoCell.h"
#import "Masonry.h"
#import "PhotoModel.h"

@interface NormalPhotoCell()
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIImageView *photoImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@end

@implementation NormalPhotoCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    [self.contentView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.containerView addSubview:self.photoImageView];
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.containerView);
    }];
    
    [self.containerView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(4);
        make.right.equalTo(self.containerView).offset(-4);
        make.top.equalTo(self.photoImageView.mas_bottom).offset(10);
    }];
    
    [self.containerView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(4);
        make.right.equalTo(self.containerView).offset(-4);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
        make.bottom.equalTo(self.containerView).offset(-10);
    }];
}

#pragma mark - Public Menthod
- (void)setModel:(PhotoModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.photoImageView.image = [UIImage imageNamed:_model.imageName];
    self.titleLabel.text = _model.title;
    self.detailLabel.text = _model.detail;
}

#pragma mark - Setter && Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor colorWithRed:41/255.0 green:87/255.0 blue:43/255.0 alpha:1];
        _containerView.layer.cornerRadius = 6;
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}

- (UIImageView *)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _photoImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = [UIColor whiteColor];
    }
    return _detailLabel;
}

@end

