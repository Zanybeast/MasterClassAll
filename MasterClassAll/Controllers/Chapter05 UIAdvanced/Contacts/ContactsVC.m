//
//  ContactsVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import "ContactsVC.h"
#import "ContactsListVC.h"

@interface ContactsVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UISwitch *recordPasswordSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.loginButton drawCornerWithRadius:15];
    
    self.navigationItem.title = @"登  录";
    
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    self.accountTextField.text = @"carl";
    self.passwordTextField.text = @"533";
    
    [self.accountTextField addTarget:self action:@selector(textFieldChangedText) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textFieldChangedText) forControlEvents:UIControlEventEditingChanged];

    [self.loginButton setEnabled:self.accountTextField.text.length && self.passwordTextField.text.length];
}

#pragma mark - 监听事件
- (void)textFieldChangedText {
    ZLog(@"%@, %@", self.accountTextField.text, self.passwordTextField.text);
    [self.loginButton setEnabled:self.accountTextField.text.length && self.passwordTextField.text.length];
}

//记住密码开关
- (IBAction)recordSwitchChanged:(UISwitch *)sender {
    if (!sender.isOn) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

//自动登录开关
//如果自动登录为开,那么记住密码也一定为开
- (IBAction)autoLoginSwitchChanged:(UISwitch *)sender {
    if (sender.isOn) {
        [self.recordPasswordSwitch setOn:YES animated:YES];
    }
}

#pragma mark - TEXTFIELD DELEGATE
//这个方法不能及时获取 textfield 的内容
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    ZLog(@"%@", textField.text);
    return YES;
}


- (IBAction)loginButtonClicked:(UIButton *)sender {
    
    ContactsListVC *vc = [[ContactsListVC alloc] initWithNibName:@"ContactsListVC" bundle:nil];
    vc.navTitle = self.accountTextField.text;
    [self.navigationController pushViewController:vc animated:YES];

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
