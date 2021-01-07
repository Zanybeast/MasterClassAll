//
//  MoveImageView.m
//  MasterClassAll
//
//  Created by carl on 2021/1/5.
//

#import "MoveImageView.h"

@interface MoveImageView () <CAAnimationDelegate>

@property (strong, nonatomic) UIBezierPath *path;
@property (assign, nonatomic) CGPoint centerP;

@end

@implementation MoveImageView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint pos = [touch locationInView:self];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    
    self.path = path;
    [path moveToPoint:pos];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touce = [touches anyObject];
    
    CGPoint pos = [touce locationInView:self];
    
    [self.path addLineToPoint:pos];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
    
//    CGPoint curP = [touch locationInView:self];
//    self.centerP = curP;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    anim.path = self.path.CGPath;
    
    anim.duration = 1;
    
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    anim.repeatCount = 1;
    anim.delegate = self;
    
    [[[self.subviews firstObject] layer] addAnimation:anim forKey:nil];
    
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blueColor] set];
    [self.path stroke];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.path = nil;
    [self setNeedsDisplay];
    
//    [self.subviews firstObject].center = self.centerP;
}

@end
