//
//  PinterestLauout.h
//  PinterestLayout
//
//  Created by bjovov on 2017/10/20.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PinterestLauoutDelegate <NSObject>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface PinterestLauout : UICollectionViewLayout
@property (nonatomic,weak) id<PinterestLauoutDelegate> delegate;
@end
