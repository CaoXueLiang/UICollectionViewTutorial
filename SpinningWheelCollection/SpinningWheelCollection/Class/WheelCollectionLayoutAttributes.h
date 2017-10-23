//
//  WheelCollectionLayoutAttributes.h
//  SpinningWheelCollection
//
//  Created by bjovov on 2017/10/23.
//  Copyright © 2017年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelCollectionLayoutAttributes : UICollectionViewLayoutAttributes
/**锚点的位置 */
@property (nonatomic,assign) CGPoint anchorPoint;
/*item旋转的角度*/
@property (nonatomic,assign) CGFloat angle;
@end
