//
//  UIControl+ORIBProperty.m
//  IBPropertyDemo
//
//  Created by OrangesAL on 2018/1/24.
//  Copyright © 2018年 OrangesAL. All rights reserved.
//

#import "UIControl+ORIBProperty.h"
#import "NSObject+ORIBProperty.h"
#import "ORIBProperty.h"

@implementation UIControl (ORIBProperty)

- (void)setIb_reClickEnabled:(BOOL)ib_reClickEnabled {
    
    if (ib_reClickEnabled == YES) {
        IB_WEAKIFY(self);
        [self aspect_hookSelector:@selector(sendAction:to:forEvent:) withOptions:AspectPositionAfter usingBlock:^(){
            IB_STRONGIFY(self);
            self.enabled = NO;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.enabled = YES;
            });
        } error:nil];
    }
}

- (BOOL)ib_reClickEnabled {
    return NO;
}

- (void)setIb_extraTouchArea:(UIEdgeInsets)ib_extraTouchArea {
    [self ib_setAssociateValue:[NSValue valueWithUIEdgeInsets:ib_extraTouchArea] withKey:@selector(setIb_extraTouchArea:)];
}

- (UIEdgeInsets)ib_extraTouchArea {
    return [[self ib_getAssociatedValueForKey:@selector(setIb_extraTouchArea:)] UIEdgeInsetsValue];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    
    CGRect touchRect = CGRectMake(self.bounds.origin.x-self.ib_extraTouchArea.left,
                             self.bounds.origin.y-self.ib_extraTouchArea.top,
                             self.bounds.size.width + (self.ib_extraTouchArea.left + self.ib_extraTouchArea.right),
                             self.bounds.size.height + self.ib_extraTouchArea.top + self.ib_extraTouchArea.bottom);
    
    if (CGRectEqualToRect(touchRect, self.bounds))
    {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(touchRect, point) ? self : nil;
}

@end
