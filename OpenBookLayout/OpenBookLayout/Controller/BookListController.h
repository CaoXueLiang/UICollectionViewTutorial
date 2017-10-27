//
//  BookListController.h
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/24.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookCollectionViewCell.h"

/**
 书籍列表
 */
@interface BookListController : UIViewController
@property (nonatomic,strong) UICollectionView *myCollection;
- (BookCollectionViewCell *)selectedCell;
@end
