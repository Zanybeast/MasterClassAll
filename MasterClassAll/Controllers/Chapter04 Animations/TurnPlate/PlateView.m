//
//  PlateView.m
//  MasterClassAll
//
//  Created by carl on 2021/1/6.
//

#import "PlateView.h"
#import "PlateButton.h"

@interface PlateView () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *plateImageView;

@property (weak, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) CADisplayLink *link;

@end

@implementation PlateView

//MARK: - 懒加载
- (CADisplayLink *)link {
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(angleChanged)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    
    return _link;
}

+ (instancetype)plateView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.plateImageView.userInteractionEnabled = YES;
    
    //旋转按钮的宽高
    CGFloat buttonW = 68;
    CGFloat buttonH = 143;
    //父 view 本身的宽高
    CGFloat side = self.bounds.size.width;
    
    UIImage *bigImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selectedBigImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    //计算当前使用的图片的像素和点的比例
//    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat scale = 2;
    CGFloat imageW = bigImage.size.width / 12 * scale;
    CGFloat imageH = bigImage.size.height * scale;
    
    //添加轮盘的十二个按钮
    for (int i = 0; i < 12; i++) {
        PlateButton *button = [PlateButton buttonWithType:UIButtonTypeCustom];
        
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.bounds = CGRectMake(0, 0, buttonW, buttonH);
        
        button.layer.position = CGPointMake(side * 0.5, side * 0.5);
        
        CGFloat radion = (30 * i) / 180.0 * M_PI;
        
        button.transform = CGAffineTransformMakeRotation(radion);
        
        [self.plateImageView addSubview:button];
        
        //设置按钮的图片
        //先裁剪图片
        CGRect clipR = CGRectMake(i * imageW, 0, imageW, imageH);
        CGImageRef ref = CGImageCreateWithImageInRect(bigImage.CGImage, clipR);
        
        UIImage *image = [UIImage imageWithCGImage:ref];
        
        [button setImage:image forState:UIControlStateNormal];
        //设置选中状态下的图片
        ref = CGImageCreateWithImageInRect(selectedBigImage.CGImage, clipR);
        image = [UIImage imageWithCGImage:ref];
        
        [button setImage:image forState:UIControlStateSelected];
        
        //设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [self buttonClicked: button];
        }
    }
}
//MARK: - 事件监听
- (void)buttonClicked: (UIButton *)button {
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)angleChanged {
    CGFloat angle = (45.0 / 60.0) / 180 * M_PI;
    self.plateImageView.transform = CGAffineTransformRotate(self.plateImageView.transform, angle);
}

- (IBAction)startPickButtonClicked:(UIButton *)sender {
    self.link.paused = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *anim1 = [self makeRotateWithDuration:0.5 circles:0.5];
    CABasicAnimation *anim2 = [self makeRotateWithDuration:3 circles:15.5];
    CABasicAnimation *anim3 = [self makeRotateWithDuration:2 circles:1];
    
    group.animations = @[anim1, anim2, anim3];
    
    group.delegate = self;
    
    [self.plateImageView.layer addAnimation:anim2 forKey:nil];

}

- (CABasicAnimation *)makeRotateWithDuration: (CGFloat)time circles: (CGFloat)r {
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(M_PI * 2 * r);
    anim.duration = time;
    
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    
    return anim;
}


- (void)startRotate {
    self.link.paused = NO;
}

- (void)pause {
    self.link.paused = YES;
}

//MARK: - 动画代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.link.paused = NO;
//    });
}

@end
