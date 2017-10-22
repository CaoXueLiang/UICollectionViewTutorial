//
//  CollectionHeaderFooter.m
//  WaterFlowDemo
//
//  Created by 曹学亮 on 2017/10/22.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "CollectionHeaderFooter.h"
#import <Masonry/Masonry.h>

@interface CollectionHeaderFooter()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation CollectionHeaderFooter
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}

- (void)setTip:(NSString *)tip{
    self.tipLabel.text = tip;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.font = [UIFont systemFontOfSize:18];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end
