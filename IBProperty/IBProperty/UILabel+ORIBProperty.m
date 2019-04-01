//
//  UILabel+ORIBProperty.m
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/8.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import "UILabel+ORIBProperty.h"
#import "ORIBProperty.h"

@implementation UILabel (ORIBProperty)

- (void)setIb_adaptFont:(BOOL)ib_adaptFont {
    
    if (ib_adaptFont == YES) {
        self.font = ib_fontAdaptWithFont(self.font);
    }
}

- (BOOL)ib_adaptFont {
    return NO;
}

- (void)setIb_underLine:(BOOL)ib_underLine {
    
    if (ib_underLine == YES) {
        
        [self setAttributedWirhAttributeName:NSUnderlineStyleAttributeName];
        
        IB_WEAKIFY(self);

        [self aspect_hookSelector:@selector(setText:) withOptions:AspectPositionAfter usingBlock:^(){
            IB_STRONGIFY(self);
            [self setAttributedWirhAttributeName:NSUnderlineStyleAttributeName];
        } error:nil];
        
    }
}

- (BOOL)ib_underLine {
    return NO;
}

- (void)setIb_middleLine:(BOOL)ib_middleLine {
    
    if (ib_middleLine == YES) {
        
        [self setAttributedWirhAttributeName:NSStrikethroughStyleAttributeName];
        
        IB_WEAKIFY(self);

        [self aspect_hookSelector:@selector(setText:) withOptions:AspectPositionAfter usingBlock:^(){
            IB_STRONGIFY(self);
            [self setAttributedWirhAttributeName:NSStrikethroughStyleAttributeName];
        } error:nil];
        
    }
}

- (BOOL)ib_middleLine {
    return NO;
}

- (void)setAttributedWirhAttributeName:(NSString *)key {
    
    NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:self.text];
    [aText addAttribute:key value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, aText.length)];
    self.attributedText = aText;
}

@end
