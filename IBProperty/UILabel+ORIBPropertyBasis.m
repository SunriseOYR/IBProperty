//
//  UILabel+ORIBPropertyBasis.m
//  Aspects
//
//  Created by 欧阳荣 on 2019/4/1.
//

#import "UILabel+ORIBPropertyBasis.h"
#import "ORIBProperty.h"

@implementation UILabel (ORIBPropertyBasis)

- (void)setIb_adaptFont:(BOOL)ib_adaptFont {
    
    if (ib_adaptFont == YES) {
        self.font = ib_fontAdaptWithFont(self.font);
    }
}

- (BOOL)ib_adaptFont {
    return NO;
}

@end
