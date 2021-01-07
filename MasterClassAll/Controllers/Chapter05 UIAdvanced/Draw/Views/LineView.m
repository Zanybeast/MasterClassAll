//
//  LineView.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "LineView.h"

@implementation LineView

- (void)drawRect:(CGRect)rect {
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(ref, 50, 50);
    
    CGContextAddQuadCurveToPoint(ref, 150, 30, 250, 50);
    
    CGContextMoveToPoint(ref, 0, 250);
    
    CGContextAddQuadCurveToPoint(ref, 125, -250, 250, 250);
    
    CGContextStrokePath(ref);
}

@end
