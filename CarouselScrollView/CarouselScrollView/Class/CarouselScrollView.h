//
//  CarouselScrollView.h
//  CarouselScrollView
//
//  Created by bjovov on 2017/11/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarouselScrollViewDelegate <NSObject>
- (void)didSelectedIndex:(NSInteger)index;
@end

@interface CarouselScrollView : UIView
@property (nonatomic,weak) id<CarouselScrollViewDelegate> delegate;
/**滚动方向，默认是横向滚动*/
@property (nonatomic,assign) UICollectionViewScrollDirection direction;
/**是否无限循环，默认是YES*/
@property (nonatomic,assign) BOOL isinFiniteLoop;
/**是否自动滚动，默认是YES*/
@property (nonatomic,assign) BOOL isAutoScroll;
/**网络图片地址数组 或 本地图片数组*/
@property (nonatomic,strong) NSArray *imageArray;
@end
