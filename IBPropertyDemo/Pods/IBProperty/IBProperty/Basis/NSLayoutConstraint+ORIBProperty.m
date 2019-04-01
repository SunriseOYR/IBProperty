//
//  NSLayoutConstraint+ORIBProperty.m
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/9.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import "NSLayoutConstraint+ORIBProperty.h"
#import "ORIBProperty.h"

static NSString *ib_adaptXTopConstantKey = @"ib_adaptXTopConstantKey";
static NSString *ib_adaptXBottowConstantKey = @"ib_adaptXBottowConstantKey";


@implementation NSLayoutConstraint (ORIBProperty)

- (void)setIb_adaptConstant:(BOOL)ib_adaptConstant {
    
    if (ib_adaptConstant == YES && self.ib_adaptXTopConstant == NO && self.ib_adaptXBottowConstant == NO ) {
        self.constant = IB_HP(self.constant);
    }
}

- (BOOL)ib_adaptConstant {
    return NO;
}

- (void)setIb_adaptXTopConstant:(BOOL)ib_adaptXTopConstant {
    
    objc_setAssociatedObject(self, &ib_adaptXTopConstantKey, @(ib_adaptXTopConstant), OBJC_ASSOCIATION_ASSIGN);
    
    if (ib_adaptXTopConstant == YES) {
        //iPhone X
        if ([UIScreen mainScreen].bounds.size.height > 800) {
            self.constant += 24;
        }
    }
}

- (BOOL)ib_adaptXTopConstant {
    return [objc_getAssociatedObject(self, &ib_adaptXTopConstantKey) boolValue];
}

- (void)setIb_adaptXBottowConstant:(BOOL)ib_adaptXBottowConstant {
    
    objc_setAssociatedObject(self, &ib_adaptXBottowConstantKey, @(ib_adaptXBottowConstant), OBJC_ASSOCIATION_ASSIGN);
    
    if (ib_adaptXBottowConstant == YES) {
        //iPhone X
        if ([UIScreen mainScreen].bounds.size.height > 800) {
            self.constant += 34;
        }
    }
}

- (BOOL)ib_adaptXBottowConstant {
    return [objc_getAssociatedObject(self, &ib_adaptXBottowConstantKey) boolValue];
}


@end
