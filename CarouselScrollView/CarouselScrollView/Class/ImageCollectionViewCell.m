//
//  ImageCollectionViewCell.m
//  CarouselScrollView
//
//  Created by bjovov on 2017/11/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImageCollectionViewCell()
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ImageCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}

- (void)_initViews{
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
}

#pragma mark - Setter && Getter
- (void)setImageURL:(NSString *)imageURL{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"tmp"]];
}

- (void)setImage:(UIImage *)image{
    _imageView.image = image;
}

@end
