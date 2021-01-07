//
//  TransformVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/22.
//

#import "TransformVC.h"

static int transformCount = 1;

@interface TransformVC ()

@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation TransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)transform_M_PI_4:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        if (transformCount == 5) {
            transformCount = 1;
        }
        
        self.customView.transform = CGAffineTransformMakeRotation(M_PI_2 * (transformCount++));
        
        
    }];
}

- (IBAction)transformAutoRotate:(UIButton *)sender {
   
    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionBeginFromCurrentState animations:^{
        [UIView animateWithDuration:0.5 animations:^{
            self.customView.transform = CGAffineTransformMakeRotation(M_PI_2 * transformCount++);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.customView.transform = CGAffineTransformMakeRotation(M_PI_2 * transformCount++);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.customView.transform = CGAffineTransformMakeRotation(M_PI_2 * transformCount++);
        }];
        [UIView animateWithDuration:0.5 animations:^{
            self.customView.transform = CGAffineTransformMakeRotation(M_PI_2 * transformCount++);
        }];
    } completion:nil];
    
}

- (IBAction)transformStopAutoRotate:(UIButton *)sender {
    self.customView.transform = CGAffineTransformIdentity;
    [self.view.layer removeAllAnimations];
}

- (IBAction)transform_makeTranslation:(UIButton *)sender {
    CGAffineTransform transform = CGAffineTransformMakeTranslation(100, 0);
    self.customView.transform = transform;
}

- (IBAction)transform_makeScale:(UIButton *)sender {
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.customView.transform = transform;
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
