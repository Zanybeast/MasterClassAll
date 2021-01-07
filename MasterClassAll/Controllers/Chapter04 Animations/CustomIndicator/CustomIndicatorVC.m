//
//  CustomIndicatorVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/7.
//

#import "CustomIndicatorVC.h"

@interface CustomIndicatorVC ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation CustomIndicatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addLayerToView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)addLayerToView {
    CGFloat duration = 1.0;
    int subCount = 30;
    
    CAReplicatorLayer *replLayer = [CAReplicatorLayer layer];
    replLayer.frame = self.backgroundView.bounds;
    
    //创建子图层
    CALayer *subLayer = [CALayer layer];
    
    subLayer.bounds = CGRectMake(0, 0, 10, 10);
    subLayer.position = CGPointMake(self.backgroundView.bounds.size.width / 2, 20);
    subLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    subLayer.transform = CATransform3DMakeScale(0, 0, 0);
    subLayer.cornerRadius = 5;
    subLayer.masksToBounds = YES;
    
    //添加动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @1;
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = duration;
    
    [subLayer addAnimation:anim forKey:nil];
    
    [replLayer addSublayer:subLayer];
    
    //设置重复图层的属性
    replLayer.instanceCount = subCount;
    replLayer.instanceDelay = duration / subCount;
    
    CGFloat angle = M_PI * 2 / subCount;
    replLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    
    [self.backgroundView.layer addSublayer:replLayer];
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
