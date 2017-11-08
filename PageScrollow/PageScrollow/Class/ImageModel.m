//
//  ImageModel.m
//  PageScrollow
//
//  Created by bjovov on 2017/11/8.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel
+ (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    ImageModel *model = [[ImageModel alloc]init];
    model.imageName = dictionary[@"imageName"];
    model.tip = dictionary[@"tip"];
    return model;
}

@end

