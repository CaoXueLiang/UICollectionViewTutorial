//
//  AppDelegate.m
//  GuidanceScrollow
//
//  Created by bjovov on 2017/11/9.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "GuideViewController.h"

@interface AppDelegate ()<GuideViewControllerDelegate>

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *controller = [[ViewController alloc]init];
    GuideViewController *guide = [[GuideViewController alloc]init];
    guide.delegate = self;
    NSString *isFirst = [[NSUserDefaults standardUserDefaults]objectForKey:@"IsFirst"];
    if (isFirst && [isFirst isEqualToString:@"N"]) {
       self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:controller];
    }else{
        self.window.rootViewController = guide;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)didClickedEnterButtonMenthod{
    ViewController *controller = [[ViewController alloc]init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:controller];
}

@end
