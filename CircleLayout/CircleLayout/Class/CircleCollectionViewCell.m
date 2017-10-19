//
//  CircleCollectionViewCell.m
//  CircleLayout
//
//  Created by bjovov on 2017/10/19.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "CircleCollectionViewCell.h"

@interface CircleCollectionViewCell()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation CircleCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.tipLabel];
        self.tipLabel.frame = self.contentView.bounds;
        self.contentView.layer.cornerRadius = 80/2.0;
    }
    return self;
}

- (void)setTip:(NSString *)tip{
    self.tipLabel.text = tip;
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont boldSystemFontOfSize:25];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end

