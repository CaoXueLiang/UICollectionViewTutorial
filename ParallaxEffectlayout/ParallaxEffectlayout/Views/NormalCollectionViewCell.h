//
//  NormalCollectionViewCell.h
//  ParallaxEffectlayout
//
//  Created by bjovov on 2017/11/7.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InspirationModel;
@interface NormalCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) InspirationModel *model;
- (void)parallaxOffsetForCollectionBounds:(CGRect)collectionBounds;
@end
