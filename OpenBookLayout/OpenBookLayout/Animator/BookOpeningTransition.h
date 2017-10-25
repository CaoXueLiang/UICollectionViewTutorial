//
//  BookOpeningTransition.h
//  OpenBookLayout
//
//  Created by bjovov on 2017/10/25.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimationType){
    AnimationTypePush,
    AnimationTypePop,
};

@interface BookOpeningTransition : NSObject<UIViewControllerAnimatedTransitioning>
+ (instancetype)initWithAnimationType:(AnimationType)type;
@end
