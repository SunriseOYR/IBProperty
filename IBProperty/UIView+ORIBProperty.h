//
//  UIView+ORIBProperty.h
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/8.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (ORIBProperty)

//border
@property(nonatomic, assign) IBInspectable CGFloat ib_borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *ib_borderColor;

//cornerRadius
@property(nonatomic, assign) IBInspectable CGFloat ib_cornerRadius;

//视图的 ib_cornerRadius 始终保持高度的一半
@property (nonatomic, assign) IBInspectable BOOL ib_cornerCircle;

//shadow
@property(nonatomic, assign) IBInspectable CGSize ib_shadowOffset;
@property(nonatomic, assign) IBInspectable UIColor * ib_shadowColor;
@property(nonatomic, assign) IBInspectable CGFloat ib_shadowOpacity;
@property(nonatomic, assign) IBInspectable CGFloat ib_shadowRadius;


@end
