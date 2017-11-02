//
//  InspirationCell.m
//  ParallaxCustomLayout
//
//  Created by bjovov on 2017/11/2.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "InspirationCell.h"
#import "InspirationModel.h"

@interface InspirationCell()
@property (nonatomic,strong) UIImageView *backImageView;
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
    [self.contentView addSubview:self.backImageView];
    self.backImageView.frame = self.contentView.bounds;
}

- (void)setModel:(InspirationModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.backImageView.image = [UIImage imageNamed:_model.Background];
}

#pragma mark - Setter && Getter
- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}

@end
