//
//  HeartBeatVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/5.
//

#import "HeartBeatVC.h"

@interface HeartBeatVC ()

@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;

@end

@implementation HeartBeatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)clickedToStartAnimation:(UIButton *)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    animation.keyPath = @"transform.scale";
    
    animation.toValue = @0.5;
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.heartImageView.layer addAnimation:animation forKey:nil];
    
}

- (IBAction)moveAnimationClicked:(UIButton *)sender {
    [self.heartImageView.layer removeAllAnimations];
}

- (IBAction)animationGroupClicked:(UIButton *)sender {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @0.5;
    
    CABasicAnimation *rotation = [CABasicAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.toValue = @(arc4random_uniform(M_PI));
    
    CABasicAnimation *position = [CABasicAnimation animation];
    position.keyPath = @"position";
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(arc4random_uniform(SCREEN_WIDTH), arc4random_uniform(SCREEN_HEIGHT))];
    
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.animations = @[scale, rotation, position];
    
    [self.heartImageView.layer addAnimation:group forKey:nil];
}


@end
