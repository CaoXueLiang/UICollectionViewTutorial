//
//  ImageCollectionViewCell.m
//  GuidanceScrollow
//
//  Created by bjovov on 2017/11/9.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell()
@property (nonatomic,strong) UIImageView *normalImageView;
@property (nonatomic,strong) UIButton *enterButton;
@end

@implementation ImageCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.normalImageView];
    [self.contentView addSubview:self.enterButton];
    self.enterButton.frame = CGRectMake(CGRectGetWidth(self.bounds)/2.0 - 50, CGRectGetHeight(self.bounds) - 100, 100, 45);
}

- (void)setImage:(NSString *)imageName enterButtonIsHiden:(BOOL)hiden{
    self.normalImageView.image = [UIImage imageNamed:imageName];
    self.enterButton.hidden = hiden;
}

#pragma mark - Event Response
- (void)enterButtonClicked{
    if ([self.delegate respondsToSelector:@selector(didClickedEnterButton)]) {
        [self.delegate didClickedEnterButton];
    }
}

#pragma mark - Setter && Getter
- (UIImageView *)normalImageView{
    if (!_normalImageView) {
        _normalImageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _normalImageView.contentMode = UIViewContentModeScaleAspectFill;
        _normalImageView.clipsToBounds = YES;
    }
    return _normalImageView;
}

- (UIButton *)enterButton{
    if (!_enterButton) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_enterButton setTitle:@"立即体验" forState:UIControlStateNormal];
        [_enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _enterButton.backgroundColor = [UIColor blueColor];
        _enterButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _enterButton.hidden = YES;
        [_enterButton addTarget:self action:@selector(enterButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}
@end
