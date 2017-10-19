//
//  NormalCollectionViewCell.m
//  NormalCollectionView
//
//  Created by 曹学亮 on 2017/10/19.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import "NormalCollectionViewCell.h"

@interface NormalCollectionViewCell()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation NormalCollectionViewCell
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.tipLabel];
        self.tipLabel.frame = self.contentView.bounds;
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
        _tipLabel.font = [UIFont boldSystemFontOfSize:20];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

@end
