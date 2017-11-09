//
//  GuideViewController.h
//  GuidanceScrollow
//
//  Created by bjovov on 2017/11/9.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideViewControllerDelegate <NSObject>
- (void)didClickedEnterButtonMenthod;
@end

/**
 引导页
 */
@interface GuideViewController : UIViewController
@property (nonatomic,weak) id<GuideViewControllerDelegate> delegate;
@end
