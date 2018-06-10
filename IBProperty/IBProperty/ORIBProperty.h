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

//#define IBWeakObj(x) __weak typeof(x) x##Weak = x;
//#define IBStrongObj(x) __strong typeof(x) x##Strong = x;


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


