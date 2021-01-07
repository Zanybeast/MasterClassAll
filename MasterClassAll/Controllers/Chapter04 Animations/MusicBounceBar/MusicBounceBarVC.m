//
//  MusicBounceBarVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/6.
//

#import "MusicBounceBarVC.h"

#define BAR_WIDTH 10
#define RANDOM_BAR_WIDTH 5

@interface MusicBounceBarVC ()

@property (weak, nonatomic) IBOutlet UIView *barView;
@property (weak, nonatomic) IBOutlet UIView *randomBarView;

@end

@implementation MusicBounceBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addOneColorBar];
    [self addRandomBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)addRandomBar {
    int count = self.randomBarView.bounds.size.width / RANDOM_BAR_WIDTH;
    ZLog(@"count: %d", count);
    for (int i = 0; i < count; i++) {
        CGFloat offset = RANDOM_BAR_WIDTH * (i + 1);
        
        CALayer *subLayer = [self createSubLayerWithOffset:offset];
        [self.randomBarView.layer addSublayer:subLayer];
    }
}

- (CALayer *)createSubLayerWithOffset: (CGFloat)offset {
    CALayer *subLayer = [CALayer layer];
    
    subLayer.anchorPoint = CGPointMake(0.5, 1);
    subLayer.position = CGPointMake(offset, self.barView.bounds.size.height);
    subLayer.bounds = CGRectMake(0, 0, RANDOM_BAR_WIDTH, arc4random_uniform(100) + 10);
    subLayer.backgroundColor = [UIColor randomColor].CGColor;
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @RANDOM_FLOAT_VAL;
    anim.duration = RANDOM_FLOAT_VAL;
    anim.repeatCount = MAXFLOAT;
    anim.autoreverses = YES;
    
    [subLayer addAnimation:anim forKey:nil];
    
    return subLayer;
}

- (void)addOneColorBar {
    //可以添加重复子层的图层
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.frame = self.barView.bounds;
    
    //先创建一个可以复制的子图层
    CALayer *subLayer = [CALayer layer];
    
    subLayer.anchorPoint = CGPointMake(0.5, 1);
    subLayer.position = CGPointMake(BAR_WIDTH / 2, self.barView.bounds.size.height);
    subLayer.bounds = CGRectMake(0, 0, BAR_WIDTH, 80);
    subLayer.backgroundColor = [UIColor whiteColor].CGColor;
    //给子图层添加动画效果
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0.1;
    anim.duration = 0.5;
    anim.repeatCount = MAXFLOAT;
    anim.autoreverses = YES;
    
    [subLayer addAnimation:anim forKey:nil];
    
    [repLayer addSublayer:subLayer];
    
    [self.barView.layer addSublayer:repLayer];
    
    //设置重复图层的属性
    repLayer.instanceCount = 10;
    repLayer.instanceTransform = CATransform3DMakeTranslation(BAR_WIDTH, 0, 0);    //复制图层的相对偏移量, 是在哪个轴偏移
    repLayer.instanceDelay = 0.1;       //复制图层动画延迟时间
    
    //可以在这里设置子图层的颜色以及每个复制子图层的颜色偏移
    repLayer.instanceColor = [UIColor greenColor].CGColor;
    repLayer.instanceGreenOffset = -0.1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
