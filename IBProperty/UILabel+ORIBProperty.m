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

- (void)setAdaptFont:(BOOL)adaptFont {
    
    if (adaptFont == true) {
        self.font = fontAdaptWithFont(self.font);
    }
}

- (BOOL)adaptFont {
    return false;
}

- (void)setUnderLine:(BOOL)underLine {
    
    if (underLine == true) {
        
        __weak typeof (self) weakSelf = self;

        [self aspect_hookSelector:@selector(setText:) withOptions:AspectPositionAfter usingBlock:^(){
            
            __strong typeof(weakSelf) strongSelf = weakSelf;

            NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:strongSelf.text];
            [aText addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, aText.length)];
            strongSelf.attributedText = aText;
        } error:nil];
        
    }
}

- (BOOL)underLine {
    return false;
}

- (void)setMiddleLine:(BOOL)middleLine {
    
    if (middleLine == true) {
        
        __weak typeof (self) weakSelf = self;

        [self aspect_hookSelector:@selector(setText:) withOptions:AspectPositionAfter usingBlock:^(){
            
            __strong typeof(weakSelf) strongSelf = weakSelf;

            NSMutableAttributedString *aText = [[NSMutableAttributedString alloc] initWithString:strongSelf.text];
            [aText addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, aText.length)];
            strongSelf.attributedText = aText;
        } error:nil];
        
    }
}

- (BOOL)middleLine {
    return false;
}

@end
