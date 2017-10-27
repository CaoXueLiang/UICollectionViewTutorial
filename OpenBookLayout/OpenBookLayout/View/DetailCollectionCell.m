//
//  DetailCollectionCell.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "DetailCollectionCell.h"
#import <Masonry/Masonry.h>
#import "UIImage+Helper.h"
#import "UIView+Cliper.h"

@interface DetailCollectionCell()
@property (nonatomic,strong) UIImageView *bookImageView;
/*是否是右侧的page*/
@property (nonatomic,assign) BOOL isRightPage;
@end

@implementation DetailCollectionCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addSubViews];
        //反锯齿
        self.layer.allowsEdgeAntialiasing = YES;
        self.bookImageView.layer.allowsEdgeAntialiasing = YES;
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.bookImageView];
    self.bookImageView.frame = self.contentView.bounds;
    
    [self.contentView addSubview:self.tipLabel];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(8);
        make.right.equalTo(self.contentView).offset(-8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.height.mas_equalTo(20);
    }];
    
    self.gradientLayer.frame = self.bookImageView.bounds;
    [self.bookImageView.layer addSublayer:self.gradientLayer];
}

- (void)setImageName:(NSString *)imageName row:(NSInteger)index{
    UIImage *image = [UIImage imageNamed:imageName];
    if (_isRightPage) {
        [self.bookImageView clipWithCorners:UIRectCornerBottomRight | UIRectCornerTopRight radius:20];
        image = [image imageWithRoundedCornerRadius:60 corners:UIRectCornerBottomRight | UIRectCornerTopRight];
    }else{
        [self.bookImageView clipWithCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft radius:20];
        image = [image imageWithRoundedCornerRadius:60 corners:UIRectCornerTopLeft | UIRectCornerBottomLeft];
    }
    self.bookImageView.image = image;
    self.tipLabel.text = [NSString stringWithFormat:@"%ld",index];
    self.tipLabel.hidden = index > 0 ? NO : YES;
}

/*
 对于自定义的属性anchorPoint，必须手动实现这个方法
 */
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    //改变锚点(改变锚点会影响center的位置 参考http://www.jianshu.com/p/15f007f40209 )
    if (layoutAttributes.indexPath.item % 2 == 0) {
        self.layer.anchorPoint = CGPointMake(0, 0.5);
        _isRightPage = YES;
    }else{
        self.layer.anchorPoint = CGPointMake(1, 0.5);
        _isRightPage = NO;
    }
    [self updateShadowLayer];
}

- (CGFloat)getRatioFromTransform{
    CGFloat ratio = 0;
    CGFloat rotationY = [[self.layer valueForKeyPath:@"transform.rotation.y"] floatValue];
    if (_isRightPage) {
        ratio = 1 - rotationY / -M_PI_2;
    }else{
        ratio = -(1 - rotationY / (M_PI_2));
    }
    return ratio;
}

- (void)updateShadowLayer{
    CGFloat inverseRatio = 1 - (ABS([self getRatioFromTransform]));
    if (_isRightPage) {
        //右侧page
        self.gradientLayer.colors = @[
              (__bridge id)[[UIColor darkGrayColor]colorWithAlphaComponent:0.45 *inverseRatio].CGColor,
              (__bridge id)[[UIColor darkGrayColor]colorWithAlphaComponent:0.40*inverseRatio].CGColor,
              (__bridge id)[[UIColor darkGrayColor]colorWithAlphaComponent:0.55*inverseRatio].CGColor];
        self.gradientLayer.locations = @[@0.00,@0.02,@1.00];
    }else{
        //左侧page
        self.gradientLayer.colors = @[
              (__bridge id)[[UIColor darkGrayColor]colorWithAlphaComponent:0.3*inverseRatio].CGColor,
              (__bridge id)[[UIColor darkGrayColor]colorWithAlphaComponent:0.4*inverseRatio].CGColor,
              (__bridge id)[[UIColor darkGrayColor]colorWithAlphaComponent:0.5*inverseRatio].CGColor,
              (__bridge id)[[UIColor darkGrayColor]colorWithAlphaComponent:0.55*inverseRatio].CGColor];
        self.gradientLayer.locations = @[@0.00,@0.50,@0.98,@1.00];
    }
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

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor redColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc]init];
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0.5);
    }
    return _gradientLayer;
}

@end

