//
//  BookDetailController.h
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailCollectionCell.h"
/**
 书籍详情
 */
@interface BookDetailController : UIViewController
@property (nonatomic,strong) UICollectionView *myCollection;
+ (instancetype)initWithImageName:(NSString *)imageName;
@end
