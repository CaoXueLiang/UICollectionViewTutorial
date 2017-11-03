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
}

#pragma mark - OverVide  Menthod
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];

    CGFloat standardHeight = 100.0;
    CGFloat featuredHeight = 280.0;
    /*根据移动距离改变透明度*/
    CGFloat factor = 1 - (featuredHeight - CGRectGetHeight(layoutAttributes.frame))/(featuredHeight - standardHeight);
    CGFloat minAlpha = 0.2;
    CGFloat maxAlpha = 0.7;
    CGFloat currentAlpha = maxAlpha - (maxAlpha - minAlpha) * factor;
    self.coverView.alpha = currentAlpha;
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
        _coverView.alpha = 0.7;
    }
    return _coverView;
}

@end

