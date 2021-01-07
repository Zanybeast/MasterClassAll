//
//  PlateButton.m
//  MasterClassAll
//
//  Created by carl on 2021/1/6.
//

#import "PlateButton.h"

@implementation PlateButton

//寻找最合适的 View
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat buttonW = self.bounds.size.width;
    CGFloat buttonH = self.bounds.size.height;
    
    CGFloat x = 0;
    CGFloat y = buttonH / 2;
    CGFloat w = buttonW;
    CGFloat h = y;
    
    CGRect rect = CGRectMake(x, y, w, h);
    if (CGRectContainsPoint(rect, point)) {
        return nil;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 40;
    CGFloat imageH = 46;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 20;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
