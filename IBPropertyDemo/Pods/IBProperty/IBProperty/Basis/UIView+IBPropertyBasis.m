//
//  UIView+IBPropertyBasis.m
//  Aspects
//
//  Created by 欧阳荣 on 2019/4/1.
//

#import "UIView+IBPropertyBasis.h"
#import "NSObject+ORIBProperty.h"
#import "ORIBProperty.h"

@interface UIImage (IBYYImage)

- (UIImage *)ib_addCornerRadius:(CGFloat)radius andSize:(CGSize)size;

@end

@implementation UIImage (IBYYImage)

- (UIImage *)ib_addCornerRadius:(CGFloat)radius andSize:(CGSize)size {
    
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

@implementation UIView (IBPropertyBasis)

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
    
    if (ib_cornerRadius == 0) {
        return;
    }
    
    self.layer.cornerRadius = ib_cornerRadius;
    
    
    if (ib_cornerRadius == 0) {
        return;
    }
    
    self.layer.cornerRadius = ib_cornerRadius;
    
    if ([self isKindOfClass:[UIImageView class]]) {
        
        UIImageView *imageView = (UIImageView *)self;
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self ib_methodExchangeWithSelector:@selector(setImage:) toSelector:@selector(ib_setImage:)];
        });
        
        
        if (imageView.image) {
            imageView.image = imageView.image;
        }
        IB_WEAKIFY(self);
        
        [self aspect_hookSelector:@selector(setBounds:) withOptions:AspectPositionAfter usingBlock:^(){
            
            IB_STRONGIFY(self);
            
            if ([self isKindOfClass:[UIImageView class]]) {
                UIImageView *imageview = (UIImageView *)self;
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
    
    if (@available(iOS 8.0, *)) {
        if ([self isKindOfClass:[UIVisualEffectView class]]) {
            self.layer.masksToBounds = YES;
        }
    }
    
    return;
}

- (CGFloat)ib_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setIb_cornerCircle:(BOOL)ib_cornerCircle {
    
    if (ib_cornerCircle == YES) {
        
        self.ib_cornerRadius = self.bounds.size.height / 2.0f;
        
        IB_WEAKIFY(self);
        
        [self aspect_hookSelector:@selector(setBounds:) withOptions:AspectPositionAfter usingBlock:^(){
            
            IB_STRONGIFY(self);
            
            self.ib_cornerRadius = self.bounds.size.height / 2.0f;
            
        } error:nil];
    }
    
}

- (BOOL)ib_cornerCircle {
    return self.layer.cornerRadius == self.bounds.size.height / 2.0f;
}

- (void)ib_setImage:(UIImage *)image {
    
    UIImage *aImage = image;
    
    if (!self.layer.masksToBounds && self.ib_cornerRadius > 0) {
        
        CGSize size = self.bounds.size;
        if (size.width == 0 || size.height == 0) {
            size = image.size;
        }
        aImage = [image ib_addCornerRadius:self.layer.cornerRadius andSize:self.bounds.size];
        
        aImage = aImage == nil ? image : aImage;
    }
    [self ib_setImage:aImage];
}


@end
