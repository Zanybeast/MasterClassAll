//
//  MessageDotButton.m
//  MasterClassAll
//
//  Created by carl on 2021/1/7.
//

#import "MessageDotButton.h"

#define MAX_DISTANCE 80
@interface MessageDotButton ()

@property (strong, nonatomic) UIView *smallCircle;
@property (assign, nonatomic) CGFloat circleRadius;

@property (weak, nonatomic) CAShapeLayer *shapeLayer;

@property (nonatomic, assign) BOOL toBeAdded;

@end

@implementation MessageDotButton

//MARK: - 懒加载
- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = self.backgroundColor.CGColor;
        
        _shapeLayer = layer;
        
        if (self.superview != nil) {
            [self.superview.layer insertSublayer:layer below:self.layer];
        } else {
            _toBeAdded = YES;
        }
        
    }
    return _shapeLayer;
}

- (UIView *)smallCircle {
    if (_smallCircle == nil) {
        UIView *view = [[UIView alloc] init];
        
        view.backgroundColor = self.backgroundColor;
        
        _smallCircle = view;
        
        [self.superview insertSubview:view belowSubview:self];
    }
    
    return _smallCircle;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

//MARK: - 初始化
- (void)setup {
    CGFloat width = self.bounds.size.width;
    self.circleRadius = width / 2;
    self.layer.cornerRadius = _circleRadius;
    
    //初始化按钮颜色
    [self setTitle:@"10" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor redColor]];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //初始化按钮图层
    self.smallCircle.center =  self.center;
    self.smallCircle.bounds = self.bounds;
    ZLog(@"%@", NSStringFromCGRect(self.smallCircle.bounds));
    self.smallCircle.layer.cornerRadius = width / 2;
}

- (void)pan: (UIPanGestureRecognizer *)pan {
    if (_toBeAdded) {
        [self.superview insertSubview:self.smallCircle belowSubview:self];
        _toBeAdded = NO;
    }
    CGPoint curP = [pan locationInView:self];
    
    CGPoint center = self.center;
    center.x += curP.x;
    center.y += curP.y;
    
    self.center = center;
    
    [pan setTranslation:CGPointZero inView:self];
    
    CGFloat distance = [self calculateDistanceWithBigCenter:self.center smallCenter:self.smallCircle.center];
    
    CGFloat smallRadius = self.circleRadius - distance / 10;
    
    self.smallCircle.bounds = CGRectMake(0, 0, smallRadius * 2, smallRadius * 2);
    self.smallCircle.layer.cornerRadius = self.smallCircle.bounds.size.width / 2;
    
    //拖出距离很远, 路径消失
    if (distance > MAX_DISTANCE) {
        self.smallCircle.hidden = YES;
        
        [self.shapeLayer removeFromSuperlayer];
        self.shapeLayer = nil;
    } else if (distance > 0 && self.smallCircle.hidden == NO) { //拖出不远距离, 显示路径
        self.shapeLayer.path = [self pathWithBigCirCleView:self smallCirCleView:self.smallCircle].CGPath;
    }
    
    //松手后判断拖到哪里
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (distance > MAX_DISTANCE) {
            //显示动画
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            
            NSMutableArray *images = [NSMutableArray array];
            for (int i = 1; i < 9; i++) {
                NSString *imageName = [NSString stringWithFormat:@"blow_%d", i];
                UIImage *image = [UIImage imageNamed:imageName];
                [images addObject:image];
            }
            
            imageView.animationImages = images;
            imageView.animationRepeatCount = 1;
            imageView.animationDuration = 0.8;
            
            [self addSubview:imageView];
            
            [imageView startAnimating];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self removeFromSuperview];
                self.smallCircle = nil;
            });
        } else {
            [self.shapeLayer removeFromSuperlayer];
            self.shapeLayer = nil;
            
            [UIView animateWithDuration:0.5 delay:0
                 usingSpringWithDamping:0.2
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                self.center = self.smallCircle.center;
            } completion:^(BOOL finished) {
                self.smallCircle.hidden = NO;
            }];
        }
    }
}


//MARK: - 计算两圆心位置
- (CGFloat)calculateDistanceWithBigCenter: (CGPoint)bCenter smallCenter: (CGPoint)sCenter {
    CGFloat offsetX = bCenter.x - sCenter.x;
    CGFloat offsetY = bCenter.y - sCenter.y;
    
    return sqrt(offsetX * offsetX + offsetY * offsetY);
}

//MARK: - 画矩形
- (UIBezierPath *)pathWithBigCirCleView:(UIView *)bigCirCleView  smallCirCleView:(UIView *)smallCirCleView
{
    CGPoint bigCenter = bigCirCleView.center;
    CGFloat x2 = bigCenter.x;
    CGFloat y2 = bigCenter.y;
    CGFloat r2 = bigCirCleView.bounds.size.width / 2;
    
    CGPoint smallCenter = smallCirCleView.center;
    CGFloat x1 = smallCenter.x;
    CGFloat y1 = smallCenter.y;
    CGFloat r1 = smallCirCleView.bounds.size.width / 2;
    
    
    
    // 获取圆心距离
    CGFloat d = [self calculateDistanceWithBigCenter:bigCenter smallCenter:smallCenter];
    
    CGFloat sinθ = (x2 - x1) / d;
    
    CGFloat cosθ = (y2 - y1) / d;
    
    // 坐标系基于父控件
    CGPoint pointA = CGPointMake(x1 - r1 * cosθ , y1 + r1 * sinθ);
    CGPoint pointB = CGPointMake(x1 + r1 * cosθ , y1 - r1 * sinθ);
    CGPoint pointC = CGPointMake(x2 + r2 * cosθ , y2 - r2 * sinθ);
    CGPoint pointD = CGPointMake(x2 - r2 * cosθ , y2 + r2 * sinθ);
    CGPoint pointO = CGPointMake(pointA.x + d / 2 * sinθ , pointA.y + d / 2 * cosθ);
    CGPoint pointP =  CGPointMake(pointB.x + d / 2 * sinθ , pointB.y + d / 2 * cosθ);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // A
    [path moveToPoint:pointA];
    
    // AB
    [path addLineToPoint:pointB];
    
    // 绘制BC曲线
    [path addQuadCurveToPoint:pointC controlPoint:pointP];
    
    // CD
    [path addLineToPoint:pointD];
    
    // 绘制DA曲线
    [path addQuadCurveToPoint:pointA controlPoint:pointO];
    
    return path;
    
}

@end
