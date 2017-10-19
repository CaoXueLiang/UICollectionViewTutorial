//
//  LineCollectionViewCell.m
//  LineLayout
//
//  Created by bjovov on 2017/10/19.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import "LineCollectionViewCell.h"

@interface LineCollectionViewCell()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation LineCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.tipLabel];
        self.tipLabel.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setTip:(NSString *)tip{
    self.tipLabel.text = tip;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.font = [UIFont boldSystemFontOfSize:50];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end

