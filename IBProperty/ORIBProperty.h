//
//  ORIBProperty.h
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/8.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#ifndef ORIBProperty_h
#define ORIBProperty_h

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "Aspects.h"

#define IB_PROPORTION  [UIScreen mainScreen].bounds.size.width / 375.f
#define IB_HP(x)     x * IB_PROPORTION

#ifndef IB_WEAKIFY
#if DEBUG
#if __has_feature(objc_arc)
#define IB_WEAKIFY(object) __weak __typeof__(object) weak##_##object = object
#else
#define IB_WEAKIFY(object) __block __typeof__(object) block##_##object = object
#endif
#else
#if __has_feature(objc_arc)
#define IB_WEAKIFY(object) __weak __typeof__(object) weak##_##object = object
#else
#define IB_WEAKIFY(object) __block __typeof__(object) block##_##object = object
#endif
#endif
#endif

#ifndef IB_STRONGIFY
#if DEBUG
#if __has_feature(objc_arc)
#define IB_STRONGIFY(object) __typeof__(object) object = weak##_##object
#else
#define IB_STRONGIFY(object) __typeof__(object) object = block##_##object
#endif
#else
#if __has_feature(objc_arc)
#define IB_STRONGIFY(object) __typeof__(object) object = weak##_##object
#else
#define IB_STRONGIFY(object) __typeof__(object) object = block##_##object
#endif
#endif
#endif

#endif /* ORIBProperty_h */


//adapt font
static inline UIFont * ib_fontAdaptWithFont(UIFont *font) {
    
    UIFontDescriptor *fontDes = font.fontDescriptor;
    NSNumber *fontSize = [fontDes objectForKey:@"NSFontSizeAttribute"];
    return [UIFont fontWithName:font.fontName size:IB_HP(fontSize.floatValue)];
}

//adapt UIEdgeInsets
static inline UIEdgeInsets ib_insetsAdaptWithInsets(UIEdgeInsets insets) {
    
    return UIEdgeInsetsMake(IB_HP(insets.top), IB_HP(insets.left), IB_HP(insets.bottom), IB_HP(insets.right));
}


