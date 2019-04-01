//
//  UIView+ORIBProperty.h
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/8.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ORIBProperty)


//shadow
@property(nonatomic, assign) IBInspectable CGSize ib_shadowOffset;
@property(nonatomic, assign) IBInspectable UIColor * ib_shadowColor;
@property(nonatomic, assign) IBInspectable CGFloat ib_shadowOpacity;
@property(nonatomic, assign) IBInspectable CGFloat ib_shadowRadius;

/*
 * 渐变开始颜色 - 渐变结束颜色
   只设置开始颜色 渐变将由alpha 0.3 - 0.1； 只设置结束颜色 渐变将由alpha 0.1 - 0.3
 
 * gradientStartColor ~ gradientEndColor
   if only gradientStartColor, grandient will do with color alpha 0.3 ~ 0.1, and if only
   gradientEndColor, grandient will do with color alpha 0.1 ~ 0.3
 */
@property(nonatomic, assign) IBInspectable UIColor *ib_gradientStartColor;
@property(nonatomic, assign) IBInspectable UIColor *ib_gradientEndColor;


@end
