//
//  ShapeView.m
//  MasterClassAll
//
//  Created by carl on 2020/12/5.
//

#import "ShapeView.h"

@implementation ShapeView

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(125, 125);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:125 startAngle:0 endAngle:M_PI * 1.7 clockwise:YES];
    [path addLineToPoint:center];
    [path fill];
}

@end
