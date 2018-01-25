//
//  UIView+ORIBProperty.m
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/8.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import "UIView+ORIBProperty.h"
#import "ORIBProperty.h"

static const NSString *ib_cornerCircleKey = @"ib_cornerCircleKey";

static const NSString *ib_cornerRadiusKey = @"ib_cornerRadiusKey";


@interface UIImage(ORIBProperty)

- (UIImage*)imageAddib_cornerRadius:(CGFloat)radius andSize:(CGSize)size;

@end

@implementation UIImage(ORIBProperty)

- (UIImage*)imageAddib_cornerRadius:(CGFloat)radius andSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

@implementation UIView (ORIBProperty)

#pragma mark -- border

- (void)setIb_borderWidth:(CGFloat)ib_borderWidth {
    if (ib_borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = ib_borderWidth;
}

- (CGFloat)ib_borderWidth {
    return self.layer.borderWidth;
}

- (void)setIb_borderColor:(UIColor *)ib_borderColor {
    self.layer.borderColor = ib_borderColor.CGColor;
}

- (UIColor *)ib_borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

#pragma mark -- ib_cornerRadius

- (void)setIb_cornerRadius:(CGFloat)ib_cornerRadius {
    
    if (self.ib_cornerCircle == NO) {
        
        self.layer.cornerRadius = ib_cornerRadius;
        
        if ([self isKindOfClass:[UIImageView class]]) {
            
            [self method_exchangeWithSelector:@selector(setImage:) toSelector:@selector(ib_setImage:)];
            
            __weak typeof (self) weakSelf = self;
            
            [self aspect_hookSelector:@selector(setBounds:) withOptions:AspectPositionAfter usingBlock:^(){
                
                __strong typeof(weakSelf) strongSelf = weakSelf;
                
                if ([strongSelf isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageview = (UIImageView *)strongSelf;
                    imageview.image = imageview.image;
                }
            } error:nil];
        }
        
        if ([self isKindOfClass:[UILabel class]]) {
            self.layer.masksToBounds = YES;
        }
        
        if ([self isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)self;
            if (button.currentImage || button.currentBackgroundImage) {
                self.layer.masksToBounds = YES;
            }
        }
        
    }
}

- (CGFloat)ib_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setIb_cornerCircle:(BOOL)ib_cornerCircle {

    if (ib_cornerCircle == YES) {
        
        objc_setAssociatedObject(self, &ib_cornerCircleKey, @(ib_cornerCircle), OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        self.layer.cornerRadius = self.bounds.size.height / 2.0f;
        
        if ([self isKindOfClass:[UIImageView class]]) {
            [self method_exchangeWithSelector:@selector(setImage:) toSelector:@selector(ib_setImage:)];
        }
        
        if ([self isKindOfClass:[UILabel class]]) {
            self.layer.masksToBounds = YES;
        }
        
        if ([self isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)self;
            if (button.currentImage || button.currentBackgroundImage) {
                self.layer.masksToBounds = YES;
            }
        }
        
        __weak typeof (self) weakSelf = self;

        [self aspect_hookSelector:@selector(setBounds:) withOptions:AspectPositionAfter usingBlock:^(){
            
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            strongSelf.layer.cornerRadius = strongSelf.bounds.size.height / 2.0f;
            
            if ([strongSelf isKindOfClass:[UIImageView class]]) {
                UIImageView *imageview = (UIImageView *)strongSelf;
                imageview.image = imageview.image;
            }
            
        } error:nil];
    }
    
}

- (void)ib_setImage:(UIImage *)image {
    
    UIImage *aImage = image;
    
    if (!self.layer.masksToBounds && self.ib_cornerRadius > 0) {
        
        CGSize size = self.bounds.size;
        if (size.width == 0 || size.height == 0) {
            size = image.size;
        }
        aImage = [image imageAddib_cornerRadius:self.layer.cornerRadius andSize:self.bounds.size];
        
        aImage = aImage == nil ? image : aImage;
    }
    
    [self ib_setImage:aImage];
}

- (BOOL)ib_cornerCircle {
    return objc_getAssociatedObject(self, &ib_cornerCircleKey);
}

#pragma mark -- shadow

- (void)setIb_shadowColor:(UIColor *)ib_shadowColor {
    self.layer.shadowColor = ib_shadowColor.CGColor;
}

- (UIColor *)ib_shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setIb_shadowOffset:(CGSize)ib_shadowOffset {
    self.layer.shadowOffset = ib_shadowOffset;
}

- (CGSize)ib_shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setIb_shadowOpacity:(CGFloat)ib_shadowOpacity {
    self.layer.shadowOpacity = ib_shadowOpacity;
}

- (CGFloat)ib_shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setIb_shadowRadius:(CGFloat)ib_shadowRadius {
    self.layer.shadowRadius = ib_shadowRadius;
}

- (CGFloat)ib_shadowRadius {
    return self.layer.shadowRadius;
}


@end
