//
//  NormalCollectionViewCell.m
//  ParallaxEffectlayout
//
//  Created by bjovov on 2017/11/7.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "NormalCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "InspirationModel.h"

@interface NormalCollectionViewCell()
@property (nonatomic,strong) UIView *containerview;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeAndRoomLabel;
@property (nonatomic,strong) UILabel *speakerLabel;
@end

@implementation NormalCollectionViewCell
#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.containerview];
    [self.containerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(-40);
        make.right.equalTo(self.contentView).offset(40);
    }];
    
    [self.containerview addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerview.mas_centerY).offset(0);
        make.left.right.equalTo(self.containerview);
    }];
    
    [self.containerview addSubview:self.coverView];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.containerview);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-30);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(47);
    }];
    
    [self.contentView addSubview:self.timeAndRoomLabel];
    [self.timeAndRoomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_centerY).offset(10);
        make.height.mas_equalTo(21);
    }];
    
    [self.contentView addSubview:self.speakerLabel];
    [self.speakerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.timeAndRoomLabel.mas_bottom);
        make.height.mas_equalTo(20);
    }];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    
    /*让imageView不跟随cell进行旋转*/
    CGFloat angle = M_PI *(14 / 180.0);
    self.backImageView.transform = CGAffineTransformMakeRotation(angle);
}

#pragma mark - Public Menthod
- (void)setModel:(InspirationModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.backImageView.image = [[UIImage imageNamed:_model.Background] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];;
    self.titleLabel.text = _model.Title;
    self.timeAndRoomLabel.text = [NSString stringWithFormat:@"%@ • %@",_model.Time,_model.Room];
    self.speakerLabel.text = _model.Speaker;
}

- (void)parallaxOffsetForCollectionBounds:(CGRect)collectionBounds{
    //collectionView和cell的中心点
    CGRect bounds = collectionBounds;
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGPoint cellCenter = self.center;

    //找出每个cell相对于 collectionView 中心点的偏移量
    CGPoint offsetFromCenter = CGPointMake(boundsCenter.x - cellCenter.x, boundsCenter.y - cellCenter.y);

    //cell 的最大偏移量
    CGSize cellSize = self.bounds.size;

    /*offsetFromCenter.y 表示偏离中心点的距离。这就意味 collectionView 滚动一段距离，离中心点越远的 cell 对应的 parallaxOffset 的值就越大，离中心点越近的 cell 对应的 parallaxOffset 值就越小*/
    CGFloat maxVerticalOffsetWhereCellIsStillVisible = (bounds.size.height / 2) + (cellSize.height / 2);
    CGFloat scaleFactor = 40.0 / maxVerticalOffsetWhereCellIsStillVisible;

    CGPoint parallaxOffset = CGPointMake(0.0, offsetFromCenter.y * scaleFactor);

    [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerview.mas_centerY).offset(parallaxOffset.y);
    }];
}

#pragma mark - Setter && Getter
- (UIView *)containerview{
    if (!_containerview) {
        _containerview = [[UIView alloc]init];
        _containerview.backgroundColor = [UIColor orangeColor];
        _containerview.clipsToBounds = YES;
        /*图片抗锯齿http://adad184.com/2015/08/31/image-rotate-with-antialiasing/*/
        _containerview.layer.allowsEdgeAntialiasing = YES;
    }
    return _containerview;
}

- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [UIView new];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.3;
    }
    return _coverView;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _backImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)timeAndRoomLabel{
    if (!_timeAndRoomLabel) {
        _timeAndRoomLabel = [UILabel new];
        _timeAndRoomLabel.font = [UIFont systemFontOfSize:17];
        _timeAndRoomLabel.textAlignment = NSTextAlignmentCenter;
        _timeAndRoomLabel.textColor = [UIColor whiteColor];
    }
    return _timeAndRoomLabel;
}

- (UILabel *)speakerLabel{
    if (!_speakerLabel) {
        _speakerLabel = [UILabel new];
        _speakerLabel.font = [UIFont systemFontOfSize:17];
        _speakerLabel.textColor = [UIColor whiteColor];
        _speakerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _speakerLabel;
}

@end

