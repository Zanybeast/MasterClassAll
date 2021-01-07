//
//  MoveAViewVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/28.
//

#import "MoveAViewVC.h"
#import "MovableView.h"
#import "PopupButton.h"

@interface MoveAViewVC ()

@property (weak, nonatomic) IBOutlet PopupButton *popButton;

@end

@implementation MoveAViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popButton.clipsToBounds = NO;
}

- (IBAction)popButtonClicked:(PopupButton *)sender {
    UIButton *dialogue = [UIButton buttonWithType:UIButtonTypeCustom];
    
    dialogue.frame = CGRectMake(0, 0, 200, 200);
    dialogue.center = CGPointMake(120, -100);
    
    [dialogue setImage:[UIImage imageNamed:@"dialogueView"] forState:UIControlStateNormal];
    [dialogue setImage:[UIImage imageNamed:@"kid"] forState:UIControlStateHighlighted];
    
    sender.dialogueView = dialogue;
    [sender addSubview:dialogue];
    
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
