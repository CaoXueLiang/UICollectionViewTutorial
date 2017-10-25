//
//  BookOpeningTransition.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/25.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookOpeningTransition.h"

@interface BookOpeningTransition()
@property (nonatomic,assign) AnimationType type;
@end

@implementation BookOpeningTransition
#pragma mark - Init
+ (instancetype)initWithAnimationType:(AnimationType)type{
    BookOpeningTransition *model = [[BookOpeningTransition alloc]init];
    model.type = type;
    return model;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取from和to相关视图
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    if (self.type == AnimationTypePush) {
        
    }else if (self.type == AnimationTypePop){
        
    }
}

@end

