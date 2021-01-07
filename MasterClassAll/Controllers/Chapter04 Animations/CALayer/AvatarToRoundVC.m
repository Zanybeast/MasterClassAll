//
//  AvatarToRoundVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/5.
//

#import "AvatarToRoundVC.h"

#define angle2radion(angle) ((angle) / 180.0 * M_PI)

@interface AvatarToRoundVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation AvatarToRoundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonClicked:(UIButton *)sender {
    self.viewContainer.layer.shadowColor = [[UIColor yellowColor] CGColor];
    self.viewContainer.layer.shadowOpacity = 1.0;
    self.viewContainer.layer.shadowRadius = 10;
    
    self.viewContainer.layer.cornerRadius = 100;
    
    self.imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.imageView.layer.borderWidth = 2.0;
    
    self.imageView.layer.cornerRadius = 100;
    self.imageView.layer.masksToBounds = YES;
    
}

- (IBAction)addClicked:(UIButton *)sender {
    CALayer *layer = [CALayer layer];
    
    layer.contents = (id)[UIImage imageNamed: @"button_bg_enable"].CGImage;
    layer.frame = CGRectMake(20, STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT + 20, 240, 60);
    
    [self.view.layer addSublayer:layer];
}

- (IBAction)randomViewClicked:(UIButton *)sender {
    self.blueView.layer.transform = CATransform3DMakeRotation(angle2radion(arc4random_uniform(360) + 1), 0, 0, 1);
    CGFloat ratio = arc4random_uniform(300) / 100.0;
    self.blueView.layer.transform = CATransform3DMakeScale(ratio, ratio, 1);
    
    self.blueView.layer.position = CGPointMake(arc4random_uniform(SCREEN_WIDTH - 60) + 20,
                                               arc4random_uniform(SCREEN_HEIGHT - 60) + STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT);
    
    self.blueView.layer.cornerRadius = arc4random_uniform(30);
    
    self.blueView.layer.borderWidth = arc4random_uniform(10);
    self.blueView.layer.borderColor = [[UIColor randomColor] CGColor];
    
    self.blueView.layer.backgroundColor = [[UIColor randomColor] CGColor];
    
}


@end
