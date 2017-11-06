//
//  HeaderView.m
//  StickyHeadersLayout
//
//  Created by bjovov on 2017/11/6.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation HeaderView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tipLabel];
        self.tipLabel.frame = self.bounds;
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)setTip:(NSString *)tip{
    self.tipLabel.text = tip;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont boldSystemFontOfSize:20];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end

