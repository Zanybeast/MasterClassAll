//
//  HeroDetailVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/1.
//

#import "HeroDetailVC.h"

@interface HeroDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *intro;

@property (weak, nonatomic) IBOutlet UIView *foregroundView;

@end

@implementation HeroDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.avatar.image = [UIImage imageNamed: self.hero.icon];
    self.name.text = self.hero.name;
    self.intro.text = self.hero.intro;
    
    UITapGestureRecognizer *gestureRecg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backToMain)];
    [self.foregroundView addGestureRecognizer:gestureRecg];
}

- (void)backToMain {
    [self.navigationController popViewControllerAnimated:NO];
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
