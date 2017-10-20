//
//  ReusableView.m
//  NormalCollectionView
//
//  Created by bjovov on 2017/10/20.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "ReusableView.h"

@interface ReusableView()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation ReusableView
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tipLabel];
        self.tipLabel.frame = self.bounds;
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
        _tipLabel.font = [UIFont systemFontOfSize:20];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}
@end
