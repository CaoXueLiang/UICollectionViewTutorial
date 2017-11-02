//
//  InspirationModel.m
//  ParallaxCustomLayout
//
//  Created by bjovov on 2017/11/2.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "InspirationModel.h"

@implementation InspirationModel
+ (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    InspirationModel *model = [[InspirationModel alloc]init];
    model.Title = dictionary[@"Title"];
    model.Speaker = dictionary[@"Speaker"];
    model.Room = dictionary[@"Room"];
    model.Time = dictionary[@"Time"];
    model.Background = dictionary[@"Background"];
    return model;
}

@end
