//
//  DrawDotView.m
//  MasterClassAll
//
//  Created by carl on 2021/1/7.
//

#import "DrawDotView.h"

static int instanceCount = 0;

@interface DrawDotView ()

@property (strong, nonatomic) UIBezierPath *path;

@property (weak, nonatomic) CALayer *subLayer;
@property (weak, nonatomic) CAReplicatorLayer *replLayer;

@end

@implementation DrawDotView

//MARK: - 懒加载
- (CALayer *)subLayer {
    if (_subLayer == nil) {
        CALayer *layer = [CALayer layer];
        
        CGFloat width = 10;
        layer.frame = CGRectMake(0, -1000, width, width);
        layer.cornerRadius = 5;
        layer.masksToBounds = YES;
        
        layer.backgroundColor = [UIColor blueColor].CGColor;
        [_replLayer addSublayer:layer];
        
        _subLayer = layer;
    }
    return _subLayer;
}

- (UIBezierPath *)path {
    if (_path == nil) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

//MARK: - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    CAReplicatorLayer *replL = [CAReplicatorLayer layer];
    
    [self.layer addSublayer:replL];
    
    self.replLayer = replL;
}

//MARK: - 触摸画线
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    [self.path moveToPoint:curP];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint curP = [touch locationInView:self];
    
    [self.path addLineToPoint:curP];
    [self setNeedsDisplay];
    
    ++instanceCount;
}

//MARK: - 方法回调
- (void)startDraw {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    anim.path = self.path.CGPath;
    
    anim.duration = 3.0;
    anim.repeatCount = MAXFLOAT;
    
    [self.subLayer addAnimation:anim forKey:nil];
    
    self.replLayer.instanceCount = instanceCount;
    self.replLayer.instanceDelay = 0.2;
}

- (void)reDraw {
    self.path = nil;
    [self setNeedsDisplay];
    
    [self.subLayer removeFromSuperlayer];
    self.subLayer = nil;
    
    instanceCount = 0;
}

- (void)drawRect:(CGRect)rect {
    [self.path stroke];
}

@end
