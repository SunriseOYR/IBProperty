//
//  UILabel+ORIBProperty.h
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/8.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (ORIBProperty)


/*
 * 给文字添加 下划线
 * add a underline for text
 */
@property (nonatomic, assign) IBInspectable BOOL ib_underLine;

/*
 * 给文字添加中间横线
 * add a middleLine for text
 */
@property (nonatomic, assign) IBInspectable BOOL ib_middleLine;



@end
