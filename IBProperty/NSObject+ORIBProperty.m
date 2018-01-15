//
//  NSObject+ORIBProperty.m
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/12/15.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import "NSObject+ORIBProperty.h"
#import "ORIBProperty.h"

@interface NSObject()

@property (nonatomic, copy) void(^blcok)(void);

@end

@implementation NSObject (ORIBProperty)

- (void)method_exchangeWithSelector:(SEL)selector toSelector:(SEL)toSector {
    
    Method old = class_getInstanceMethod([self class], selector);
    Method new = class_getInstanceMethod([self class], toSector);
    
    if ([[self class] instancesRespondToSelector:toSector]) {
        method_exchangeImplementations(old, new);
    }
}



@end
