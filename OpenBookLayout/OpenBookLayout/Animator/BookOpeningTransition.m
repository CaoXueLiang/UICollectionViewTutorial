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

#pragma mark - Private Menthod
- (CATransform3D)makePerspectiveTransform{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/2000;
    return transform;
}

/*状态一:book关闭的状态*/
- (void)closePageCell:(UICollectionViewCell *)pageCell{
    CATransform3D transform = [self makePerspectiveTransform];
    if (pageCell.layer.anchorPoint.x == 0) {
        //右侧page
        transform = CATransform3DRotate(transform, 0, 0, 1, 0);
        transform = CATransform3DTranslate(transform, -0.7 * pageCell.layer.bounds.size.width/2.0, 0, 0);
        transform = CATransform3DScale(transform, 0.7, 0.7, 1);
    }else{
        //左侧page
        transform = CATransform3DRotate(transform, -M_PI, 0, 1, 0);
        transform = CATransform3DTranslate(transform, 0.7 * pageCell.layer.bounds.size.width/2.0, 0, 0);
        transform = CATransform3DScale(transform, 0.7, 0.7, 1);
    }
    pageCell.layer.transform = transform;
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

- (void)

@end

