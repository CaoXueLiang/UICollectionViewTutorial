//
//  BookOpeningTransition.m
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/25.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "BookOpeningTransition.h"
#import "BookListController.h"
#import "BookDetailController.h"

@interface BookOpeningTransition()
@property (nonatomic,assign) AnimationType type;
@property (nonatomic,strong) UIColor *toViewBackgroundColor;
@property (nonatomic,strong) NSMutableDictionary *transformDictionary;
@end

@implementation BookOpeningTransition
#pragma mark - Init
+ (instancetype)initWithAnimationType:(AnimationType)type{
    BookOpeningTransition *model = [[BookOpeningTransition alloc]init];
    model.type = type;
    return model;
}

- (NSMutableDictionary *)transformDictionary{
    if (!_transformDictionary) {
        _transformDictionary = [[NSMutableDictionary alloc]init];
    }
    return _transformDictionary;
}

#pragma mark - Private Menthod
/*增加透视效果*/
- (CATransform3D)makePerspectiveTransform{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/2000;
    return transform;
}

/*将bookPage设置为关闭状态*/
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

- (void)setStartPositionForPushFromVC:(BookListController *)fromVC toVC:(BookDetailController *)toVC{
    //保存fromVC的collection的背景色,toVC的collection的背景色设为nil
    self.toViewBackgroundColor = fromVC.myCollection.backgroundColor;
    toVC.myCollection.backgroundColor = nil;
    
    //将当前选中的封面cell透明度设置为0
    fromVC.selectedCell.alpha = 0;
    
    for (DetailCollectionCell *cell in toVC.myCollection.visibleCells) {
        //将每一个的page变换状态保存下来
        [self.transformDictionary setValue:[NSValue valueWithCATransform3D:cell.layer.transform] forKey:cell.tipLabel.text];
        [self closePageCell:cell];
        [cell updateShadowLayer];
        
        NSIndexPath *path = [toVC.myCollection indexPathForCell:cell];
        if (path.row == 0) {
            cell.gradientLayer.opacity = 0;
        }
    }
}

- (void)setEndPositionForPushFromVC:(BookListController *)fromVC toVC:(BookDetailController *)toVC{
    //当展示选中书籍的page时，隐藏所有的书籍封面
//    for (BookCollectionViewCell *cell in fromVC.myCollection.visibleCells) {
//        cell.alpha = 0;
//    }
    
    //将书籍的每一页设置为展开状态
    for (DetailCollectionCell *cell in toVC.myCollection.visibleCells) {
        cell.layer.transform = [self.transformDictionary[cell.tipLabel.text] CATransform3DValue];
        [cell updateShadowLayer];
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    if (self.type == AnimationTypePush) {
        BookListController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        BookDetailController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [containerView addSubview:toVC.view];
        
        //设置bookPage每一页的初始状态
        [self setStartPositionForPushFromVC:fromVC toVC:toVC];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.7 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self setEndPositionForPushFromVC:fromVC toVC:toVC];
            toVC.myCollection.backgroundColor = self.toViewBackgroundColor;
            
        } completion:^(BOOL finished) {
            /*结束动画*/
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }else if (self.type == AnimationTypePop){
        
    }
}


@end

