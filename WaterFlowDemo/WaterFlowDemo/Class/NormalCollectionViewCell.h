//
//  NormalCollectionViewCell.h
//  WaterFlowDemo
//
//  Created by 曹学亮 on 2017/10/22.
//  Copyright © 2017年 曹学亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhotoModel;
@interface NormalCollectionViewCell : UICollectionViewCell
- (void)setModel:(PhotoModel *)model layout:(UICollectionViewLayout *)layout;
+ (CGSize)sizeWithModel:(PhotoModel*)model layout:(UICollectionViewLayout *)layout;
@end
