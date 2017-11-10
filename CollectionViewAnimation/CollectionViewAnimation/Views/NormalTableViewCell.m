//
//  NormalTableViewCell.m
//  CollectionViewAnimation
//
//  Created by bjovov on 2017/11/10.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "NormalTableViewCell.h"
#import <Masonry/Masonry.h>

@interface NormalTableViewCell()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation NormalTableViewCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setTip:(NSString *)tip{
    self.tipLabel.text = tip;
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.textColor = [UIColor blackColor];
    }
    return _tipLabel;
}

@end
