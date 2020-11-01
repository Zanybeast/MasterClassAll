//
//  UIView+Extension.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (instancetype)drawCornerWithRadius:(CGFloat)r {
    self.layer.cornerRadius = r;
    self.layer.masksToBounds = YES;
    return self;
}

- (instancetype)drawHalfWidthCorner {
    CGFloat r = self.bounds.size.width / 2;
    self.layer.cornerRadius = r;
    self.layer.masksToBounds = YES;
    return self;
}

@end
