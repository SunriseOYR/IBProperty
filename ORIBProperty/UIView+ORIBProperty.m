//
//  UIView+ORIBProperty.m
//  BaidiLuxury
//
//  Created by OrangesAL on 2017/11/8.
//  Copyright © 2017年 OrangesAL. All rights reserved.
//

#import "UIView+ORIBProperty.h"
#import "ORIBProperty.h"

static const NSString *cornerCircleKey = @"cornerCircleKey";

static const NSString *cornerRadiusKey = @"cornerRadiusKey";


@interface UIImage(ORIBProperty)

- (UIImage*)imageAddCornerRadius:(CGFloat)radius andSize:(CGSize)size;

@end

@implementation UIImage(ORIBProperty)

- (UIImage*)imageAddCornerRadius:(CGFloat)radius andSize:(CGSize)size{
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

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return nil;
}

#pragma mark -- cornerRadius

- (void)setCornerRadius:(CGFloat)cornerRadius {
    
    if (self.cornerCircle == false) {
        
        self.layer.cornerRadius = cornerRadius;
        
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

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerCircle:(BOOL)cornerCircle {

    if (cornerCircle == true) {
        
        objc_setAssociatedObject(self, &cornerCircleKey, @(cornerCircle), OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        self.layer.cornerRadius = self.bounds.size.height / 2.0f;
        
        __weak typeof (self) weakSelf = self;

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
    
    if (!self.layer.masksToBounds && self.cornerRadius > 0) {
        
        CGSize size = self.bounds.size;
        if (size.width == 0 || size.height == 0) {
            size = image.size;
        }
        aImage = [image imageAddCornerRadius:self.layer.cornerRadius andSize:self.bounds.size];
        
        aImage = aImage == nil ? image : aImage;
    }
    
    [self ib_setImage:aImage];
}

- (BOOL)cornerCircle {
    return objc_getAssociatedObject(self, &cornerCircleKey);
}

#pragma mark -- shadow

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}


@end
