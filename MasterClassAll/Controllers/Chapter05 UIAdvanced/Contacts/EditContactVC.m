//
//  EditContactVC.m
//  MasterClassAll
//
//  Created by carl on 2020/11/27.
//

#import "EditContactVC.h"

@interface EditContactVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation EditContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改信息";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.nameTextField.text = self.contact.name;
    self.phoneTextField.text = self.contact.phoneNumber;
    
    self.nameTextField.enabled = NO;
    self.phoneTextField.enabled = NO;
    
}

- (void)editClicked {
    self.saveButton.hidden = NO;
    
    self.nameTextField.enabled = YES;
    self.phoneTextField.enabled = YES;
}

- (IBAction)saveButtonClicked:(UIButton *)sender {
    NSString *name = self.nameTextField.text;
    NSString *phone = self.phoneTextField.text;
    
    Contact *contact = [Contact initWithName:name phoneNubmer:phone];
    
    self.saveCompleted(contact);
    
    [self.navigationController popViewControllerAnimated:YES];
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
