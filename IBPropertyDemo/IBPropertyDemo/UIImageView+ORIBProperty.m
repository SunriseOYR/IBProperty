//
//  UIImageView+ORIBProperty.m
//  IBPropertyDemo
//
//  Created by OrangesAL on 2018/1/31.
//  Copyright © 2018年 OrangesAL. All rights reserved.
//

#import "UIImageView+ORIBProperty.h"
#import <UIView+ORIBProperty.h>
#import <ORIBProperty.h>

static NSInteger const effectViewTag = 2018;

@implementation UIImageView (ORIBProperty)

- (void)setIb_lightEffect:(BOOL)ib_lightEffect {
    
    if (ib_lightEffect == YES) {
        [self addEffectWithStyle:UIBlurEffectStyleLight];
    }
}

- (BOOL)ib_lightEffect {
    return NO;
}

- (void)setIb_darkEffect:(BOOL)ib_darkEffect {
    if (ib_darkEffect == YES) {
        [self addEffectWithStyle:UIBlurEffectStyleDark];
    }
}

- (BOOL)ib_darkEffect {
    return  NO;
}

- (void)setIb_effectAlpha:(CGFloat)ib_effectAlpha {
    if (ib_effectAlpha > 0) {
        UIVisualEffectView *effectView = [self viewWithTag:effectViewTag];
        effectView.alpha = ib_effectAlpha > 1 ? 1 : ib_effectAlpha;
    }
}

- (CGFloat)ib_effectAlpha {
    return [self viewWithTag:effectViewTag].alpha;
}


#pragma mark -- private
- (void)addEffectWithStyle:(UIBlurEffectStyle)style{
    
    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:style];
    
    UIVisualEffectView *effectView = [self viewWithTag:effectViewTag];
    
    if (!effectView) {
        effectView = [self ib_creatEffectViewWithEffect:effect];
    }else {
        if (@available(iOS 9, *)) {
            effectView.effect = effect;
        }else {
            [effectView removeFromSuperview];
            effectView = [self ib_creatEffectViewWithEffect:effect];
        }
    }
}

- (UIVisualEffectView *)ib_creatEffectViewWithEffect:(UIBlurEffect *)effect {
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.bounds;
    effectView.tag = effectViewTag;
    effectView.alpha = 0.5;
    [self addSubview:effectView];
    effectView.ib_cornerCircle = self.ib_cornerCircle;
    effectView.ib_cornerRadius = self.ib_cornerRadius;
    __weak typeof (self) weakSelf = self;
    [self aspect_hookSelector:@selector(setBounds:) withOptions:AspectPositionAfter usingBlock:^{
        effectView.frame = weakSelf.bounds;
    } error:nil];
    
    return effectView;
}

- (UIBlurEffect *)ib_currentEffectStyle {
    
    UIVisualEffectView *effectView = [self viewWithTag:effectViewTag];
    return (UIBlurEffect *)effectView.effect;
}

@end
