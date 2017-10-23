//
//  WheelCollectionLayoutAttributes.m
//  SpinningWheelCollection
//
//  Created by bjovov on 2017/10/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import "WheelCollectionLayoutAttributes.h"

@implementation WheelCollectionLayoutAttributes
- (instancetype)init{
    self = [super init];
    if (self) {
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.angle = 0;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    WheelCollectionLayoutAttributes *attribute = [super copyWithZone:zone];
    attribute.anchorPoint = self.anchorPoint;
    attribute.angle = self.angle;
    return attribute;
}

@end
