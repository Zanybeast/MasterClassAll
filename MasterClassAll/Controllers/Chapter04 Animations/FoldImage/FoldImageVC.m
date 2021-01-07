//
//  FoldImageVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/6.
//

#import "FoldImageVC.h"

#define IMAGE_HEIGHT 240

@interface FoldImageVC ()

@property (weak, nonatomic) IBOutlet UIImageView *bottomImage;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIView *dragView;

@property (weak, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation FoldImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置显示图片的尺寸,让顶部显示图片的上半部分, 底部显示下半部分
    self.topImage.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.topImage.layer.anchorPoint = CGPointMake(0.5, 1);
    
    self.bottomImage.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.bottomImage.layer.anchorPoint = CGPointMake(0.5, 0);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self.dragView addGestureRecognizer:pan];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = self.bottomImage.bounds;
    
    gradient.opacity = 0;
    gradient.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    self.gradientLayer = gradient;
    
    [self.bottomImage.layer addSublayer:gradient];
    
}

- (void)pan: (UIPanGestureRecognizer *)pan {
    CGPoint curP = [pan translationInView:self.dragView];
    //旋转的方向根据手势偏移量求出,
    CGFloat angle = -curP.y / IMAGE_HEIGHT * M_PI;
    
    CATransform3D transform = CATransform3DIdentity;
    
    
    transform.m34 = -1 / 500.0;
    transform = CATransform3DRotate(transform, angle, 1, 0, 0);
    
    self.topImage.layer.transform = transform;
//    self.topImage.layer.doubleSided = NO;
    
    self.gradientLayer.opacity = curP.y / IMAGE_HEIGHT;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        //弹簧效果, 松手时来回震动
        [UIView animateWithDuration:0.8
                              delay:0
             usingSpringWithDamping:0.2
              initialSpringVelocity:10
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            self.topImage.layer.transform = CATransform3DIdentity;
            self.gradientLayer.opacity = 0.0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

@end
