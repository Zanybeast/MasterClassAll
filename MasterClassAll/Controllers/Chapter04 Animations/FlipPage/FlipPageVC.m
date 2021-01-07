//
//  FlipPageVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/5.
//

#import "FlipPageVC.h"

static int pageNum = 2;

@interface FlipPageVC () <CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) BOOL isFinished;

@end

@implementation FlipPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFinished = YES;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)flipPage:(UIButton *)sender {
    
    if (self.isFinished) {
        if (pageNum == 4) {
            pageNum = 1;
        }
        
        NSString *imageName = [NSString stringWithFormat: @"flipPage_%d", pageNum];
        
        self.imageView.image = [UIImage imageNamed:imageName];
        ++pageNum;
        
        CATransition *anim = [CATransition animation];
        
        anim.type = @"pageCurl";
        
        anim.duration = 0.5;
        anim.delegate = self;
        
        [self.imageView.layer addAnimation:anim forKey:nil];
        
        self.isFinished = NO;
    }
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.isFinished = YES;
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
