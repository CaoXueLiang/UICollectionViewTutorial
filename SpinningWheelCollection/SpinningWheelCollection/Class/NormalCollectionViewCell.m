//
//  NormalCollectionViewCell.m
//  SpinningWheelCollection
//
//  Created by bjovov on 2017/10/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "NormalCollectionViewCell.h"
#import "WheelCollectionLayoutAttributes.h"

@interface NormalCollectionViewCell()
@property (nonatomic,strong) UIImageView *bookImageView;
@end

@implementation NormalCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.bookImageView];
        self.bookImageView.frame = self.contentView.bounds;
        self.bookImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)setImageName:(NSString *)imageName{
    self.bookImageView.image = [UIImage imageNamed:imageName];
}

/*
 对于自定义的属性，anchorPoint必须手动实现这个方法
 */
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    //改变锚点(改变锚点会影响center的位置 参考http://www.jianshu.com/p/15f007f40209 )
    WheelCollectionLayoutAttributes *attribute = (WheelCollectionLayoutAttributes*)layoutAttributes;
    self.layer.anchorPoint = attribute.anchorPoint;
    CGFloat centerY = (attribute.anchorPoint.y - 0.5)*CGRectGetHeight(self.bounds);
    self.center = CGPointMake(self.center.x, centerY + self.center.y);
}

#pragma mark - Setter && Getter
- (UIImageView *)bookImageView{
    if (!_bookImageView) {
        _bookImageView = [[UIImageView alloc]init];
        _bookImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bookImageView.layer.cornerRadius = 6;
        _bookImageView.layer.borderColor = [UIColor blackColor].CGColor;
        _bookImageView.layer.borderWidth = 1;
        _bookImageView.layer.masksToBounds = YES;
    }
    return _bookImageView;
}
@end
