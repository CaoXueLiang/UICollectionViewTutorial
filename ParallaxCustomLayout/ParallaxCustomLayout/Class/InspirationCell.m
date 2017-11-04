//
//  InspirationCell.m
//  ParallaxCustomLayout
//
//  Created by bjovov on 2017/11/2.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "InspirationCell.h"
#import "InspirationModel.h"
#import <Masonry/Masonry.h>
#import "UIImage+Decompression.h"

@interface InspirationCell()
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeAndRoomLabel;
@property (nonatomic,strong) UILabel *speakerLabel;
@end

@implementation InspirationCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    /*必须使用自动布局，不然imageView的frame不会变化*/
    [self.contentView addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(47);
    }];
    
    [self.contentView addSubview:self.timeAndRoomLabel];
    [self.timeAndRoomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(21);
    }];
    
    [self.contentView addSubview:self.speakerLabel];
    [self.speakerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.timeAndRoomLabel.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.bottom.equalTo(self.contentView);
    }];
}

- (void)setModel:(InspirationModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.backImageView.image = [UIImage imageNamed:_model.Background];
    self.titleLabel.text = _model.Title;
    self.timeAndRoomLabel.text = [NSString stringWithFormat:@"%@ • %@",_model.Time,_model.Room];
    self.speakerLabel.text = _model.Speaker;
}

#pragma mark - OverVide  Menthod
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];

    CGFloat standardHeight = 100.0;
    CGFloat featuredHeight = 280.0;
    /*根据移动距离改变CoverView透明度*/
    CGFloat factor = 1 - (featuredHeight - CGRectGetHeight(layoutAttributes.frame))/(featuredHeight - standardHeight);
    CGFloat minAlpha = 0.2;
    CGFloat maxAlpha = 0.75;
    CGFloat currentAlpha = maxAlpha - (maxAlpha - minAlpha) * factor;
    self.coverView.alpha = currentAlpha;
    
    /*改变字体大小*/
    CGFloat titleScale = MAX(0.5, factor);
    self.titleLabel.transform = CGAffineTransformMakeScale(titleScale, titleScale);
    
    /*设置detailLabel的透明度*/
    self.timeAndRoomLabel.alpha = factor;
    self.speakerLabel.alpha = factor;
}

#pragma mark - Setter && Getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.layer.masksToBounds = YES;
    }
    return _backImageView;
}

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.75;
    }
    return _coverView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:38];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)timeAndRoomLabel{
    if (!_timeAndRoomLabel) {
        _timeAndRoomLabel = [UILabel new];
        _timeAndRoomLabel.font = [UIFont systemFontOfSize:17];
        _timeAndRoomLabel.textAlignment = NSTextAlignmentCenter;
        _timeAndRoomLabel.textColor = [UIColor whiteColor];
    }
    return _timeAndRoomLabel;
}

- (UILabel *)speakerLabel{
    if (!_speakerLabel) {
        _speakerLabel = [UILabel new];
        _speakerLabel.font = [UIFont systemFontOfSize:17];
        _speakerLabel.textColor = [UIColor whiteColor];
        _speakerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _speakerLabel;
}

@end

