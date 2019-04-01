//
//  UIView+IBPropertyBasis.h
//  Aspects
//
//  Created by 欧阳荣 on 2019/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (IBPropertyBasis)

//border
@property(nonatomic, assign) IBInspectable CGFloat ib_borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *ib_borderColor;

//cornerRadius
@property(nonatomic, assign) IBInspectable CGFloat ib_cornerRadius;

//视图的 ib_cornerRadius 始终保持高度的一半
@property (nonatomic, assign) IBInspectable BOOL ib_cornerCircle;



@end

NS_ASSUME_NONNULL_END
