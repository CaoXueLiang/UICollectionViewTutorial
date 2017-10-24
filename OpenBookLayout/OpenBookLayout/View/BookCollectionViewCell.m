//
//  BookCollectionViewCell.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookCollectionViewCell.h"

@interface BookCollectionViewCell()
@property (nonatomic,strong) UIImageView *bookImageView;
@end

@implementation BookCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bookImageView];
        self.bookImageView.frame = self.contentView.bounds;
        self.bookImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName{
    self.bookImageView.image = [UIImage imageNamed:imageName];
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
