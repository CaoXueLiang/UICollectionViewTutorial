//
//  CircleLayout.h
//  CircleLayout
//
//  Created by bjovov on 2017/10/19.
//  Copyright © 2017年 CaoXueLiang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout
/*中心点*/
@property (nonatomic, assign) CGPoint center;
/*半径*/
@property (nonatomic, assign) CGFloat radius;
/*cell的个数*/
@property (nonatomic, assign) NSInteger cellCount;
@end
