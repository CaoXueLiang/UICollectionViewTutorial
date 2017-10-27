//
//  DetailCollectionCell.h
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
- (void)setImageName:(NSString *)imageName row:(NSInteger)index;
- (void)updateShadowLayer;
@end
