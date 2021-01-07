//
//  LUIApplicationVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/26.
//

#import "LUIApplicationVC.h"

@interface LUIApplicationVC ()

@property (assign, nonatomic) BOOL hideStatusBar;


@end

@implementation LUIApplicationVC

- (BOOL)prefersStatusBarHidden {
    return _hideStatusBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.hideStatusBar = YES;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.hideStatusBar = NO;
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)openUrlClicked:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"https://news.163.com"];
    
    [[UIApplication sharedApplication] openURL:url
                                       options:@{}
                             completionHandler:nil];
}

- (IBAction)hideStatusBarClicked:(UIButton *)sender {
    
    if (self.hideStatusBar == YES) {
        self.hideStatusBar = NO;
        self.navigationController.navigationBarHidden = NO;
        
        } else {
            self.hideStatusBar = YES;
            self.navigationController.navigationBarHidden = YES;
        }
}

- (IBAction)createAWindowClicked:(UIButton *)sender {
    
    [[UIApplication sharedApplication] windows][0].hidden = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] windows][0].hidden = NO;
    });
    
    
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
