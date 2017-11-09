//
//  ImageCollectionViewCell.h
//  GuidanceScrollow
//
//  Created by bjovov on 2017/11/9.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageCollectionViewCellDelegate <NSObject>
- (void)didClickedEnterButton;
@end

@interface ImageCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) id<ImageCollectionViewCellDelegate> delegate;
- (void)setImage:(NSString *)imageName enterButtonIsHiden:(BOOL)hiden;
@end
