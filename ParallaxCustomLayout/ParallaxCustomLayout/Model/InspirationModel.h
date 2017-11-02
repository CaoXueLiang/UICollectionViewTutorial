//
//  InspirationModel.h
//  ParallaxCustomLayout
//
//  Created by bjovov on 2017/11/2.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InspirationModel : NSObject
@property (nonatomic,copy) NSString *Title;
@property (nonatomic,copy) NSString *Speaker;
@property (nonatomic,copy) NSString *Room;
@property (nonatomic,copy) NSString *Time;
@property (nonatomic,copy) NSString *Background;

+ (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
