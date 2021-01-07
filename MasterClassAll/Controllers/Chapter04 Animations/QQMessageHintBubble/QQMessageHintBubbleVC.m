//
//  QQMessageHintBubbleVC.m
//  MasterClassAll
//
//  Created by carl on 2021/1/7.
//

#import "QQMessageHintBubbleVC.h"
#import "MessageDotButton.h"

@interface QQMessageHintBubbleVC ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation QQMessageHintBubbleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)createButton:(UIButton *)sender {
    
    ZLog(@"subView count: %ld", self.containerView.subviews.count);
    ZLog(@"subViews: %@", self.containerView.subviews);
    
    for (UIView *item in self.containerView.subviews) {
        [item removeFromSuperview];
    }
    
    if (self.containerView.subviews.count == 0) {
        MessageDotButton *button = [[MessageDotButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        [self.containerView addSubview:button];
        
        button.center = self.containerView.center;
    }
    
    ZLog(@"after subView count: %ld", self.containerView.subviews.count);
    ZLog(@"after subViews: %@", self.containerView.subviews);
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
