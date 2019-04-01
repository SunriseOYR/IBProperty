//
//  UILabel+ORIBPropertyBasis.h
//  Aspects
//
//  Created by 欧阳荣 on 2019/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ORIBPropertyBasis)

/*
 * 根据屏幕的宽度 适配 字体大小
 * adapt font size by screen width
 */
@property (nonatomic, assign) IBInspectable BOOL ib_adaptFont;

@end

NS_ASSUME_NONNULL_END
