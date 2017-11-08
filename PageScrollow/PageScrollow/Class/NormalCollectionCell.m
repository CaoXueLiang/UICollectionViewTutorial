//
//  NormalCollectionCell.m
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "NormalCollectionCell.h"
#import "ImageModel.h"
#import <Masonry/Masonry.h>

//选择iPhone 6作为基准尺寸
#define kScaleFrom_iPhone6_Desgin(_X_) (_X_ * ([UIScreen mainScreen].bounds.size.width/375.0))
@interface NormalCollectionCell()
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation NormalCollectionCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    CGFloat margin = kScaleFrom_iPhone6_Desgin(65) - (kScaleFrom_iPhone6_Desgin(65) + kScaleFrom_iPhone6_Desgin(25))/2.0;
    [self.contentView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(margin);
        make.size.mas_equalTo(CGSizeMake(kScaleFrom_iPhone6_Desgin(65), kScaleFrom_iPhone6_Desgin(65)));
    }];
    
    [self.contentView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.logoImageView.mas_bottom);
        make.height.mas_equalTo(kScaleFrom_iPhone6_Desgin(25));
    }];
}

- (void)setModel:(ImageModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.logoImageView.image = [UIImage imageNamed:_model.imageName];
    self.tipLabel.text = _model.tip;
}

#pragma mark - Setter && Getter
- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
    }
    return _logoImageView;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end

