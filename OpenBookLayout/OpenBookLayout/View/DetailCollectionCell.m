//
//  DetailCollectionCell.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "DetailCollectionCell.h"
#import <Masonry/Masonry.h>

@interface DetailCollectionCell()
@property (nonatomic,strong) UIImageView *bookImageView;
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation DetailCollectionCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.bookImageView];
    [self.bookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.height.mas_equalTo(20);
    }];
}

- (void)setImageName:(NSString *)imageName row:(NSInteger)index{
    self.bookImageView.image = [UIImage imageNamed:imageName];
    self.tipLabel.text = [NSString stringWithFormat:@"%ld",index];
    self.tipLabel.hidden = index > 0 ? NO : YES;
}

#pragma mark - Setter && Getter
- (UIImageView *)bookImageView{
    if (!_bookImageView) {
        _bookImageView = [[UIImageView alloc]init];
        _bookImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bookImageView.layer.masksToBounds = YES;
    }
    return _bookImageView;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end

