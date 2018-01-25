//
//  UIButton+ORIBProperty.m
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/21.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import "UIButton+ORIBProperty.h"
#import "ORIBProperty.h"

@implementation UIButton (ORIBProperty)

- (void)setIb_adaptInsets:(BOOL)ib_adaptInsets {
    
    if (ib_adaptInsets == YES) {
        
        self.contentEdgeInsets = insetsAdaptWithInsets(self.contentEdgeInsets);
        self.titleEdgeInsets = insetsAdaptWithInsets(self.titleEdgeInsets);
        self.imageEdgeInsets = insetsAdaptWithInsets(self.imageEdgeInsets);
    }
}

- (BOOL)ib_adaptInsets {
    return NO;
}

- (void)setIb_adaptFont:(BOOL)ib_adaptFont {
    
    if (ib_adaptFont == YES) {
        self.titleLabel.ib_adaptFont = YES;
    }
}

- (BOOL)ib_adaptFont {
    return NO;
}


@end