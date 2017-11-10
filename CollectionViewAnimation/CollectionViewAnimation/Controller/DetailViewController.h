//
//  DetailViewController.h
//  CollectionViewAnimation
//
//  Created by bjovov on 2017/11/10.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
+ (instancetype)initWithItermCount:(NSInteger)count color:(UIColor*)color selectedIterm:(NSIndexPath *)indexPath;
@end
