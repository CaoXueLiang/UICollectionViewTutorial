//
//  BookCollectionViewCell.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookCollectionViewCell.h"
#import "UIImage+Helper.h"

@interface BookCollectionViewCell()
@property (nonatomic,strong) UIImageView *bookImageView;
@end

@implementation BookCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.bookImageView];
        self.bookImageView.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    self.bookImageView.image = [image imageWithRoundedCornerRadius:50 corners:UIRectCornerBottomRight | UIRectCornerTopRight];
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

@end
